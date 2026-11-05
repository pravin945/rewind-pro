import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/daos/product_dao.dart';
import '../../../core/database/daos/repair_job_dao.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/customer_action_helper.dart';
import '../../../core/utils/formatters.dart';

final jobDetailsProvider = FutureProvider.autoDispose.family<RepairJobWithDetails?, int>((ref, id) {
  return ref.watch(repairJobDaoProvider).getJobDetails(id);
});

class RepairJobDetailsScreen extends ConsumerWidget {
  final int jobId;
  const RepairJobDetailsScreen({super.key, required this.jobId});

  Future<void> _handleGenerateBill(BuildContext context, WidgetRef ref, RepairJob job) async {
    final invoiceDao = ref.read(invoiceDaoProvider);
    final existingBill = await invoiceDao.getInvoiceForRepairJob(job.id);

    if (existingBill != null && context.mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.receipt_long, color: Colors.teal),
              SizedBox(width: 8),
              Text('बिल आधीच तयार आहे'),
            ],
          ),
          content: Text(
            'या कामासाठी बिल (${existingBill.invoiceNumber}) आधीच बनवले आहे.\n\n'
            'तारीख: ${Formatters.date(existingBill.invoiceDate)}\n'
            'एकूण रक्कम: ${Formatters.currency(existingBill.grandTotal)}\n'
            'बाकी रक्कम: ${Formatters.currency(existingBill.pendingAmount)}\n\n'
            'तुम्हाला हे बिल पहायचे आहे का?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('रद्द करा (Close)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.push('/billing/${existingBill.id}');
              },
              child: const Text('बिल पहा (View Bill)'),
            ),
          ],
        ),
      );
    } else if (context.mounted) {
      context.push('/billing/new?repairJobId=${job.id}');
    }
  }

  void _showAddPartDialog(BuildContext context, WidgetRef ref) async {
    final products = await ref.read(productDaoProvider).getAllProducts();
    if (!context.mounted) return;

    ProductWithCategory? selectedProduct;
    final nameController = TextEditingController();
    final qtyController = TextEditingController(text: '1');
    final priceController = TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.extension, color: AppTheme.accentOrange),
                SizedBox(width: 8),
                Text('पार्ट जोडा (Add Spare Part)'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Select from existing product if available
                  if (products.isNotEmpty) ...[
                    DropdownButtonFormField<ProductWithCategory?>(
                      value: selectedProduct,
                      decoration: const InputDecoration(
                        labelText: 'स्टॉकमधून पार्ट निवडा (Optional)',
                        prefixIcon: Icon(Icons.inventory_2),
                      ),
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('इतर / नवीन पार्ट (Manual)')),
                        ...products.map(
                          (p) => DropdownMenuItem(
                            value: p,
                            child: Text(
                              '${p.product.name} (स्टॉक: ${p.product.currentStock}) - ₹${p.product.sellingPrice}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (val) {
                        setDialogState(() {
                          selectedProduct = val;
                          if (val != null) {
                            nameController.text = val.product.name;
                            priceController.text = val.product.sellingPrice.toStringAsFixed(0);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                  ],

                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'पार्टचे नाव (Part Name) *',
                      prefixIcon: Icon(Icons.build),
                      hintText: 'उदा. बेअरिंग 6204 / मेकॅनिकल सील',
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: qtyController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'नग (Qty) *',
                            prefixIcon: Icon(Icons.format_list_numbered),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'दर / किंमत (₹) *',
                            prefixIcon: Icon(Icons.currency_rupee),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('रद्द करा (Cancel)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) return;
                  final qty = double.tryParse(qtyController.text.trim()) ?? 1.0;
                  final price = double.tryParse(priceController.text.trim()) ?? 0.0;
                  final total = qty * price;

                  await ref.read(repairJobDaoProvider).addJobParts(jobId, [
                    RepairJobPartsCompanion.insert(
                      repairJobId: jobId,
                      productId: drift.Value(selectedProduct?.product.id),
                      partName: name,
                      quantity: drift.Value(qty),
                      unitPrice: drift.Value(price),
                      totalPrice: drift.Value(total),
                    ),
                  ]);

                  ref.invalidate(jobDetailsProvider(jobId));
                  if (context.mounted) Navigator.pop(ctx);
                },
                child: const Text('जोडा (Add Part)'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDeletePart(BuildContext context, WidgetRef ref, RepairJobPart part) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('पार्ट काढायचा आहे का?'),
        content: Text('${part.partName} हा पार्ट काढल्यास इन्व्हेंटरी स्टॉक पुन्हा जमा होईल आणि एकूण बिलातून रक्कम वजा होईल.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('रद्द करा')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('काढा (Remove)'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(repairJobDaoProvider).removeJobPart(part.id);
      ref.invalidate(jobDetailsProvider(jobId));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobDetailsAsync = ref.watch(jobDetailsProvider(jobId));
    final settingsAsync = ref.watch(businessSettingsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(jobDetailsAsync.value?.job.jobNumber ?? 'काम तपशील'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'दुरुस्त करा (Edit Job)',
            onPressed: () async {
              await context.push('/jobs/$jobId/edit');
              ref.invalidate(jobDetailsProvider(jobId));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'हटवा (Delete Job)',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('जॉब कार्ड हटवायचे आहे का?'),
                  content: const Text('हे काम डिलीट केल्यास ते यादीतून काढले जाईल. आधीचा हिशोब डेटा सुरक्षित राहील.'),
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

              if (confirm == true && context.mounted) {
                await ref.read(repairJobDaoProvider).softDeleteJob(jobId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: jobDetailsAsync.when(
        data: (details) {
          if (details == null) {
            return const Center(child: Text('काम सापडले नाही (Job not found)'));
          }

          final job = details.job;
          final customer = details.customer;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
                            job.jobNumber,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                          ),
                          _StatusDropdown(
                            job: job,
                            customer: customer,
                            shopName: settingsAsync.value?.shopName ?? 'प्रताप इलेक्ट्रिकल्स',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${job.motorType} • ${job.motorBrand} ${job.motorHp}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('फेज: ${job.motorPhase} ${job.motorVoltage != null ? "• ${job.motorVoltage}" : ""}'),
                      if (job.motorSerialNumber != null && job.motorSerialNumber!.isNotEmpty)
                        Text('सिरीयल नं: ${job.motorSerialNumber}'),
                      const Divider(height: 20),
                      Text('समस्या / फॉल्ट: ${job.problemDescription}', style: const TextStyle(fontWeight: FontWeight.w500)),
                      if (job.workDescription != null && job.workDescription!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text('केलेले काम: ${job.workDescription}'),
                        ),
                      if (job.warrantyInfo != null && job.warrantyInfo!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text('वॉरंटी: ${job.warrantyInfo}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'जमा तारीख: ${Formatters.date(job.receivedDate)}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            'अपेक्षित डिलिव्हरी: ${Formatters.date(job.expectedDeliveryDate)}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Customer Info Card
              if (customer != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.primaryBlue.withOpacity(0.12),
                          child: const Icon(Icons.person, color: AppTheme.primaryBlue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(customer.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              Row(
                                children: [
                                  Text(customer.mobile, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () => CustomerActionHelper.callPhone(context, customer.mobile),
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.12), shape: BoxShape.circle),
                                      child: const Icon(Icons.phone, size: 14, color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                              if (customer.villageCity != null && customer.villageCity!.isNotEmpty)
                                Text(customer.villageCity!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green.shade700,
                            side: BorderSide(color: Colors.green.shade700),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          ),
                          icon: const Icon(Icons.send_rounded, size: 14),
                          label: const Text('मेसेज', style: TextStyle(fontSize: 12)),
                          onPressed: () {
                            final shopName = settingsAsync.value?.shopName ?? 'प्रताप इलेक्ट्रिकल्स';
                            CustomerActionHelper.showJobStatusNotifyOptions(
                              context,
                              rawPhone: customer.mobile,
                              customerName: customer.name,
                              jobNumber: job.jobNumber,
                              motorDetails: '${job.motorType} ${job.motorHp}',
                              statusText: Formatters.statusText(job.jobStatus),
                              remainingAmount: job.remainingAmount,
                              shopName: shopName,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 12),

              // Cost Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('खर्च व हिशोब (Amount Details)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Divider(),
                      _PriceRow(label: 'मजुरी आकार (Labour):', amount: job.labourCharges),
                      _PriceRow(label: 'मटेरियल आकार (Material):', amount: job.materialCharges),
                      if (job.otherCharges > 0) _PriceRow(label: 'इतर आकार:', amount: job.otherCharges),
                      if (job.discount > 0) _PriceRow(label: 'सवलत (Discount):', amount: -job.discount, isDiscount: true),
                      const Divider(),
                      _PriceRow(label: 'एकूण रक्कम (Final Amount):', amount: job.finalAmount, isBold: true),
                      _PriceRow(label: 'अॅडव्हान्स जमा (Advance):', amount: job.advancePayment, color: AppTheme.successGreen),
                      _PriceRow(
                        label: 'बाकी रक्कम (Remaining):',
                        amount: job.remainingAmount,
                        isBold: true,
                        color: job.remainingAmount > 0 ? AppTheme.errorRed : AppTheme.successGreen,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Parts List Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('वापरलेले पार्ट्स (Parts Used)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          TextButton.icon(
                            onPressed: () => _showAddPartDialog(context, ref),
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text('पार्ट जोडा'),
                          ),
                        ],
                      ),
                      const Divider(),
                      if (details.parts.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('कोणतेही पार्ट्स जोडलेले नाहीत (No parts added)', style: TextStyle(color: Colors.grey)),
                        )
                      else
                        ...details.parts.map(
                          (p) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text('${p.partName} (${p.quantity} नग)'),
                                ),
                                Text(Formatters.currency(p.totalPrice), style: const TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => _confirmDeletePart(context, ref, p),
                                  child: const Icon(Icons.close, size: 18, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Status History Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('कामाचा इतिहास (Status History)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Divider(),
                      ...details.statusHistory.map(
                        (h) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.circle, size: 8, color: AppTheme.primaryBlue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${Formatters.statusText(h.toStatus)} ${h.notes != null ? "- ${h.notes}" : ""}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              Text(
                                Formatters.dateWithTime(h.changedAt),
                                style: const TextStyle(fontSize: 11, color: Colors.grey),
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

              // Bottom Action Button
              ElevatedButton.icon(
                onPressed: () => _handleGenerateBill(context, ref, job),
                icon: const Icon(Icons.receipt_long),
                label: const Text('या कामाचे बिल बनवा (Generate Bill)', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _StatusDropdown extends ConsumerWidget {
  final RepairJob job;
  final Customer? customer;
  final String shopName;

  const _StatusDropdown({
    required this.job,
    required this.customer,
    required this.shopName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStatus = job.jobStatus;
    final statusList = [
      'received',
      'inspection',
      'inProgress',
      'waitingForParts',
      'completed',
      'delivered',
    ];

    return DropdownButton<String>(
      value: currentStatus,
      underline: const SizedBox(),
      items: statusList.map((st) {
        return DropdownMenuItem(
          value: st,
          child: Text(
            Formatters.statusText(st),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
      onChanged: (newStatus) async {
        if (newStatus != null && newStatus != currentStatus) {
          await ref.read(repairJobDaoProvider).updateJobStatus(job.id, newStatus);
          ref.invalidate(jobDetailsProvider(job.id));

          if (context.mounted && customer != null) {
            if (newStatus == 'completed' || newStatus == 'delivered') {
              CustomerActionHelper.showJobStatusNotifyOptions(
                context,
                rawPhone: customer!.mobile,
                customerName: customer!.name,
                jobNumber: job.jobNumber,
                motorDetails: '${job.motorType} ${job.motorHp}',
                statusText: Formatters.statusText(newStatus),
                remainingAmount: job.remainingAmount,
                shopName: shopName,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('स्थिती बदलली: ${Formatters.statusText(newStatus)}'),
                  action: SnackBarAction(
                    label: 'मेसेज पाठवा',
                    onPressed: () {
                      CustomerActionHelper.showJobStatusNotifyOptions(
                        context,
                        rawPhone: customer!.mobile,
                        customerName: customer!.name,
                        jobNumber: job.jobNumber,
                        motorDetails: '${job.motorType} ${job.motorHp}',
                        statusText: Formatters.statusText(newStatus),
                        remainingAmount: job.remainingAmount,
                        shopName: shopName,
                      );
                    },
                  ),
                  duration: const Duration(seconds: 4),
                ),
              );
            }
          }
        }
      },
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isBold;
  final bool isDiscount;
  final Color? color;

  const _PriceRow({
    required this.label,
    required this.amount,
    this.isBold = false,
    this.isDiscount = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isBold ? 15 : 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(
            isDiscount ? '- ${Formatters.currency(amount.abs())}' : Formatters.currency(amount),
            style: style,
          ),
        ],
      ),
    );
  }
}
