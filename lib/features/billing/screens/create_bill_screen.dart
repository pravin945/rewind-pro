import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

class _BillItemEntry {
  int? productId;
  final TextEditingController descController;
  final TextEditingController qtyController;
  final TextEditingController rateController;

  _BillItemEntry({
    this.productId,
    String description = '',
    double quantity = 1.0,
    double rate = 0.0,
  })  : descController = TextEditingController(text: description),
        qtyController = TextEditingController(
          text: quantity % 1 == 0 ? quantity.toInt().toString() : quantity.toString(),
        ),
        rateController = TextEditingController(
          text: rate % 1 == 0 ? rate.toInt().toString() : rate.toString(),
        );

  double get quantity => double.tryParse(qtyController.text.trim()) ?? 0.0;
  double get rate => double.tryParse(rateController.text.trim()) ?? 0.0;
  double get amount => quantity * rate;
}

class CreateBillScreen extends ConsumerStatefulWidget {
  final String? initialCategory;
  final int? preselectedCustomerId;
  final int? repairJobId;

  const CreateBillScreen({
    super.key,
    this.initialCategory,
    this.preselectedCustomerId,
    this.repairJobId,
  });

  @override
  ConsumerState<CreateBillScreen> createState() => _CreateBillScreenState();
}

class _CreateBillScreenState extends ConsumerState<CreateBillScreen> {
  final _formKey = GlobalKey<FormState>();

  String _category = 'repair';
  int? _selectedCustomerId;
  final _walkInNameController = TextEditingController();
  final _walkInMobileController = TextEditingController();
  final _discountController = TextEditingController(text: '0');
  final _paidAmountController = TextEditingController(text: '0');
  String _paymentMode = 'cash';
  final _notesController = TextEditingController();

  bool _applyGst = false;
  double _gstRate = 18.0;

  final List<_BillItemEntry> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory ?? 'repair';
    _selectedCustomerId = widget.preselectedCustomerId;

