import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

enum DashboardDateFilter {
  today('आज (Today)'),
  yesterday('काल (Yesterday)'),
  thisWeek('या आठवड्यात (This Week)'),
  thisMonth('या महिन्यात (This Month)'),
  custom('तारीख निवडा (Custom Range)'),
  allTime('सर्व (All Time)');

  final String label;
  const DashboardDateFilter(this.label);
}

final dashboardFilterProvider = StateProvider<DashboardDateFilter>((ref) => DashboardDateFilter.today);
final customDateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

final dashboardSummaryProvider = FutureProvider.autoDispose((ref) async {
  final filter = ref.watch(dashboardFilterProvider);
  final customRange = ref.watch(customDateRangeProvider);
  final reportDao = ref.watch(reportDaoProvider);

  final now = DateTime.now();
  DateTime start;
  DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

  switch (filter) {
    case DashboardDateFilter.today:
      start = DateTime(now.year, now.month, now.day);
      break;
    case DashboardDateFilter.yesterday:
      final y = now.subtract(const Duration(days: 1));
      start = DateTime(y.year, y.month, y.day);
      end = DateTime(y.year, y.month, y.day, 23, 59, 59, 999);
      break;
    case DashboardDateFilter.thisWeek:
      start = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
      break;
    case DashboardDateFilter.thisMonth:
      start = DateTime(now.year, now.month, 1);
      break;
    case DashboardDateFilter.custom:
      if (customRange != null) {
        start = DateTime(customRange.start.year, customRange.start.month, customRange.start.day);
        end = DateTime(customRange.end.year, customRange.end.month, customRange.end.day, 23, 59, 59, 999);
      } else {
        start = DateTime(now.year, now.month, now.day);
      }
      break;
    case DashboardDateFilter.allTime:
      start = DateTime(2000, 1, 1);
      break;
  }

  return reportDao.getDashboardSummary(startDate: start, endDate: end);
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  Future<void> _handleFilterSelection(
    BuildContext context,
    WidgetRef ref,
    DashboardDateFilter filter,
  ) async {
    if (filter == DashboardDateFilter.custom) {
      final initialRange = ref.read(customDateRangeProvider) ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          );

      final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        initialDateRange: initialRange,
        helpText: 'कालावधी निवडा (Select Date Range)',
        saveText: 'निवडा (Select)',
      );

      if (picked != null) {
        ref.read(customDateRangeProvider.notifier).state = picked;
        ref.read(dashboardFilterProvider.notifier).state = DashboardDateFilter.custom;
      }
    } else {
      ref.read(dashboardFilterProvider.notifier).state = filter;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final currentFilter = ref.watch(dashboardFilterProvider);
    final customRange = ref.watch(customDateRangeProvider);
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final settingsAsync = ref.watch(businessSettingsStreamProvider);

    String filterBannerText = 'कालावधी: ${currentFilter.label}';
    if (currentFilter == DashboardDateFilter.custom && customRange != null) {
      filterBannerText = 'कालावधी: ${Formatters.date(customRange.start)} ते ${Formatters.date(customRange.end)}';
    }

    final backupTime = settingsAsync.value?.lastBackupTimestamp;
    final backupStatus = settingsAsync.value?.lastBackupStatus;
    final isBackupSuccess = backupStatus == 'success';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.electric_bolt, color: Colors.amber),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    settingsAsync.value?.shopName ?? strings.appTitle,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    strings.todayTotalIncome,
                    style: const TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeModeProvider) == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: 'लाइट / डार्क थीम बदला (Switch Theme)',
            onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
          ),
          PopupMenuButton<DashboardDateFilter>(
            icon: const Icon(Icons.filter_list),
            tooltip: strings.filter,
            onSelected: (val) => _handleFilterSelection(context, ref, val),
            itemBuilder: (context) {
              return DashboardDateFilter.values.map((f) {
                return PopupMenuItem(
                  value: f,
                  child: Text(
                    f.label,
                    style: TextStyle(
                      fontWeight: f == currentFilter ? FontWeight.bold : FontWeight.normal,
                      color: f == currentFilter ? AppTheme.primaryBlue : null,
                    ),
                  ),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(dashboardSummaryProvider),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(dashboardSummaryProvider),
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            // Compact Top Strip: Date Filter + Backup Pill
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _handleFilterSelection(context, ref, DashboardDateFilter.custom),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.primaryLight.withOpacity(0.25)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 15, color: AppTheme.adaptivePrimary(context)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              filterBannerText,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.adaptivePrimary(context)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, size: 18, color: AppTheme.adaptivePrimary(context)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => context.push('/more/backup'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                    decoration: BoxDecoration(
                      color: (backupTime != null && isBackupSuccess)
                          ? AppTheme.successGreen.withOpacity(0.12)
                          : Colors.grey.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: (backupTime != null && isBackupSuccess)
                            ? AppTheme.successGreen.withOpacity(0.35)
                            : Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          backupTime != null
                              ? (isBackupSuccess ? Icons.cloud_done : Icons.cloud_sync)
                              : Icons.cloud_off,
                          size: 16,
                          color: backupTime != null
                              ? (isBackupSuccess ? AppTheme.successGreen : AppTheme.warningAmber)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          backupTime != null ? 'बॅकअप ✓' : 'बॅकअप',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: (backupTime != null && isBackupSuccess) ? AppTheme.successGreen : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Quick Actions Section (Top Priority for Shopkeeper)
            Text(
              strings.quickActions,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.5,
              children: [
                _QuickActionButton(
                  icon: Icons.person_add,
                  label: strings.addCustomer,
                  color: AppTheme.adaptivePrimary(context),
                  onTap: () => context.push('/customers/add'),
                ),
                _QuickActionButton(
                  icon: Icons.build_circle,
                  label: strings.newRepairJob,
                  color: AppTheme.accentOrange,
                  onTap: () => context.push('/jobs/add'),
                ),
                _QuickActionButton(
                  icon: Icons.receipt_long,
                  label: strings.createBill,
                  color: Colors.teal,
                  onTap: () => context.push('/billing/new?category=repair'),
                ),
                _QuickActionButton(
                  icon: Icons.payment,
                  label: strings.receivePayment,
                  color: AppTheme.successGreen,
                  onTap: () => context.push('/more/pending-payments'),
                ),
                _QuickActionButton(
                  icon: Icons.history_edu,
                  label: strings.dailyWork,
                  color: Colors.indigoAccent,
                  onTap: () => context.push('/more/daily-work'),
                ),
                _QuickActionButton(
                  icon: Icons.money_off,
                  label: 'दुकान खर्च (Expenses)',
                  color: Colors.deepOrange,
                  onTap: () => context.push('/more/expenses'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Simplified Financial & Jobs Summary
            summaryAsync.when(
              data: (data) => Column(
                children: [
                  // Unified Financial Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('हिशोब गोषवारा (Summary)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () => context.push('/more/pending-payments'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppTheme.errorRed.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'एकूण बाकी: ${Formatters.currency(data.totalPendingCustomerPayments)}',
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.errorRed),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _MetricColumn(
                                  label: 'कमाई (Billed)',
                                  value: Formatters.currency(data.totalIncome),
                                  color: AppTheme.adaptivePrimary(context),
                                ),
                              ),
                              Expanded(
                                child: _MetricColumn(
                                  label: 'जमा (Received)',
                                  value: Formatters.currency(data.receivedPayment),
                                  color: AppTheme.successGreen,
                                ),
                              ),
                              Expanded(
                                child: _MetricColumn(
                                  label: 'बाकी (Pending)',
                                  value: Formatters.currency(data.pendingPayment),
                                  color: AppTheme.warningAmber,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _CompactChipCard(
                                  icon: Icons.money_off,
                                  label: 'खर्च: ${Formatters.currency(data.todaySalesAmount > 0 ? data.todaySalesAmount : 0)}',
                                  color: AppTheme.errorRed,
                                  onTap: () => context.push('/more/expenses'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _CompactChipCard(
                                  icon: Icons.inventory_2,
                                  label: 'कमी स्टॉक: ${data.lowStockProductsCount}',
                                  color: data.lowStockProductsCount > 0 ? AppTheme.accentOrange : Colors.grey,
                                  onTap: () => context.push('/more/inventory?lowStock=true'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Unified Jobs Overview Card
                  Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => context.go('/jobs'),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'मोटर कामे (${strings.navJobs})',
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'सर्व पहा >',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.adaptivePrimary(context)),
                                ),
                              ],
                            ),
                            const Divider(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: _JobCountItem(
                                    label: 'नवीन',
                                    count: data.newJobsToday,
                                    color: AppTheme.primaryLight,
                                  ),
                                ),
                                Expanded(
                                  child: _JobCountItem(
                                    label: 'चालू',
                                    count: data.activeJobsCount,
                                    color: AppTheme.warningAmber,
                                  ),
                                ),
                                Expanded(
                                  child: _JobCountItem(
                                    label: 'पूर्ण',
                                    count: data.completedJobsCount,
                                    color: AppTheme.successGreen,
                                  ),
                                ),
                                Expanded(
                                  child: _JobCountItem(
                                    label: 'दिलेले',
                                    count: data.deliveredJobsCount,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error loading stats: $err', style: const TextStyle(color: Colors.red)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetricColumn({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center),
      ],
    );
  }
}

class _CompactChipCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CompactChipCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobCountItem extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _JobCountItem({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.3), width: 1.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color,
                child: Icon(icon, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
