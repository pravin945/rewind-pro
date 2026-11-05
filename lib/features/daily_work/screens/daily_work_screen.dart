import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

enum DailyWorkFilter {
  today('आज (Today)'),
  yesterday('काल (Yesterday)'),
  thisWeek('या आठवड्यात (This Week)'),
  thisMonth('या महिन्यात (This Month)'),
  custom('तारीख निवडा (Custom)');

  final String label;
  const DailyWorkFilter(this.label);
}

final dailyWorkFilterProvider = StateProvider.autoDispose<DailyWorkFilter>((ref) => DailyWorkFilter.today);
final dailyWorkCustomRangeProvider = StateProvider.autoDispose<DateTimeRange?>((ref) => null);

final dailyWorkLogsProvider = StreamProvider.autoDispose<List<DailyWorkLog>>((ref) {
  final filter = ref.watch(dailyWorkFilterProvider);
  final customRange = ref.watch(dailyWorkCustomRangeProvider);
  final dao = ref.watch(dailyWorkDaoProvider);

  final now = DateTime.now();
  DateTime start;
  DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

  switch (filter) {
    case DailyWorkFilter.today:
      start = DateTime(now.year, now.month, now.day);
      break;
    case DailyWorkFilter.yesterday:
      final y = now.subtract(const Duration(days: 1));
      start = DateTime(y.year, y.month, y.day);
      end = DateTime(y.year, y.month, y.day, 23, 59, 59, 999);
      break;
    case DailyWorkFilter.thisWeek:
      start = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
      break;
    case DailyWorkFilter.thisMonth:
      start = DateTime(now.year, now.month, 1);
      break;
    case DailyWorkFilter.custom:
      if (customRange != null) {
        start = DateTime(customRange.start.year, customRange.start.month, customRange.start.day);
        end = DateTime(customRange.end.year, customRange.end.month, customRange.end.day, 23, 59, 59, 999);
      } else {
        start = DateTime(now.year, now.month, now.day);
      }
      break;
  }

  return dao.watchLogsForDateRange(start, end);
});

class DailyWorkScreen extends ConsumerWidget {
  const DailyWorkScreen({super.key});

  Future<void> _handleFilterSelection(
    BuildContext context,
    WidgetRef ref,
    DailyWorkFilter filter,
  ) async {
    if (filter == DailyWorkFilter.custom) {
      final initial = ref.read(dailyWorkCustomRangeProvider) ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          );

      final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        initialDateRange: initial,
        helpText: 'कालावधी निवडा (Select Date Range)',
      );

