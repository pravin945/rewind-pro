import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/daos/payment_dao.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/customer_action_helper.dart';
import '../../../core/utils/formatters.dart';

final pendingSortProvider = StateProvider.autoDispose<String>((ref) => 'amount'); // 'amount' or 'oldest'

final pendingPaymentsListProvider = FutureProvider.autoDispose<List<CustomerPendingInfo>>((ref) {
  final sort = ref.watch(pendingSortProvider);
  return ref.watch(paymentDaoProvider).getPendingPaymentsList(sortBy: sort);
});

class PendingPaymentsScreen extends ConsumerWidget {
  const PendingPaymentsScreen({super.key});

  void _showRecordPaymentDialog(BuildContext context, WidgetRef ref, CustomerPendingInfo item) {
    final amountController = TextEditingController(text: item.remainingBalance.toStringAsFixed(0));
    String mode = 'cash';
    final refController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('${item.customer.name} - पेमेंट जमा करा'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('एकूण बाकी:'),
                      Text(
                        Formatters.currency(item.remainingBalance),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.errorRed),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'जमा रक्कम (₹) *',
                    prefixIcon: Icon(Icons.currency_rupee),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: mode,
                  decoration: const InputDecoration(labelText: 'पेमेंट प्रकार'),
                  items: const [
                    DropdownMenuItem(value: 'cash', child: Text('रोख (Cash)')),
                    DropdownMenuItem(value: 'upi', child: Text('UPI (GPay/PhonePe)')),
                    DropdownMenuItem(value: 'bank_transfer', child: Text('बँक (Bank)')),
                  ],
                  onChanged: (v) {
                    if (v != null) setDialogState(() => mode = v);
                  },
                ),
                const SizedBox(height: 12),
                if (mode != 'cash') ...[
                  TextField(
                    controller: refController,
                    decoration: const InputDecoration(
                      labelText: 'संदर्भ क्र. (Reference No)',
                      hintText: 'उदा. UPI Ref No',
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'टीप (Optional)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा')),
            ElevatedButton(
              onPressed: () async {
                final amt = double.tryParse(amountController.text.trim()) ?? 0.0;
                if (amt <= 0) return;

                await ref.read(paymentDaoProvider).recordPayment(
                      PaymentsCompanion.insert(
                        customerId: item.customer.id,
                        amountReceived: amt,
                        paymentMode: drift.Value(mode),
                        transactionReference: drift.Value(refController.text.trim().isEmpty ? null : refController.text.trim()),
                        notes: drift.Value(notesController.text.trim().isEmpty ? null : notesController.text.trim()),
                      ),
                    );

                ref.invalidate(pendingPaymentsListProvider);
                if (context.mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.customer.name} चे ₹${amt.toStringAsFixed(0)} जमा झाले!'),
                      backgroundColor: AppTheme.successGreen,
                    ),
                  );
                }
              },
              child: const Text('जमा करा (Save)'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendReminder(BuildContext context, WidgetRef ref, CustomerPendingInfo item) async {
    final settings = await ref.read(settingsDaoProvider).getSettings();
    final shopName = settings?.shopName ?? 'प्रताप इलेक्ट्रिकल्स';

    CustomerActionHelper.showNotifyOptions(
      context,
      rawPhone: item.customer.mobile,
      customerName: item.customer.name,
      billedAmount: item.totalBilled,
      paidAmount: item.totalPaid,
      pendingAmount: item.remainingBalance,
      shopName: shopName,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSort = ref.watch(pendingSortProvider);
    final pendingAsync = ref.watch(pendingPaymentsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('बाकी रक्कम यादी (Pending Payments)'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            tooltip: 'क्रमवारी (Sort)',
            onSelected: (val) => ref.read(pendingSortProvider.notifier).state = val,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'amount',
                child: Text(
                  'सर्वात जास्त बाकी (Highest Amount)',
                  style: TextStyle(fontWeight: currentSort == 'amount' ? FontWeight.bold : FontWeight.normal),
                ),
              ),
              PopupMenuItem(
                value: 'oldest',
                child: Text(
                  'सर्वात जुनी बाकी (Oldest Pending)',
                  style: TextStyle(fontWeight: currentSort == 'oldest' ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
      body: pendingAsync.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 64, color: AppTheme.successGreen),
                  SizedBox(height: 12),
                  Text('सर्व हिशोब पूर्ण आहे! कोणतीही बाकी नाही.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }

          final grandTotalRemaining = list.fold<double>(0.0, (acc, item) => acc + item.remainingBalance);

          return Column(
            children: [
              // Summary Banner
              Container(
                color: Colors.red.shade50,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${list.length} ग्राहकांकडे बाकी रक्कम:'),
                    Text(
                      Formatters.currency(grandTotalRemaining),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.errorRed),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, idx) {
                    final item = list[idx];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => context.push('/customers/${item.customer.id}'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.customer.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    Formatters.currency(item.remainingBalance),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.errorRed),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(item.customer.mobile),
                                if (item.customer.villageCity != null && item.customer.villageCity!.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  Text('• ${item.customer.villageCity}'),
                                ],
                              ],
                            ),
                            const Divider(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('एकूण बिल: ${Formatters.currency(item.totalBilled)}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                Text('जमा: ${Formatters.currency(item.totalPaid)}', style: const TextStyle(fontSize: 12, color: AppTheme.successGreen)),
                                if (item.oldestPendingDate != null)
                                  Text('जुने बिल: ${Formatters.date(item.oldestPendingDate)}', style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Direct Action buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () => CustomerActionHelper.makePhoneCall(item.customer.mobile),
                                  icon: const Icon(Icons.call, size: 16),
                                  label: const Text('कॉल'),
                                  style: OutlinedButton.styleFrom(
                                    visualDensity: VisualDensity.compact,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton.icon(
                                  onPressed: () => _sendReminder(context, ref, item),
                                  icon: const Icon(Icons.send, size: 16, color: AppTheme.whatsappGreen),
                                  label: const Text('मेसेज'),
                                  style: OutlinedButton.styleFrom(
                                    visualDensity: VisualDensity.compact,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  onPressed: () => _showRecordPaymentDialog(context, ref, item),
                                  icon: const Icon(Icons.add, size: 16),
                                  label: const Text('पेमेंट जमा'),
                                  style: ElevatedButton.styleFrom(
                                    visualDensity: VisualDensity.compact,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
