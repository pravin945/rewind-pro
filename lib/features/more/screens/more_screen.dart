import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final settingsAsync = ref.watch(businessSettingsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.navMore),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // Shop Profile Header Card
          settingsAsync.when(
            data: (settings) => Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryBlue, AppTheme.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    settings.shopName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${settings.ownerName} • ${settings.mobileNumber}',
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    settings.shopAddress,
                    style: const TextStyle(fontSize: 12, color: Colors.white60),
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),

          _MenuTile(
            icon: Icons.inventory_2,
            iconColor: AppTheme.accentOrange,
            title: strings.inventory,
            subtitle: 'मोटर पंप, पार्ट्स व वायर स्टॉक व्यवस्थापन',
            onTap: () => context.push('/more/inventory'),
          ),

          _MenuTile(
            icon: Icons.calendar_month,
            iconColor: Colors.teal.shade700,
            title: strings.dailyRegister,
            subtitle: 'रोजचे दुकान काम व जमा-खर्च नोंद वही',
            onTap: () => context.push('/more/daily-work'),
          ),

          _MenuTile(
            icon: Icons.account_balance_wallet,
            iconColor: AppTheme.errorRed,
            title: 'बाकी रक्कम यादी (Pending Payments)',
            subtitle: 'सर्व ग्राहकांची थकबाकी व तगादा यादी',
            onTap: () => context.push('/more/pending-payments'),
          ),

          _MenuTile(
            icon: Icons.bar_chart,
            iconColor: Colors.indigo.shade700,
            title: strings.reports,
            subtitle: 'दैनिक, मासिक कमाई व नफा-तोटा अहवाल',
            onTap: () => context.push('/more/reports'),
          ),

          _MenuTile(
            icon: Icons.money_off,
            iconColor: Colors.deepOrange,
            title: 'दुकान खर्च (Expenses)',
            subtitle: 'लाईट बिल, चहा-पाणी, भाडे व इतर खर्च',
            onTap: () => context.push('/more/expenses'),
          ),

          const Divider(indent: 16, endIndent: 16),

          _MenuTile(
            icon: Icons.cloud_sync,
            iconColor: Colors.blue.shade700,
            title: strings.backupAndRestore,
            subtitle: 'Google Drive वर ऑटो व मॅन्युअल सुरक्षित बॅकअप',
            onTap: () => context.push('/more/backup'),
          ),

          _MenuTile(
            icon: Icons.settings,
            iconColor: Colors.grey.shade800,
            title: strings.settings,
            subtitle: 'दुकान नाव, पत्ता, बिलिंग व भाषा सेटिंग्ज',
            onTap: () => context.push('/more/settings'),
          ),

          const SizedBox(height: 20),
          Center(
            child: Text(
              'RewindPro v1.0 • Offline-First',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.12),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

