import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/daos/report_dao.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/services/pdf_invoice_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

final reportDateRangeProvider = StateProvider.autoDispose<DateTimeRange>((ref) {
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  return DateTimeRange(start: startOfMonth, end: now);
});

final breakdownReportProvider = FutureProvider.autoDispose<CategoryIncomeBreakdown>((ref) {
  final range = ref.watch(reportDateRangeProvider);
  return ref.watch(reportDaoProvider).getCategoryIncomeBreakdown(range.start, range.end);
});

final reportSummaryProvider = FutureProvider.autoDispose<DashboardSummary>((ref) {
  final range = ref.watch(reportDateRangeProvider);
  return ref.watch(reportDaoProvider).getDashboardSummary(
        startDate: range.start,
        endDate: range.end,
      );
});

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  void _setDatePreset(WidgetRef ref, String preset) {
    final now = DateTime.now();
    DateTime start;
    DateTime end = now;

    switch (preset) {
      case 'today':
        start = DateTime(now.year, now.month, now.day);
        break;
      case 'week':
        start = now.subtract(Duration(days: now.weekday - 1));
        start = DateTime(start.year, start.month, start.day);
        break;
      case 'month':
        start = DateTime(now.year, now.month, 1);
        break;
      case 'year':
        start = DateTime(now.year, 1, 1);
        break;
      default:
        start = DateTime(now.year, now.month, 1);
    }
    ref.read(reportDateRangeProvider.notifier).state = DateTimeRange(start: start, end: end);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final range = ref.watch(reportDateRangeProvider);
    final breakdownAsync = ref.watch(breakdownReportProvider);
    final summaryAsync = ref.watch(reportSummaryProvider);
    final settingsAsync = ref.watch(businessSettingsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.reports),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_outlined),
            tooltip: 'अहवाल प्रिंट / PDF करा',
            onPressed: () {
              final breakdown = breakdownAsync.value;
              final summary = summaryAsync.value;
              if (breakdown == null) return;
              final grossIncome = breakdown.repairIncome + breakdown.motorSalesIncome + breakdown.partsSalesIncome;
              PdfInvoiceService.printReportPdf(
                startDate: range.start,
                endDate: range.end,
                grossIncome: grossIncome,
                totalExpenses: breakdown.totalExpenses,
                netProfit: breakdown.netProfit,
                totalPendingReceivables: summary?.totalPendingCustomerPayments ?? 0.0,
                settings: settingsAsync.value,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'अहवाल PDF शेअर करा',
            onPressed: () {
              final breakdown = breakdownAsync.value;
              final summary = summaryAsync.value;
              if (breakdown == null) return;
              final grossIncome = breakdown.repairIncome + breakdown.motorSalesIncome + breakdown.partsSalesIncome;
              PdfInvoiceService.shareReportPdf(
                startDate: range.start,
                endDate: range.end,
                grossIncome: grossIncome,
                totalExpenses: breakdown.totalExpenses,
                netProfit: breakdown.netProfit,
                totalPendingReceivables: summary?.totalPendingCustomerPayments ?? 0.0,
                settings: settingsAsync.value,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.date_range),
            tooltip: 'तारीख निवडा (Select Date Range)',
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                initialDateRange: range,
              );
              if (picked != null) {
                ref.read(reportDateRangeProvider.notifier).state = picked;
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Filter Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ActionChip(
                  label: const Text('आज (Today)'),
                  avatar: const Icon(Icons.today, size: 16),
                  onPressed: () => _setDatePreset(ref, 'today'),
                ),
                const SizedBox(width: 8),
                ActionChip(
                  label: const Text('हा आठवडा (Week)'),
                  avatar: const Icon(Icons.view_week, size: 16),
                  onPressed: () => _setDatePreset(ref, 'week'),
                ),
                const SizedBox(width: 8),
                ActionChip(
                  label: const Text('हा महिना (Month)'),
                  avatar: const Icon(Icons.calendar_month, size: 16),
                  onPressed: () => _setDatePreset(ref, 'month'),
                ),
                const SizedBox(width: 8),
                ActionChip(
                  label: const Text('चालू वर्ष (Year)'),
                  avatar: const Icon(Icons.calendar_today, size: 16),
                  onPressed: () => _setDatePreset(ref, 'year'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Range Indicator
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: AppTheme.primaryBlue, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'कालावधी: ${Formatters.date(range.start)} ते ${Formatters.date(range.end)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          breakdownAsync.when(
            data: (data) {
              final totalSalesIncome = data.motorSalesIncome + data.partsSalesIncome;
              final totalGrossIncome = data.repairIncome + totalSalesIncome;
              final summary = summaryAsync.value;

              return Column(
                children: [
                  // Total Gross & Net Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text('एकूण व्यावसायिक उलाढाल (Gross Income)', style: TextStyle(fontSize: 14, color: Colors.grey)),
                          const SizedBox(height: 6),
                          Text(
                            Formatters.currency(totalGrossIncome),
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text('दुकान खर्च (Expenses)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Text(
                                    Formatters.currency(data.totalExpenses),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.errorRed),
                                  ),
                                ],
                              ),
                              Container(height: 36, width: 1, color: Colors.grey.shade300),
                              Column(
                                children: [
                                  const Text('निव्वळ नफा (Net Profit)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Text(
                                    Formatters.currency(data.netProfit),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: data.netProfit >= 0 ? AppTheme.successGreen : AppTheme.errorRed,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Receivables & Collection Card
                  if (summary != null)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text('जमा वसुली (Received)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text(
                                  Formatters.currency(summary.receivedPayment),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.successGreen),
                                ),
                              ],
                            ),
                            Container(height: 36, width: 1, color: Colors.grey.shade300),
                            Column(
                              children: [
                                const Text('एकूण बाकी शिल्लक (Pending)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text(
                                  Formatters.currency(summary.totalPendingCustomerPayments),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.errorRed),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),

                  // Category Breakdown
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('उत्पन्नाचे वर्गीकरण (Category Breakdown)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const Divider(),
                          _ReportLine(label: 'मोटर रिपेअरिंग (Rewinding Income)', amount: data.repairIncome, color: AppTheme.accentOrange),
                          if (data.motorSalesIncome > 0)
                            _ReportLine(label: 'नवीन मोटर विक्री (Motor Pump Sales)', amount: data.motorSalesIncome, color: Colors.indigo),
                          if (data.partsSalesIncome > 0)
                            _ReportLine(label: 'स्पेअर पार्ट्स विक्री (Parts Sales)', amount: data.partsSalesIncome, color: Colors.teal),
                          _ReportLine(label: 'दुकान खर्च (Shop Expenses)', amount: data.totalExpenses, color: AppTheme.errorRed, isNegative: true),
                        ],
                      ),
                    ),
                  ),
                ],
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

class _ReportLine extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final bool isNegative;

  const _ReportLine({
    required this.label,
    required this.amount,
    required this.color,
    this.isNegative = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 6, backgroundColor: color),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
            ],
          ),
          Text(
            isNegative ? '- ${Formatters.currency(amount)}' : Formatters.currency(amount),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color),
          ),
        ],
      ),
    );
  }
}