      if (picked != null) {
        ref.read(dailyWorkCustomRangeProvider.notifier).state = picked;
        ref.read(dailyWorkFilterProvider.notifier).state = DailyWorkFilter.custom;
      }
    } else {
      ref.read(dailyWorkFilterProvider.notifier).state = filter;
    }
  }

  void _showAddEditLogDialog(BuildContext context, WidgetRef ref, [DailyWorkLog? existing]) async {
    final isEdit = existing != null;
    DateTime logDate = existing?.logDate ?? DateTime.now();

    final customerController = TextEditingController(text: existing?.customerName ?? '');
    final jobNumController = TextEditingController(text: existing?.jobNumber ?? '');
    final motorController = TextEditingController(text: existing?.motorDetails ?? '');
    final workController = TextEditingController(text: existing?.workPerformed ?? '');
    final partsController = TextEditingController(text: existing?.partsUsed ?? '');
    final labourController = TextEditingController(text: existing?.labourCharges.toStringAsFixed(0) ?? '500');
    final receivedController = TextEditingController(text: existing?.paymentReceived.toStringAsFixed(0) ?? '0');
    final pendingController = TextEditingController(text: existing?.pendingAmount.toStringAsFixed(0) ?? '500');
    final notesController = TextEditingController(text: existing?.notes ?? '');

    void recalculatePending() {
      final l = double.tryParse(labourController.text.trim()) ?? 0.0;
      final r = double.tryParse(receivedController.text.trim()) ?? 0.0;
      final diff = l - r;
      pendingController.text = (diff < 0 ? 0.0 : diff).toStringAsFixed(0);
    }

    // Preload customers and active jobs for quick selection
    final customers = await ref.read(customerDaoProvider).getAllCustomers();
    final activeJobs = await ref.read(repairJobDaoProvider).getAllJobs();
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(isEdit ? 'नोंद दुरुस्त करा' : 'नवीन दैनिक काम नोंद'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Picker Tile
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today, color: AppTheme.primaryBlue),
                    title: const Text('कामाची तारीख', style: TextStyle(fontSize: 13)),
                    subtitle: Text(
                      Formatters.date(logDate),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    trailing: const Icon(Icons.edit_calendar),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: logDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                      if (picked != null) {
                        setDialogState(() => logDate = picked);
                      }
                    },
                  ),
                  const Divider(height: 16),

                  // Customer selection / input
                  if (customers.isNotEmpty) ...[
                    DropdownButtonFormField<Customer?>(
                      decoration: const InputDecoration(
                        labelText: 'ग्राहक निवडा (Customer)',
                        prefixIcon: Icon(Icons.person),
                      ),
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('इतर / थेट नाव टाका (Manual)')),
                        ...customers.map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text('${c.name} (${c.mobile})', overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                      onChanged: (c) {
                        if (c != null) {
                          setDialogState(() {
                            customerController.text = c.name;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                  ],

                  TextField(
                    controller: customerController,
                    decoration: const InputDecoration(
                      labelText: 'ग्राहकाचे नाव (Customer Name)',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Active job reference (optional)
                  if (activeJobs.isNotEmpty) ...[
                    DropdownButtonFormField<RepairJob?>(
                      decoration: const InputDecoration(
                        labelText: 'जॉब कार्ड लिंक करा (Optional Job)',
                        prefixIcon: Icon(Icons.assignment),
                      ),
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('कोणताही जॉब नाही (None)')),
                        ...activeJobs.map(
                          (j) => DropdownMenuItem(
                            value: j,
                            child: Text('${j.jobNumber} - ${j.motorType} ${j.motorHp}', overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                      onChanged: (j) {
                        if (j != null) {
                          setDialogState(() {
                            jobNumController.text = j.jobNumber;
                            motorController.text = '${j.motorType} ${j.motorBrand} ${j.motorHp}';
                            if (j.customerNameSnapshot != null) {
                              customerController.text = j.customerNameSnapshot!;
                            }
                            labourController.text = j.labourCharges.toStringAsFixed(0);
                            recalculatePending();
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                  ],

                  TextField(
                    controller: motorController,
                    decoration: const InputDecoration(
                      labelText: 'मोटर तपशील (उदा. 3HP Submersible)',
                      prefixIcon: Icon(Icons.electric_meter),
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: workController,
                    decoration: const InputDecoration(
                      labelText: 'केलेले काम (Work Performed) *',
                      prefixIcon: Icon(Icons.build),
                      hintText: 'उदा. पूर्ण रिवाइंडिंग + बेअरिंग बदलले',
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: partsController,
                    decoration: const InputDecoration(
                      labelText: 'वापरलेले पार्ट्स (Parts Used)',
                      prefixIcon: Icon(Icons.extension),
                      hintText: 'उदा. कॉपर वायर 3 किलो, बेअरिंग 6204',
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: labourController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'मजुरी (₹)'),
                          onChanged: (_) => setDialogState(recalculatePending),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: receivedController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'जमा (₹)'),
                          onChanged: (_) => setDialogState(recalculatePending),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: pendingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'बाकी रक्कम (₹)'),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: notesController,
                    decoration: const InputDecoration(labelText: 'इतर टीप (Notes)'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा (Cancel)')),
              ElevatedButton(
                onPressed: () async {
                  final work = workController.text.trim();
                  if (work.isEmpty) return;

                  final labour = double.tryParse(labourController.text.trim()) ?? 0.0;
                  final received = double.tryParse(receivedController.text.trim()) ?? 0.0;
                  final pending = double.tryParse(pendingController.text.trim()) ?? 0.0;

                  if (isEdit) {
                    await ref.read(dailyWorkDaoProvider).updateLog(
                          DailyWorkLogsCompanion(
                            id: drift.Value(existing.id),
                            logDate: drift.Value(logDate),
                            customerName: drift.Value(customerController.text.trim()),
                            jobNumber: drift.Value(jobNumController.text.trim().isEmpty ? null : jobNumController.text.trim()),
                            motorDetails: drift.Value(motorController.text.trim()),
                            workPerformed: drift.Value(work),
                            partsUsed: drift.Value(partsController.text.trim()),
                            labourCharges: drift.Value(labour),
                            paymentReceived: drift.Value(received),
                            pendingAmount: drift.Value(pending),
                            notes: drift.Value(notesController.text.trim()),
                          ),
                        );
                  } else {
                    await ref.read(dailyWorkDaoProvider).insertLog(
                          DailyWorkLogsCompanion.insert(
                            logDate: drift.Value(logDate),
                            customerName: drift.Value(customerController.text.trim()),
                            jobNumber: drift.Value(jobNumController.text.trim().isEmpty ? null : jobNumController.text.trim()),
                            motorDetails: drift.Value(motorController.text.trim()),
                            workPerformed: work,
                            partsUsed: drift.Value(partsController.text.trim()),
                            labourCharges: drift.Value(labour),
                            paymentReceived: drift.Value(received),
                            pendingAmount: drift.Value(pending),
                            notes: drift.Value(notesController.text.trim()),
                          ),
                        );
                  }

                  if (context.mounted) Navigator.pop(ctx);
                },
                child: Text(isEdit ? 'अपडेट करा' : 'जतन करा'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDeleteLog(BuildContext context, WidgetRef ref, DailyWorkLog log) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('नोंद हटवायची आहे का?'),
        content: Text('${log.customerName ?? "नोंद"} चे काम: "${log.workPerformed}" हटवायचे आहे का?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('रद्द करा')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('हटवा (Delete)'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(dailyWorkDaoProvider).deleteLog(log.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final currentFilter = ref.watch(dailyWorkFilterProvider);
    final customRange = ref.watch(dailyWorkCustomRangeProvider);
    final logsAsync = ref.watch(dailyWorkLogsProvider);

    String filterTitle = currentFilter.label;
    if (currentFilter == DailyWorkFilter.custom && customRange != null) {
      filterTitle = '${Formatters.date(customRange.start)} - ${Formatters.date(customRange.end)}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.dailyRegister),
        actions: [
          PopupMenuButton<DailyWorkFilter>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'कालावधी निवडा',
            onSelected: (val) => _handleFilterSelection(context, ref, val),
            itemBuilder: (context) {
              return DailyWorkFilter.values.map((f) {
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
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          InkWell(
            onTap: () => _handleFilterSelection(context, ref, DailyWorkFilter.custom),
            child: Container(
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: AppTheme.primaryBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'कालावधी: $filterTitle',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.primaryBlue),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: AppTheme.primaryBlue),
                ],
              ),
            ),
          ),

          // Total Summary Header for filtered period
          logsAsync.when(
            data: (logs) {
              final totalLabour = logs.fold<double>(0.0, (acc, l) => acc + l.labourCharges);
              final totalReceived = logs.fold<double>(0.0, (acc, l) => acc + l.paymentReceived);
              final totalPending = logs.fold<double>(0.0, (acc, l) => acc + l.pendingAmount);

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('नोंदी: ${logs.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('मजुरी: ${Formatters.currency(totalLabour)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    Text('जमा: ${Formatters.currency(totalReceived)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.successGreen)),
                    Text('बाकी: ${Formatters.currency(totalPending)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.errorRed)),
                  ],
                ),
              );
            },
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),

          // Logs list
          Expanded(
            child: logsAsync.when(
              data: (logs) {
                if (logs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit_note, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 8),
                        const Text(
                          'या कालावधीत कोणतीही नोंद नाही\n(No work entries in this period)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton.icon(
                          onPressed: () => _showAddEditLogDialog(context, ref),
                          icon: const Icon(Icons.add),
                          label: const Text('नवीन नोंद करा'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: logs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, idx) {
                    final log = logs[idx];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        log.customerName != null && log.customerName!.isNotEmpty
                                            ? log.customerName!
                                            : 'काम नोंद #${log.id}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      Text(
                                        Formatters.dateWithTime(log.logDate),
                                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 18),
                                      tooltip: 'दुरुस्त करा',
                                      onPressed: () => _showAddEditLogDialog(context, ref, log),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                      tooltip: 'हटवा',
                                      onPressed: () => _confirmDeleteLog(context, ref, log),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (log.jobNumber != null && log.jobNumber!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text('जॉब कार्ड: ${log.jobNumber}', style: const TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                            if (log.motorDetails != null && log.motorDetails!.isNotEmpty)
                              Text('मोटर: ${log.motorDetails}', style: const TextStyle(color: Colors.blueGrey, fontSize: 13)),
                            const SizedBox(height: 4),
                            Text('काम: ${log.workPerformed}', style: const TextStyle(fontSize: 14)),
                            if (log.partsUsed != null && log.partsUsed!.isNotEmpty)
                              Text('पार्ट्स: ${log.partsUsed}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            const Divider(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('मजुरी: ${Formatters.currency(log.labourCharges)}', style: const TextStyle(fontSize: 12)),
                                Text('जमा: ${Formatters.currency(log.paymentReceived)}', style: const TextStyle(fontSize: 12, color: AppTheme.successGreen, fontWeight: FontWeight.bold)),
                                Text('बाकी: ${Formatters.currency(log.pendingAmount)}', style: const TextStyle(fontSize: 12, color: AppTheme.errorRed, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditLogDialog(context, ref),
        tooltip: 'नवीन काम नोंदवा',
        child: const Icon(Icons.add),
      ),
    );
  }
}
