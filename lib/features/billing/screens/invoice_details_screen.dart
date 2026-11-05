import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/daos/invoice_dao.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/services/pdf_invoice_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/customer_action_helper.dart';
import '../../../core/utils/formatters.dart';

final invoiceDetailsProvider = FutureProvider.autoDispose.family<InvoiceWithDetails?, int>((ref, id) {
  return ref.watch(invoiceDaoProvider).getInvoiceDetails(id);
});

class InvoiceDetailsScreen extends ConsumerStatefulWidget {
  final int invoiceId;

  const InvoiceDetailsScreen({super.key, required this.invoiceId});

  @override
  ConsumerState<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends ConsumerState<InvoiceDetailsScreen> {
  bool _isProcessing = false;

  void _printPdf(InvoiceWithDetails details) async {
    setState(() => _isProcessing = true);
    try {
      final settings = await ref.read(settingsDaoProvider).getSettings();
      await PdfInvoiceService.printInvoice(details, settings);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('प्रिंट एरर: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _sharePdf(InvoiceWithDetails details) async {
    setState(() => _isProcessing = true);
    try {
      final settings = await ref.read(settingsDaoProvider).getSettings();
      await PdfInvoiceService.shareInvoicePdf(details, settings);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('शेअर एरर: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _shareWhatsAppText(InvoiceWithDetails details) async {
    final inv = details.invoice;
    final mobile = inv.customerMobile ?? details.customer?.mobile ?? '';

    final settings = await ref.read(settingsDaoProvider).getSettings();
    final shopName = settings?.shopName ?? 'प्रताप इलेक्ट्रिकल्स & मोटर रिवाइंडिंग';
    final ownerName = settings?.ownerName ?? 'दिनेश जाधव';
    final phone = settings?.mobileNumber ?? '9623314436';

    final text = '''
*=== $shopName ===*
*बिल तपशील (Bill Summary)*

• *बिल नं:* ${inv.invoiceNumber}
• *दिनांक:* ${Formatters.date(inv.invoiceDate)}
• *ग्राहक:* ${inv.customerName ?? "ग्राहक"}
• *प्रकार:* ${inv.category == 'repair' ? 'मोटर रिपेअरिंग' : 'साहित्य विक्री'}

*हिशोब:*
• सबटोटल: ${Formatters.currency(inv.subtotal)}
${inv.discount > 0 ? '• सवलत: - ${Formatters.currency(inv.discount)}\n' : ''}${inv.taxAmount > 0 ? '• GST: + ${Formatters.currency(inv.taxAmount)}\n' : ''}• *एकूण बिल:* ${Formatters.currency(inv.grandTotal)}
• *जमा रक्कम:* ${Formatters.currency(inv.paidAmount)}
• *बाकी रक्कम:* *${Formatters.currency(inv.pendingAmount)}*

धन्यवाद! 🙏
*संपर्क:* $ownerName - $phone
''';

    await CustomerActionHelper.shareViaWhatsApp(mobile, text);
  }

  void _showRecordPaymentDialog(BuildContext context, Invoice invoice) {
    final amountController = TextEditingController(
      text: invoice.pendingAmount > 0 ? invoice.pendingAmount.toStringAsFixed(0) : '0',
    );
    String mode = 'cash';
    final refController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('जमा पेमेंट नोंदवा (Receive Payment)'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      const Text('उर्वरित बाकी:', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(
                        Formatters.currency(invoice.pendingAmount),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.errorRed),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
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
                  decoration: const InputDecoration(labelText: 'पेमेंट प्रकार (Mode)'),
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
                      labelText: 'UTR / संदर्भ क्रमांक (Reference No)',
                      hintText: 'उदा. UPI Ref / Cheque No',
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'टीप / शेरा (Optional)'),
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

                await ref.read(paymentDaoProvider).recordPayment(
                      PaymentsCompanion.insert(
                        customerId: invoice.customerId ?? 0,
                        invoiceId: drift.Value(invoice.id),
                        repairJobId: drift.Value(invoice.repairJobId),
                        amountReceived: amt,
                        paymentMode: drift.Value(mode),
                        transactionReference: drift.Value(refController.text.trim().isEmpty ? null : refController.text.trim()),
                        notes: drift.Value(notesController.text.trim().isEmpty ? null : notesController.text.trim()),
                      ),
                    );

                ref.invalidate(invoiceDetailsProvider(invoice.id));
                if (context.mounted) Navigator.pop(ctx);
              },
              child: const Text('जमा करा (Save)'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, Invoice invoice) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('बिल रद्द करा (Cancel Invoice)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'हे बिल रद्द केल्यास:\n• बिल नंबर कायमचा सुरक्षित राहील (पुन्हा वापरता येणार नाही)\n• विकलेले साहित्य आपोआप इन्व्हेंटरी स्टॉकमध्ये जमा होईल\n• ग्राहकाच्या खात्यावरील बाकी कमी होईल.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'रद्द करण्याचे कारण (Reason) *',
                hintText: 'उदा. चुकीची नोंद / ग्राहक परत गेला',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('मागे जा')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('कृपया रद्द करण्याचे कारण लिहा'), backgroundColor: Colors.red),
                );
                return;
              }

              await ref.read(invoiceDaoProvider).cancelInvoice(invoice.id, reason);
              ref.invalidate(invoiceDetailsProvider(invoice.id));
              if (context.mounted) Navigator.pop(ctx);
            },
            child: const Text('कॅन्सल करा'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final invoiceDetailsAsync = ref.watch(invoiceDetailsProvider(widget.invoiceId));

    return Scaffold(
      appBar: AppBar(
        title: Text(invoiceDetailsAsync.value?.invoice.invoiceNumber ?? 'बिल तपशील'),
        actions: [
          if (invoiceDetailsAsync.value?.invoice.isCancelled == false)
            PopupMenuButton<String>(
              onSelected: (val) {
                if (val == 'cancel') {
                  _showCancelDialog(context, invoiceDetailsAsync.value!.invoice);
                }
              },
              itemBuilder: (ctx) => [
                const PopupMenuItem(
                  value: 'cancel',
                  child: Row(
                    children: [
                      Icon(Icons.cancel_outlined, color: Colors.red),
                      SizedBox(width: 8),
                      Text('बिल रद्द करा (Cancel Bill)', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: invoiceDetailsAsync.when(
        data: (details) {
          if (details == null) {
            return const Center(child: Text('बिल सापडले नाही (Invoice not found)'));
          }

          final inv = details.invoice;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (inv.isCancelled)
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.cancel, color: Colors.red, size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'हे बिल रद्द (Cancelled) केले आहे.\nकारण: ${inv.cancellationReason ?? "-"}',
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

              // Header Card
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
                            inv.invoiceNumber,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: inv.pendingAmount <= 0 ? Colors.green.shade50 : Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: inv.pendingAmount <= 0 ? Colors.green.shade200 : Colors.orange.shade200),
                            ),
                            child: Text(
                              inv.pendingAmount <= 0 ? 'पूर्ण भरले (Paid)' : 'बाकी (Pending)',
                              style: TextStyle(
                                color: inv.pendingAmount <= 0 ? AppTheme.successGreen : Colors.orange.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('दिनांक: ${Formatters.date(inv.invoiceDate)}', style: const TextStyle(color: Colors.grey)),
                      const Divider(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.person, color: AppTheme.primaryBlue, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  inv.customerName ?? 'Walk-in Customer (रोख ग्राहक)',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                if (inv.customerMobile != null && inv.customerMobile!.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(inv.customerMobile!),
                                ],
                              ],
                            ),
                          ),
                          if (inv.customerMobile != null && inv.customerMobile!.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.call, color: AppTheme.primaryBlue),
                              tooltip: 'कॉल करा',
                              onPressed: () => CustomerActionHelper.makePhoneCall(inv.customerMobile!),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'प्रकार: ${_categoryLabel(inv.category)}',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Action Buttons: Print PDF & Share
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isProcessing ? null : () => _printPdf(details),
                      icon: const Icon(Icons.print),
                      label: const Text('PDF प्रिंट'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : () => _sharePdf(details),
                      icon: const Icon(Icons.share),
                      label: const Text('PDF शेअर'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => _shareWhatsAppText(details),
                icon: const Icon(Icons.chat, color: AppTheme.whatsappGreen),
                label: const Text('WhatsApp वर बिल मेसेज पाठवा'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                ),
              ),
              const SizedBox(height: 16),

              // Items Table Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('बिल आयटम्स (Items & Services)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Divider(),
                      ...details.items.map(
                        (it) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(it.description, style: const TextStyle(fontWeight: FontWeight.w500)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${it.quantity % 1 == 0 ? it.quantity.toInt() : it.quantity} नग',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  Formatters.currency(it.amount),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 20),
                      _RowText('सबटोटल (Subtotal):', Formatters.currency(inv.subtotal)),
                      if (inv.discount > 0)
                        _RowText('सवलत (Discount):', '- ${Formatters.currency(inv.discount)}', color: AppTheme.successGreen),
                      if (inv.taxAmount > 0)
                        _RowText('GST / Tax:', '+ ${Formatters.currency(inv.taxAmount)}'),
                      const Divider(height: 16),
                      _RowText('अंतिम एकूण (Grand Total):', Formatters.currency(inv.grandTotal), isBold: true),
                      _RowText('जमा रक्कम (Paid Amount):', Formatters.currency(inv.paidAmount), color: AppTheme.successGreen),
                      _RowText(
                        'बाकी रक्कम (Pending Amount):',
                        Formatters.currency(inv.pendingAmount),
                        isBold: true,
                        color: inv.pendingAmount > 0 ? AppTheme.errorRed : AppTheme.successGreen,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Payment History for this invoice
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('पेमेंट इतिहास (Payment History)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          if (!inv.isCancelled && inv.pendingAmount > 0)
                            TextButton.icon(
                              onPressed: () => _showRecordPaymentDialog(context, inv),
                              icon: const Icon(Icons.add),
                              label: const Text('पेमेंट जमा करा'),
                            ),
                        ],
                      ),
                      const Divider(),
                      if (details.payments.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('कोणतेही पेमेंट नोंदवलेले नाही', style: TextStyle(color: Colors.grey)),
                        )
                      else
                        ...details.payments.map(
                          (p) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${p.paymentMode.toUpperCase()} • ${Formatters.date(p.paymentDate)}',
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    if (p.transactionReference != null && p.transactionReference!.isNotEmpty)
                                      Text('Ref: ${p.transactionReference}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                  ],
                                ),
                                Text(
                                  Formatters.currency(p.amountReceived),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.successGreen),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              if (!inv.isCancelled && inv.pendingAmount > 0)
                ElevatedButton.icon(
                  onPressed: () => _showRecordPaymentDialog(context, inv),
                  icon: const Icon(Icons.payment),
                  label: const Text('बाकी रक्कम जमा करा (Record Payment)', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              const SizedBox(height: 24),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  String _categoryLabel(String cat) {
    switch (cat) {
      case 'repair':
        return 'मोटर रिपेअरिंग (Motor Repair)';
      case 'motor_sales':
        return 'नवीन मोटर विक्री (Motor Sales)';
      case 'parts_sales':
        return 'पार्ट्स विक्री (Parts Sales)';
      default:
        return cat;
    }
  }
}

class _RowText extends StatelessWidget {
  final String label;
  final String val;
  final bool isBold;
  final Color? color;

  const _RowText(this.label, this.val, {this.isBold = false, this.color});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isBold ? 16 : 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(val, style: style),
        ],
      ),
    );
  }
}
