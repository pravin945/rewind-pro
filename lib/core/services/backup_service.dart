import 'dart:io';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../database/app_database.dart';
import '../database/daos/settings_dao.dart';

class BackupResult {
  final bool isSuccess;
  final String message;
  final String? filePath;
  final int? fileSize;

  BackupResult({
    required this.isSuccess,
    required this.message,
    this.filePath,
    this.fileSize,
  });
}

class BackupService {
  final AppDatabase db;
  final SettingsDao settingsDao;

  BackupService({required this.db, required this.settingsDao});

  /// Check whether a file is a valid SQLite 3 database by reading its header
  static bool isValidSqliteFile(File file) {
    if (!file.existsSync() || file.lengthSync() < 16) return false;
    final raf = file.openSync();
    try {
      final bytes = raf.readSync(16);
      final headerStr = String.fromCharCodes(bytes);
      return headerStr.startsWith('SQLite format 3');
    } finally {
      raf.closeSync();
    }
  }

  /// Create local backup file with WAL checkpoint and verify integrity
  Future<BackupResult> createLocalBackup() async {
    try {
      // 1. Checkpoint SQLite WAL to flush all transactions to disk
      try {
        await db.customStatement('PRAGMA wal_checkpoint(FULL);');
      } catch (_) {}

      // 2. Locate active database file
      final docsDir = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(docsDir.path, 'motorshop_manager.sqlite'));

      if (!dbFile.existsSync()) {
        return BackupResult(
          isSuccess: false,
          message: 'डेटाबेस फाईल सापडली नाही (Database file not found).',
        );
      }

      // 3. Prepare backup destination folder
      final backupDir = Directory(p.join(docsDir.path, 'backups'));
      if (!backupDir.existsSync()) {
        backupDir.createSync(recursive: true);
      }

      // 4. Copy database
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final backupFileName = 'motorshop_backup_$timestamp.db';
      final backupPath = p.join(backupDir.path, backupFileName);
      final backupFile = await dbFile.copy(backupPath);

      // 5. Verify integrity
      if (!isValidSqliteFile(backupFile)) {
        return BackupResult(
          isSuccess: false,
          message: 'बॅकअप फाईलची पडताळणी अयशस्वी झाली (Backup integrity check failed).',
        );
      }

      final fileSize = backupFile.lengthSync();

      // 6. Record in history
      await settingsDao.recordBackupHistory(
        BackupHistoriesCompanion.insert(
          backupType: const Value('local'),
          fileName: backupFileName,
          fileSize: fileSize,
          backupDate: Value(DateTime.now()),
          status: 'success',
        ),
      );

      // 7. Update settings last backup
      await settingsDao.updateBackupTimestamp(DateTime.now(), 'success');

      return BackupResult(
        isSuccess: true,
        message: 'बॅकअप यशस्वीरीत्या तयार झाला ($backupFileName)',
        filePath: backupPath,
        fileSize: fileSize,
      );
    } catch (e) {
      await settingsDao.updateBackupTimestamp(DateTime.now(), 'failed');
      return BackupResult(
        isSuccess: false,
        message: 'बॅकअप त्रुटी: $e',
      );
    }
  }

  /// Create backup and trigger native share sheet (WhatsApp, Drive, Email, etc.)
  Future<BackupResult> exportAndShareBackup() async {
    final result = await createLocalBackup();
    if (!result.isSuccess || result.filePath == null) {
      return result;
    }

    try {
      final xFile = XFile(result.filePath!);
      await Share.shareXFiles(
        [xFile],
        text: 'RewindPro Offline Data Backup (${p.basename(result.filePath!)})',
        subject: 'RewindPro Backup',
      );
      return result;
    } catch (e) {
      return BackupResult(
        isSuccess: true,
        message: 'बॅकअप तयार झाला परंतु शेअर करता आले नाही: $e',
        filePath: result.filePath,
        fileSize: result.fileSize,
      );
    }
  }

  /// List all local backup files sorted by date descending
  Future<List<File>> getLocalBackupFiles() async {
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final backupDir = Directory(p.join(docsDir.path, 'backups'));
      if (!backupDir.existsSync()) return [];

      final files = backupDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.db'))
          .toList();

      files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
      return files;
    } catch (_) {
      return [];
    }
  }

  /// Restore database from an existing backup file
  Future<BackupResult> restoreFromFile(File backupFile) async {
    try {
      if (!backupFile.existsSync()) {
        return BackupResult(
          isSuccess: false,
          message: 'निवडलेली बॅकअप फाईल अस्तित्वात नाही (File does not exist).',
        );
      }

      // Check SQLite header
      if (!isValidSqliteFile(backupFile)) {
        return BackupResult(
          isSuccess: false,
          message: 'अवैध बॅकअप फाईल (Invalid SQLite database format).',
        );
      }

      final docsDir = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(docsDir.path, 'motorshop_manager.sqlite'));

      // Copy backup over active DB
      await backupFile.copy(dbFile.path);

      // Record restore history
      final fileName = p.basename(backupFile.path);
      await settingsDao.recordBackupHistory(
        BackupHistoriesCompanion.insert(
          backupType: const Value('restore'),
          fileName: fileName,
          fileSize: backupFile.lengthSync(),
          backupDate: Value(DateTime.now()),
          status: 'success',
        ),
      );

      return BackupResult(
        isSuccess: true,
        message: 'डेटा यशस्वीरीत्या रिस्टोर केला गेला ($fileName). कृपया ॲप पुन्हा सुरू करा.',
      );
    } catch (e) {
      return BackupResult(
        isSuccess: false,
        message: 'रिस्टोर त्रुटी: $e',
      );
    }
  }
}
