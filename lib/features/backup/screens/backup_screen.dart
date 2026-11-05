import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/services/backup_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

final backupHistoryProvider = FutureProvider.autoDispose<List<BackupHistory>>((ref) {
  return ref.watch(settingsDaoProvider).getBackupHistories();
});

final availableLocalBackupsProvider = FutureProvider.autoDispose<List<File>>((ref) {
  return ref.watch(backupServiceProvider).getLocalBackupFiles();
});

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _isProcessing = false;

  void _refresh() {
    ref.invalidate(backupHistoryProvider);
    ref.invalidate(availableLocalBackupsProvider);
    ref.invalidate(businessSettingsStreamProvider);
  }

  Future<void> _handleCreateAndShare() async {
    setState(() => _isProcessing = true);
    final backupService = ref.read(backupServiceProvider);
    final result = await backupService.exportAndShareBackup();
    setState(() => _isProcessing = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: result.isSuccess ? AppTheme.successGreen : AppTheme.errorRed,
        ),
      );
      _refresh();
    }
  }

  Future<void> _handleSaveLocalOnly() async {
    setState(() => _isProcessing = true);
    final backupService = ref.read(backupServiceProvider);
    final result = await backupService.createLocalBackup();
    setState(() => _isProcessing = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: result.isSuccess ? AppTheme.successGreen : AppTheme.errorRed,
        ),
      );
      _refresh();
    }
  }

  Future<void> _showRestoreDialog() async {
    final backupFiles = await ref.read(backupServiceProvider).getLocalBackupFiles();
    if (!mounted) return;

    if (backupFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('फोनमध्ये कोणतीही जुनी बॅकअप फाईल सापडली नाही. कृपया आधी नवीन बॅकअप घ्या.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('रिस्टोर करण्यासाठी फाईल निवडा'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: backupFiles.length,
            itemBuilder: (context, idx) {
              final file = backupFiles[idx];
              final name = file.path.split(Platform.pathSeparator).last;
              final sizeKb = (file.lengthSync() / 1024).toStringAsFixed(1);
              final modDate = Formatters.dateWithTime(file.lastModifiedSync());

              return ListTile(
                leading: const Icon(Icons.storage, color: AppTheme.primaryBlue),
                title: Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                subtitle: Text('$modDate • $sizeKb KB', style: const TextStyle(fontSize: 11)),
                onTap: () async {
                  Navigator.pop(ctx);
                  _confirmAndRestore(file);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('रद्द करा (Cancel)'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmAndRestore(File file) async {
    final fileName = file.path.split(Platform.pathSeparator).last;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('डेटा रिस्टोर करायचा आहे का?'),
        content: Text(
          'तुम्ही निवडलेली फाईल:\n$fileName\n\nसावधान: रिस्टोर केल्यास चालू डेटा या बॅकअप फाईलने बदलला जाईल. ही क्रिया परत करता येणार नाही.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('रद्द करा')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('खात्री करा आणि रिस्टोर करा'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      setState(() => _isProcessing = true);
      final result = await ref.read(backupServiceProvider).restoreFromFile(file);
      setState(() => _isProcessing = false);

      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(result.isSuccess ? 'रिस्टोर यशस्वी!' : 'त्रुटी'),
            content: Text(result.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('ठिक आहे'),
              ),
            ],
          ),
        );
        _refresh();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final settingsAsync = ref.watch(businessSettingsStreamProvider);
    final historyAsync = ref.watch(backupHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.backupAndRestore),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_isProcessing) ...[
            const LinearProgressIndicator(),
            const SizedBox(height: 12),
          ],

          // 1. Local Offline Backup Card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppTheme.primaryBlue.withOpacity(0.12),
                        child: const Icon(Icons.security, color: AppTheme.primaryBlue),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'स्थानिक डेटा बॅकअप (Offline Backup)',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            settingsAsync.when(
                              data: (s) => Text(
                                s.lastBackupTimestamp != null
                                    ? 'शेवटचा बॅकअप: ${Formatters.dateWithTime(s.lastBackupTimestamp)} (${s.lastBackupStatus ?? "यशस्वी"})'
                                    : 'अद्याप कोणताही बॅकअप घेतलेला नाही',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              loading: () => const SizedBox(),
                              error: (_, __) => const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  const Text(
                    'आपला सर्व डेटा सुरक्षित SQLite फाईलमध्ये सेव्ह करा आणि थेट WhatsApp, Google Drive किंवा फोन मेमरीमध्ये शेअर करा.',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _isProcessing ? null : _handleCreateAndShare,
                          icon: const Icon(Icons.share, size: 18),
                          label: const Text('बॅकअप घ्या व शेअर करा'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isProcessing ? null : _handleSaveLocalOnly,
                          icon: const Icon(Icons.save_alt, size: 18),
                          label: const Text('फक्त फोनमध्ये सेव्ह करा'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.deepOrange.shade700,
                            side: BorderSide(color: Colors.deepOrange.shade300),
                          ),
                          onPressed: _isProcessing ? null : _showRestoreDialog,
                          icon: const Icon(Icons.restore, size: 18),
                          label: const Text('डेटा रिस्टोर करा'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 2. Google Drive Cloud Sync Card
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.withOpacity(0.12),
                        child: const Icon(Icons.cloud_upload_outlined, color: Colors.blue),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'गुगल ड्राईव्ह सिंक (Google Drive Cloud Sync)',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              'सुरक्षित क्लाऊड बॅकअप (OAuth 2.0)',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 16, color: Colors.blue),
                            SizedBox(width: 6),
                            Text(
                              'गुगल अकाऊंट सुरक्षितता:',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          '• Google Sign-In वापरण्यासाठी पासवर्ड देण्याची अजिबात गरज नसते.\n• Google Cloud OAuth Client ID द्वारे फोनमधील "Sign in with Google" पॉपअपमधून थेट जोडणी होते.\n• स्थानिक बॅकअप शेअर करून आपण आत्ताच Google Drive ॲपमध्ये सुरक्षित फाईल पाठवू शकता.',
                          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.schedule, color: AppTheme.successGreen, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'रोज रात्री १०:०० वाजता आपोआप बॅकअप शेड्युल (WorkManager द्वारे)',
                            style: TextStyle(fontSize: 12, color: AppTheme.successGreen, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 3. Backup History
          const Text('बॅकअप इतिहास (Backup History)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),

          historyAsync.when(
            data: (histories) {
              if (histories.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text('कोणताही बॅकअप इतिहास उपलब्ध नाही', style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                );
              }

              return Column(
                children: histories.map((h) {
                  final isSuccess = h.status == 'success';
                  final isRestore = h.backupType == 'restore';

                  return Card(
                    child: ListTile(
                      leading: Icon(
                        isRestore
                            ? Icons.restore
                            : (isSuccess ? Icons.check_circle : Icons.error),
                        color: isRestore
                            ? Colors.deepOrange
                            : (isSuccess ? AppTheme.successGreen : AppTheme.errorRed),
                      ),
                      title: Text(h.fileName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${Formatters.dateWithTime(h.backupDate)} • ${h.backupType.toUpperCase()} ${h.fileSize != null ? "• ${(h.fileSize! / 1024).toStringAsFixed(1)} KB" : ""}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }
}
