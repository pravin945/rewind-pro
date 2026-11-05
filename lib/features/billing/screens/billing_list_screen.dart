import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

final billCategoryFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final billSearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final invoicesListProvider = StreamProvider.autoDispose<List<Invoice>>((ref) {
  final category = ref.watch(billCategoryFilterProvider);
  return ref.watch(invoiceDaoProvider).watchAllInvoices(category: category);
});

class BillingListScreen extends ConsumerWidget {
  const BillingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final invoicesAsync = ref.watch(invoicesListProvider);
    final currentCat = ref.watch(billCategoryFilterProvider);
    final searchQuery = ref.watch(billSearchQueryProvider);

    final catOptions = [
      {'key': null, 'label': 'सर्व बिल (All)'},
      {'key': 'repair', 'label': 'मोटर रिपेअरिंग (Repair)'},
      {'key': 'parts_sales', 'label': 'साहित्य / पार्ट्स (Parts)'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.navBilling),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: strings.createBill,
            onPressed: () => context.push('/billing/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'बिल क्रमांक / ग्राहक शोधा...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => ref.read(billSearchQueryProvider.notifier).state = '',
                      )
                    : null,
                isDense: true,
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
              onChanged: (val) => ref.read(billSearchQueryProvider.notifier).state = val,
            ),
          ),

          // Category Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: catOptions.map((opt) {
                final isSelected = currentCat == opt['key'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(opt['label']!),
                    selected: isSelected,
                    selectedColor: AppTheme.primaryBlue.withOpacity(0.18),
                    checkmarkColor: AppTheme.primaryBlue,
                    onSelected: (_) {
                      ref.read(billCategoryFilterProvider.notifier).state = opt['key'] as String?;
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Invoice list
          Expanded(
            child: invoicesAsync.when(
              data: (invoices) {
                final filtered = invoices.where((inv) {
                  if (searchQuery.isEmpty) return true;
                  final q = searchQuery.toLowerCase();
                  return inv.invoiceNumber.toLowerCase().contains(q) ||
                      (inv.customerName != null && inv.customerName!.toLowerCase().contains(q)) ||
                      (inv.customerMobile != null && inv.customerMobile!.contains(q));
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        const Text(
                          'कोणतीही बिले सापडली नाहीत\n(No bills created yet)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => context.push('/billing/new'),
                          icon: const Icon(Icons.add),
                          label: Text(strings.createBill),
                        ),
                      ],
                    ),
                  );
                }

                // Summary calculations for current filter
                final totalBilled = filtered.fold<double>(0.0, (acc, inv) => acc + inv.grandTotal);
                final totalPending = filtered.fold<double>(0.0, (acc, inv) => acc + inv.pendingAmount);

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.blue.shade50.withOpacity(0.7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${filtered.length} बिले • एकूण: ${Formatters.currency(totalBilled)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          if (totalPending > 0)
                            Text('बाकी: ${Formatters.currency(totalPending)}',
                                style: const TextStyle(color: AppTheme.errorRed, fontWeight: FontWeight.bold, fontSize: 13))
                          else
                            const Text('सर्व हिशोब पूर्ण',
                                style: TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, idx) {
                          final inv = filtered[idx];
                          return Card(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => context.push('/billing/${inv.id}'),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          inv.invoiceNumber,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.primaryBlue),
                                        ),
                                        Text(
                                          Formatters.date(inv.invoiceDate),
                                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      inv.customerName ?? 'Walk-in Customer (रोख ग्राहक)',
                                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'प्रकार: ${_categoryLabel(inv.category)}',
                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                                    ),
                                    const Divider(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'एकूण: ${Formatters.currency(inv.grandTotal)}',
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                            ),
                                            Text(
                                              'जमा: ${Formatters.currency(inv.paidAmount)}',
                                              style: const TextStyle(fontSize: 12, color: AppTheme.successGreen),
                                            ),
                                          ],
                                        ),
                                        if (inv.pendingAmount > 0)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade50,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.red.shade200),
                                            ),
                                            child: Text(
                                              'बाकी: ${Formatters.currency(inv.pendingAmount)}',
                                              style: const TextStyle(color: AppTheme.errorRed, fontWeight: FontWeight.bold, fontSize: 13),
                                            ),
                                          )
                                        else
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade50,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.green.shade200),
                                            ),
                                            child: const Text(
                                              'पूर्ण भरले (Paid)',
                                              style: TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.bold, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/billing/new'),
        tooltip: strings.createBill,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _categoryLabel(String cat) {
    switch (cat) {
      case 'repair':
        return 'मोटर रिपेअरिंग (Repair)';
      case 'motor_sales':
        return 'नवीन मोटर विक्री (Motor Sales)';
      case 'parts_sales':
        return 'पार्ट्स विक्री (Parts Sales)';
      default:
        return cat;
    }
  }
}
