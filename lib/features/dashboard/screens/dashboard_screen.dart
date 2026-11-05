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
          padding: const EdgeInsets.all(16),
          children: [
            // Filter banner with tap-to-change
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => _handleFilterSelection(context, ref, DashboardDateFilter.custom),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: AppTheme.primaryBlue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        filterBannerText,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.primaryBlue),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: AppTheme.primaryBlue),
                  ],
                ),
              ),
            ),

            // Last Backup Badge Card
            Card(
              margin: const EdgeInsets.only(bottom: 14),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => context.push('/more/backup'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        backupTime != null
                            ? (isBackupSuccess ? Icons.cloud_done : Icons.cloud_sync)
                            : Icons.cloud_off,
                        color: backupTime != null
                            ? (isBackupSuccess ? AppTheme.successGreen : AppTheme.warningAmber)
                            : Colors.grey,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              strings.lastBackup,
                              style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              backupTime != null
                                  ? '${Formatters.dateTime(backupTime)} (${isBackupSuccess ? "सुरक्षित" : "प्रलंबित"})'
                                  : strings.noBackupYet,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: backupTime != null
                                    ? (isBackupSuccess ? AppTheme.successGreen : AppTheme.warningAmber)
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            // Financial Summary Cards
            summaryAsync.when(
              data: (data) => Column(
                children: [
                  // Row 1: Total Billed & Received Payment
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: strings.todayTotalIncome,
                          amount: Formatters.currency(data.totalIncome),
                          icon: Icons.payments,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: strings.todayReceived,
                          amount: Formatters.currency(data.receivedPayment),
                          icon: Icons.check_circle,
                          color: AppTheme.successGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Row 2: Today Pending & Total Customer Pending
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: strings.todayPending,
                          amount: Formatters.currency(data.pendingPayment),
                          icon: Icons.pending_actions,
                          color: AppTheme.warningAmber,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: strings.totalPendingPayments,
                          amount: Formatters.currency(data.totalPendingCustomerPayments),
                          icon: Icons.account_balance_wallet,
                          color: AppTheme.errorRed,
                          onTap: () => context.push('/more/pending-payments'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Row 3: Today's Expenses & Low stock materials
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'आजचा खर्च (Expenses)',
                          amount: Formatters.currency(data.todaySalesAmount > 0 ? data.todaySalesAmount : 0), // Linked to expenses
                          icon: Icons.money_off,
                          color: AppTheme.errorRed,
                          onTap: () => context.push('/more/expenses'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: 'कमी साहित्य स्टॉक',
                          amount: '${data.lowStockProductsCount} साहित्य',
                          icon: Icons.inventory_2,
                          color: data.lowStockProductsCount > 0 ? AppTheme.accentOrange : Colors.grey.shade700,
                          onTap: () => context.push('/more/inventory?lowStock=true'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Job Counts Overview
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                strings.navJobs,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () => context.go('/jobs'),
                                child: const Text('सर्व कामे पहा >'),
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _JobCountItem(
                                  label: strings.todayNewJobs,
                                  count: data.newJobsToday,
                                  color: AppTheme.primaryLight,
                                ),
                              ),
                              Expanded(
                                child: _JobCountItem(
                                  label: strings.inProgressJobs,
                                  count: data.activeJobsCount,
                                  color: AppTheme.warningAmber,
                                ),
                              ),
                              Expanded(
                                child: _JobCountItem(
                                  label: strings.completedJobs,
                                  count: data.completedJobsCount,
                                  color: AppTheme.successGreen,
                                ),
                              ),
                              Expanded(
                                child: _JobCountItem(
                                  label: strings.deliveredJobs,
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

            const SizedBox(height: 20),

            // Quick Actions Section
            Text(
              strings.quickActions,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.2,
              children: [
                _QuickActionButton(
                  icon: Icons.person_add,
                  label: strings.addCustomer,
                  color: AppTheme.primaryBlue,
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
                  color: Colors.teal.shade700,
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
                  color: Colors.indigo.shade600,
                  onTap: () => context.push('/more/daily-work'),
                ),
                _QuickActionButton(
                  icon: Icons.money_off,
                  label: 'दुकान खर्च (Expenses)',
                  color: Colors.deepOrange.shade700,
                  onTap: () => context.push('/more/expenses'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(icon, size: 20, color: color),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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
