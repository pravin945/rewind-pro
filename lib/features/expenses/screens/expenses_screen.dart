import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

enum ExpenseFilter {
  today('आज (Today)'),
  yesterday('काल (Yesterday)'),
  thisWeek('या आठवड्यात (This Week)'),
  thisMonth('या महिन्यात (This Month)'),
  custom('तारीख निवडा (Custom Range)');

  final String label;
  const ExpenseFilter(this.label);
}

final expenseFilterProvider = StateProvider.autoDispose<ExpenseFilter>((ref) => ExpenseFilter.thisMonth);
final expenseCustomRangeProvider = StateProvider.autoDispose<DateTimeRange?>((ref) => null);

final expenseListProvider = StreamProvider.autoDispose<List<Expense>>((ref) {
  final filter = ref.watch(expenseFilterProvider);
  final customRange = ref.watch(expenseCustomRangeProvider);
  final dao = ref.watch(expenseDaoProvider);

  final now = DateTime.now();
  DateTime start;
  DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

  switch (filter) {
    case ExpenseFilter.today:
      start = DateTime(now.year, now.month, now.day);
      break;
    case ExpenseFilter.yesterday:
      final y = now.subtract(const Duration(days: 1));
      start = DateTime(y.year, y.month, y.day);
      end = DateTime(y.year, y.month, y.day, 23, 59, 59, 999);
      break;
    case ExpenseFilter.thisWeek:
      start = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
      break;
    case ExpenseFilter.thisMonth:
      start = DateTime(now.year, now.month, 1);
      break;
    case ExpenseFilter.custom:
      if (customRange != null) {
        start = DateTime(customRange.start.year, customRange.start.month, customRange.start.day);
        end = DateTime(customRange.end.year, customRange.end.month, customRange.end.day, 23, 59, 59, 999);
      } else {
        start = DateTime(now.year, now.month, 1);
      }
      break;
  }

  return dao.watchExpensesForDateRange(start, end);
});

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  Future<void> _handleFilterSelection(
    BuildContext context,
    WidgetRef ref,
    ExpenseFilter filter,
  ) async {
    if (filter == ExpenseFilter.custom) {
      final initialRange = ref.read(expenseCustomRangeProvider) ??
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
        ref.read(expenseCustomRangeProvider.notifier).state = picked;
        ref.read(expenseFilterProvider.notifier).state = ExpenseFilter.custom;
      }
    } else {
      ref.read(expenseFilterProvider.notifier).state = filter;
    }
  }

  void _showAddExpenseDialog(BuildContext context, WidgetRef ref) {
    final amountController = TextEditingController();
    String category = 'तांब्याची वायर / कच्चा माल (Copper Wire & Material)';
    String mode = 'cash';
    DateTime selectedDate = DateTime.now();
    final notesController = TextEditingController();

    final categories = [
      'तांब्याची वायर / कच्चा माल (Copper Wire & Material)',
      'बेअरिंग / ऑईल सील / सुटे भाग (Bearings & Parts)',
      'व्हार्निश / इन्सुलेशन पेपर (Varnish & Paper)',
      'लाईट बिल (Electricity Bill)',
      'दुकान भाडे (Shop Rent)',
      'चहा-पाणी / नाश्ता (Tea & Snacks)',
      'पेट्रोल / वाहतूक खर्च (Petrol & Transport)',
      'टूल्स व हत्यारे (Tools & Equipment)',
      'इतर दुकान खर्च (Other Expense)',
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('दुकान खर्च नोंदवा (Add Expense)'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'रक्कम (₹) *',
                    prefixIcon: Icon(Icons.currency_rupee),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: category,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'खर्च प्रकार (Category)'),
                  items: categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c, overflow: TextOverflow.ellipsis)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setDialogState(() => category = v);
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: mode,
                  decoration: const InputDecoration(labelText: 'पेमेंट प्रकार (Payment Mode)'),
                  items: const [
                    DropdownMenuItem(value: 'cash', child: Text('रोख (Cash)')),
                    DropdownMenuItem(value: 'upi', child: Text('UPI (GPay / PhonePe)')),
                    DropdownMenuItem(value: 'bank_transfer', child: Text('बँक (Bank)')),
                  ],
                  onChanged: (v) {
                    if (v != null) setDialogState(() => mode = v);
                  },
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('खर्चाचा दिनांक:'),
                  subtitle: Text(Formatters.date(selectedDate), style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.calendar_month, color: AppTheme.primaryBlue),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setDialogState(() => selectedDate = picked);
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(
                    labelText: 'टीप / शेरा (Optional)',
                    hintText: 'उदा. 5kg वायर खरेदी / वायरमॅन मजुरी',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा')),
            ElevatedButton(
              onPressed: () async {
                final amt = double.tryParse(amountController.text.trim()) ?? 0.0;
                if (amt <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('कृपया योग्य रक्कम टाका'), backgroundColor: Colors.red),
                  );
                  return;
                }

                await ref.read(expenseDaoProvider).insertExpense(
                      ExpensesCompanion.insert(
                        category: category,
                        amount: amt,
                        expenseDate: drift.Value(selectedDate),
                        paymentMode: drift.Value(mode),
                        notes: drift.Value(notesController.text.trim().isEmpty ? null : notesController.text.trim()),
                      ),
                    );

                if (context.mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('₹${amt.toStringAsFixed(0)} खर्च नोंदवला!'),
                      backgroundColor: AppTheme.successGreen,
                    ),
                  );
                }
              },
              child: const Text('जतन करा (Save)'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteExpense(BuildContext context, WidgetRef ref, Expense exp) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('खर्च हटवा (Delete Expense)'),
        content: Text('तुम्हाला ₹${Formatters.currency(exp.amount)} चा (${exp.category}) खर्च हटवायचा आहे का?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('मागे जा')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await ref.read(expenseDaoProvider).deleteExpense(exp.id);
              if (context.mounted) Navigator.pop(ctx);
            },
            child: const Text('हटवा (Delete)'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(expenseFilterProvider);
    final customRange = ref.watch(expenseCustomRangeProvider);
    final expensesAsync = ref.watch(expenseListProvider);

    String filterTitle = currentFilter.label;
    if (currentFilter == ExpenseFilter.custom && customRange != null) {
      filterTitle = '${Formatters.date(customRange.start)} - ${Formatters.date(customRange.end)}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('दुकान खर्च (Shop Expenses)'),
        actions: [
          PopupMenuButton<ExpenseFilter>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'कालावधी निवडा',
            onSelected: (val) => _handleFilterSelection(context, ref, val),
            itemBuilder: (context) {
              return ExpenseFilter.values.map((f) {
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
            icon: const Icon(Icons.add),
            tooltip: 'खर्च जोडा',
            onPressed: () => _showAddExpenseDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          InkWell(
            onTap: () => _handleFilterSelection(context, ref, ExpenseFilter.custom),
            child: Container(
              color: Colors.orange.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.deepOrange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'कालावधी: $filterTitle',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.deepOrange),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.deepOrange),
                ],
              ),
            ),
          ),

          // Total Summary Banner
          expensesAsync.when(
            data: (expenses) {
              final total = expenses.fold<double>(0.0, (acc, e) => acc + e.amount);
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${expenses.length} नोंदींचा एकूण खर्च:',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      Formatters.currency(total),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.errorRed),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          Expanded(
            child: expensesAsync.when(
              data: (expenses) {
                if (expenses.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.money_off, size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        const Text(
                          'या कालावधीत कोणताही खर्च नोंदवलेला नाही\n(No expenses in this period)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => _showAddExpenseDialog(context, ref),
                          icon: const Icon(Icons.add),
                          label: const Text('खर्च नोंदवा'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: expenses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, idx) {
                    final exp = expenses[idx];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red.shade50,
                              child: const Icon(Icons.money_off, color: Colors.red),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exp.category,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${Formatters.date(exp.expenseDate)} • ${exp.paymentMode.toUpperCase()}',
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                  if (exp.notes != null && exp.notes!.isNotEmpty) ...[
                                    const SizedBox(height: 3),
                                    Text(
                                      exp.notes!,
                                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Formatters.currency(exp.amount),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.errorRed),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.grey),
                                  tooltip: 'हटवा',
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () => _confirmDeleteExpense(context, ref, exp),
                                ),
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
        onPressed: () => _showAddExpenseDialog(context, ref),
        tooltip: 'खर्च जोडा',
        child: const Icon(Icons.add),
      ),
    );
  }
}
