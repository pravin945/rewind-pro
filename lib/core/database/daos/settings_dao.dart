import 'package:drift/drift.dart';
import '../app_database.dart';

class SettingsDao {
  final AppDatabase db;

  SettingsDao(this.db);

  Stream<BusinessSetting> watchSettings() {
    return (db.select(db.businessSettings)..limit(1)).watchSingle();
  }

  Future<BusinessSetting> getSettings() async {
    final existing = await (db.select(db.businessSettings)..limit(1)).getSingleOrNull();
    if (existing != null) return existing;

    // Insert default if none exists
    final id = await db.into(db.businessSettings).insert(
          BusinessSettingsCompanion.insert(
            shopName: const Value('Pratap Electricals & Motor Rewinding (प्रताप इलेक्ट्रिकल्स)'),
            ownerName: const Value('Dinesh Jadhav (दिनेश जाधव)'),
            shopAddress: const Value('फाकटे, तालुका शिरूर, जिल्हा पुणे'),
            mobileNumber: const Value('9623314436'),
            invoicePrefix: const Value('INV-'),
            jobPrefix: const Value('JOB-'),
            defaultTaxRate: const Value(0.0),
            isGstEnabled: const Value(false),
            currency: const Value('₹'),
            defaultLanguage: const Value('mr_en'),
          ),
        );

    return (db.select(db.businessSettings)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateSettings(BusinessSettingsCompanion settings) {
    return db.transaction(() async {
      final updated = await (db.update(db.businessSettings)..where((tbl) => tbl.id.equals(1))).write(
        settings.copyWith(updatedAt: Value(DateTime.now())),
      );

      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'UPDATE_SETTINGS',
              targetEntity: 'BusinessSettings',
              entityId: const Value(1),
              details: const Value('Updated business settings'),
            ),
          );

      return updated > 0;
    });
  }

  Future<void> updateBackupTimestamp(DateTime timestamp, String status) {
    return (db.update(db.businessSettings)..where((tbl) => tbl.id.equals(1))).write(
      BusinessSettingsCompanion(
        lastBackupTimestamp: Value(timestamp),
        lastBackupStatus: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  // Backup history
  Future<int> recordBackupHistory(BackupHistoriesCompanion history) {
    return db.into(db.backupHistories).insert(history);
  }

  Future<List<BackupHistory>> getBackupHistories({int limit = 20}) {
    return (db.select(db.backupHistories)
          ..orderBy([(t) => OrderingTerm(expression: t.backupDate, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }
}