    if (widget.repairJobId != null) {
      _loadRepairJobDetails(widget.repairJobId!);
    } else {
      if (_category == 'repair') {
        _items.add(_BillItemEntry(description: 'मोटर रिवाइंडिंग मजुरी व साहित्य', quantity: 1, rate: 1000));
      } else if (_category == 'motor_sales') {
        _items.add(_BillItemEntry(description: 'नवीन सबमर्सिबल / मोटर पंप संच', quantity: 1, rate: 15000));
      } else {
        _items.add(_BillItemEntry(description: 'स्पेअर पार्ट', quantity: 1, rate: 250));
      }
    }

    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await ref.read(settingsDaoProvider).getSettings();
    if (settings != null && mounted) {
      setState(() {
        _applyGst = settings.isGstEnabled;
        _gstRate = settings.defaultTaxRate > 0 ? settings.defaultTaxRate : 18.0;
      });
    }
  }

  Future<void> _loadRepairJobDetails(int jobId) async {
    final details = await ref.read(repairJobDaoProvider).getJobDetails(jobId);
    if (details != null && mounted) {
      setState(() {
        _category = 'repair';
        _selectedCustomerId = details.job.customerId;
        _items.clear();

        // 1. Add labour charges item
        if (details.job.labourCharges > 0) {
          _items.add(
            _BillItemEntry(
              description: 'रिवाइंडिंग मजुरी (${details.job.motorType} ${details.job.motorHp})',
              quantity: 1,
              rate: details.job.labourCharges,
            ),
          );
        }

        // 2. Add parts used
        for (final p in details.parts) {
          _items.add(
            _BillItemEntry(
              productId: p.productId,
              description: p.partName,
              quantity: p.quantity,
              rate: p.unitPrice,
            ),
          );
        }

        if (_items.isEmpty) {
          _items.add(
            _BillItemEntry(
              description: '${details.job.motorType} रिपेअरिंग (${details.job.motorBrand})',
              quantity: 1,
              rate: details.job.finalAmount,
            ),
          );
        }

        _discountController.text = details.job.discount > 0 ? details.job.discount.toStringAsFixed(0) : '0';
        _paidAmountController.text = details.job.advancePayment > 0 ? details.job.advancePayment.toStringAsFixed(0) : '0';
      });
    }
  }

  @override
  void dispose() {
    for (final it in _items) {
      it.descController.dispose();
      it.qtyController.dispose();
      it.rateController.dispose();
    }
    _walkInNameController.dispose();
    _walkInMobileController.dispose();
    _discountController.dispose();
    _paidAmountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  double get _subtotal => _items.fold(0.0, (acc, it) => acc + it.amount);
  double get _discount => double.tryParse(_discountController.text.trim()) ?? 0.0;
  double get _taxableAmount {
    final amt = _subtotal - _discount;
    return amt < 0.0 ? 0.0 : amt;
  }

  double get _taxAmount => _applyGst ? (_taxableAmount * (_gstRate / 100.0)) : 0.0;
  double get _grandTotal => _taxableAmount + _taxAmount;

  double get _paidAmount => double.tryParse(_paidAmountController.text.trim()) ?? 0.0;
  double get _pendingAmount {
    final pend = _grandTotal - _paidAmount;
    return pend < 0.0 ? 0.0 : pend;
  }

  void _showInventoryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setModalState) {
            final productsAsync = ref.watch(allProductsStreamProvider);
            return DraggableScrollableSheet(
              initialChildSize: 0.75,
              minChildSize: 0.4,
              maxChildSize: 0.95,
              expand: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'इन्व्हेंटरीमधून वस्तू निवडा (Select Product)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'वस्तू / ब्रँड शोधा...',
                          prefixIcon: const Icon(Icons.search),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) => setModalState(() => searchQuery = v.toLowerCase()),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: productsAsync.when(
                          data: (products) {
                            final filtered = products.where((p) {
                              if (searchQuery.isEmpty) return true;
                              return p.product.name.toLowerCase().contains(searchQuery) ||
                                  (p.product.brand != null && p.product.brand!.toLowerCase().contains(searchQuery));
                            }).toList();

                            if (filtered.isEmpty) {
                              return const Center(child: Text('कोणतीही वस्तू सापडली नाही'));
                            }

                            return ListView.separated(
                              controller: scrollController,
                              itemCount: filtered.length,
                              separatorBuilder: (_, __) => const Divider(height: 1),
                              itemBuilder: (context, idx) {
                                final prod = filtered[idx].product;
                                final isLow = prod.currentStock <= prod.minimumStockLevel;
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  title: Text(prod.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                    '${prod.brand ?? ""} • स्टॉक: ${prod.currentStock.toStringAsFixed(0)} ${prod.unit}',
                                    style: TextStyle(color: isLow ? Colors.red : Colors.grey.shade700),
                                  ),
                                  trailing: Text(
                                    Formatters.currency(prod.sellingPrice),
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _items.add(
                                        _BillItemEntry(
                                          productId: prod.id,
                                          description: prod.brand != null ? '${prod.name} (${prod.brand})' : prod.name,
                                          quantity: 1,
                                          rate: prod.sellingPrice,
                                        ),
                                      );
                                    });
                                    Navigator.pop(ctx);
                                  },
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
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _saveInvoice() async {
    if (!_formKey.currentState!.validate()) return;
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('किमान एक आयटम जोडा (Add at least 1 item)'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final invoiceDao = ref.read(invoiceDaoProvider);
      final customerDao = ref.read(customerDaoProvider);

      Customer? customer;
      if (_selectedCustomerId != null) {
        customer = await customerDao.getCustomerById(_selectedCustomerId!);
      }

      final invNumber = await invoiceDao.generateNextInvoiceNumber();

      final companionItems = _items.map((it) {
        return InvoiceItemsCompanion.insert(
          invoiceId: 0, // Assigned inside DAO transaction
          productId: drift.Value(it.productId),
          description: it.descController.text.trim(),
          quantity: drift.Value(it.quantity),
          unitPrice: drift.Value(it.rate),
          amount: drift.Value(it.amount),
        );
      }).toList();

      final invId = await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNumber,
          category: _category,
          customerId: drift.Value(_selectedCustomerId),
          customerName: drift.Value(customer?.name ?? _walkInNameController.text.trim()),
          customerMobile: drift.Value(customer?.mobile ?? _walkInMobileController.text.trim()),
          repairJobId: drift.Value(widget.repairJobId),
          subtotal: drift.Value(_subtotal),
          discount: drift.Value(_discount),
          taxAmount: drift.Value(_taxAmount),
          grandTotal: drift.Value(_grandTotal),
          paidAmount: drift.Value(_paidAmount),
          pendingAmount: drift.Value(_pendingAmount),
          paymentMode: drift.Value(_paymentMode),
          notes: drift.Value(_notesController.text.trim().isEmpty ? null : _notesController.text.trim()),
        ),
        items: companionItems,
        initialPayment: _paidAmount,
        paymentMode: _paymentMode,
      );

      // If linked to repair job, mark job delivered/completed
      if (widget.repairJobId != null) {
        final currentJob = await ref.read(repairJobDaoProvider).getJobById(widget.repairJobId!);
        if (currentJob != null && currentJob.jobStatus != 'delivered') {
          await ref.read(repairJobDaoProvider).updateJobStatus(
                widget.repairJobId!,
                'delivered',
                notes: 'Bill $invNumber generated and handed over to customer',
              );
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('बिल $invNumber यशस्वीरीत्या तयार झाले!'), backgroundColor: AppTheme.successGreen),
        );
        context.pop();
        context.push('/billing/$invId');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('त्रुटी: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final customersAsync = ref.watch(allCustomersStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.createBill),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Category Selector
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'बिल प्रकार (Category) *',
                prefixIcon: Icon(Icons.category),
              ),
              items: const [
                DropdownMenuItem(value: 'repair', child: Text('मोटर रिपेअरिंग बिल (Motor Repair Bill)')),
                DropdownMenuItem(value: 'parts_sales', child: Text('साहित्य / पार्ट्स बिल (Parts & Materials Bill)')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _category = val);
              },
            ),
            const SizedBox(height: 16),

            // Customer selection or Walk-in
            customersAsync.when(
              data: (customers) {
                return DropdownButtonFormField<int?>(
                  value: _selectedCustomerId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'ग्राहक निवडा (Customer)',
                    prefixIcon: const Icon(Icons.person),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.person_add, color: AppTheme.primaryBlue),
                      tooltip: 'नवीन ग्राहक जोडा',
                      onPressed: () => context.push('/customers/add'),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem<int?>(value: null, child: Text('Walk-in Customer (रोख ग्राहक)')),
                    ...customers.map(
                      (c) => DropdownMenuItem<int?>(
                        value: c.id,
                        child: Text('${c.name} (${c.mobile})', overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                  onChanged: (val) => setState(() => _selectedCustomerId = val),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 12),

            if (_selectedCustomerId == null) ...[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _walkInNameController,
                      decoration: const InputDecoration(
                        labelText: 'ग्राहकाचे नाव (Customer Name)',
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _walkInMobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'मोबाईल नंबर (Mobile)',
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // Items Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('बिल आयटम्स (Items & Services)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: _showInventoryPicker,
                      icon: const Icon(Icons.inventory_2, size: 18),
                      label: const Text('इन्व्हेंटरी'),
                      style: OutlinedButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _items.add(_BillItemEntry(description: '', quantity: 1, rate: 0));
                        });
                      },
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('आयटम'),
                      style: ElevatedButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Items List
            ..._items.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: item.descController,
                              decoration: InputDecoration(
                                labelText: 'तपशील (Item Description) #${idx + 1}',
                                hintText: 'उदा. 1 HP रिवाइंडिंग / बेअरिंग 6204',
                              ),
                              validator: (v) => v == null || v.trim().isEmpty ? 'तपशील आवश्यक आहे' : null,
                            ),
                          ),
                          if (_items.length > 1)
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => setState(() => _items.removeAt(idx)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: item.qtyController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'प्रमाण (Qty)'),
                              onChanged: (_) => setState(() {}),
                              validator: (v) => v == null || double.tryParse(v) == null ? 'संख्या लिहा' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              controller: item.rateController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'दर (Rate ₹)'),
                              onChanged: (_) => setState(() {}),
                              validator: (v) => v == null || double.tryParse(v) == null ? 'दर लिहा' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('एकूण:', style: TextStyle(fontSize: 11, color: Colors.grey)),
                                Text(
                                  Formatters.currency(item.amount),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 12),

            // Financial Summary Card
            Card(
              color: Colors.blue.shade50.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('सबटोटल (Subtotal):', style: TextStyle(fontSize: 15)),
                        Text(Formatters.currency(_subtotal), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('सवलत (Discount ₹):', style: TextStyle(fontSize: 15)),
                        const Spacer(),
                        SizedBox(
                          width: 110,
                          child: TextFormField(
                            controller: _discountController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.end,
                            decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.all(8)),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _applyGst,
                              onChanged: (v) => setState(() => _applyGst = v ?? false),
                            ),
                            Text('GST (${_gstRate.toStringAsFixed(0)}%) लागू करा'),
                          ],
                        ),
                        if (_applyGst)
                          Text(Formatters.currency(_taxAmount), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('अंतिम एकूण (Grand Total):', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                        Text(Formatters.currency(_grandTotal), style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Payment Collection Section
            const Text('पेमेंट जमा (Payment Collection)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _paidAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'आता जमा रक्कम (Paid ₹) *',
                      prefixIcon: Icon(Icons.payment),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _paidAmountController.text = _grandTotal.toStringAsFixed(0);
                    });
                  },
                  child: const Text('पूर्ण भरा'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _paymentMode,
              decoration: const InputDecoration(
                labelText: 'पेमेंट प्रकार (Payment Mode)',
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
              items: const [
                DropdownMenuItem(value: 'cash', child: Text('रोख (Cash)')),
                DropdownMenuItem(value: 'upi', child: Text('UPI (GPay / PhonePe / Paytm)')),
                DropdownMenuItem(value: 'bank_transfer', child: Text('बँक खात्यात (Bank Transfer / NEFT)')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _paymentMode = val);
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'काही विशेष नोंद / टीप (Notes)',
                prefixIcon: Icon(Icons.note_alt_outlined),
                hintText: 'उदा. चेकमधून किंवा उधारी दिनांक',
              ),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _pendingAmount > 0 ? Colors.red.shade50 : Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _pendingAmount > 0 ? Colors.red.shade200 : Colors.green.shade200,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _pendingAmount > 0 ? 'उर्वरित बाकी रक्कम (Pending):' : 'पूर्ण रक्कम जमा झाली (Fully Paid)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: _pendingAmount > 0 ? AppTheme.errorRed : AppTheme.successGreen,
                    ),
                  ),
                  Text(
                    Formatters.currency(_pendingAmount),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: _pendingAmount > 0 ? AppTheme.errorRed : AppTheme.successGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _saveInvoice,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('बिल तयार करा (Generate Bill)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
