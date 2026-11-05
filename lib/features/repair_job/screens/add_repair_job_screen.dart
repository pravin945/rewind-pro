import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';

class AddRepairJobScreen extends ConsumerStatefulWidget {
  final int? preselectedCustomerId;
  final int? jobId;

  const AddRepairJobScreen({
    super.key,
    this.preselectedCustomerId,
    this.jobId,
  });

  @override
  ConsumerState<AddRepairJobScreen> createState() => _AddRepairJobScreenState();
}

class _AddRepairJobScreenState extends ConsumerState<AddRepairJobScreen> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedCustomerId;
  String _motorType = 'सबमर्सिबल (Submersible)';
  final _brandController = TextEditingController(text: 'किर्लोस्कर (Kirloskar)');
  final _hpController = TextEditingController(text: '1 HP');
  String _phase = 'सिंगल फेज (Single Phase)';
  final _serialController = TextEditingController();
  final _problemController = TextEditingController();
  final _workController = TextEditingController();
  final _labourController = TextEditingController(text: '500');
  final _materialController = TextEditingController(text: '0');
  final _discountController = TextEditingController(text: '0');
  final _advanceController = TextEditingController(text: '0');
  final _notesController = TextEditingController();
  final _warrantyController = TextEditingController(text: '१ महिना हमी');

  DateTime? _expectedDelivery;
  bool _isLoading = false;
  bool _isEdit = false;
  String? _existingJobNumber;

  final List<String> _motorTypes = [
    'सबमर्सिबल (Submersible)',
    'मोनोब्लॉक (Monoblock)',
    'ओपनवेल (Openwell)',
    'इंडक्शन मोटर (Induction Motor)',
    'डोमेस्टिक मोटर (Domestic Pump)',
    'इतर मोटर (Other)',
  ];

  @override
  void initState() {
    super.initState();
    _isEdit = widget.jobId != null;
    _selectedCustomerId = widget.preselectedCustomerId;
    _expectedDelivery = DateTime.now().add(const Duration(days: 2));

    if (_isEdit) {
      _loadExistingJob();
    }
  }

  Future<void> _loadExistingJob() async {
    final details = await ref.read(repairJobDaoProvider).getJobDetails(widget.jobId!);
    if (details != null && mounted) {
      final job = details.job;
      _existingJobNumber = job.jobNumber;
      _selectedCustomerId = job.customerId;
      _motorType = job.motorType;
      _brandController.text = job.motorBrand;
      _hpController.text = job.motorHp;
      _phase = job.motorPhase;
      _serialController.text = job.motorSerialNumber ?? '';
      _problemController.text = job.problemDescription;
      _workController.text = job.workDescription ?? '';
      _labourController.text = job.labourCharges.toStringAsFixed(0);
      _materialController.text = job.materialCharges.toStringAsFixed(0);
      _discountController.text = job.discount.toStringAsFixed(0);
      _advanceController.text = job.advancePayment.toStringAsFixed(0);
      _notesController.text = job.notes ?? '';
      _warrantyController.text = job.warrantyInfo ?? '१ महिना हमी';
      _expectedDelivery = job.expectedDeliveryDate;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _brandController.dispose();
    _hpController.dispose();
    _serialController.dispose();
    _problemController.dispose();
    _workController.dispose();
    _labourController.dispose();
    _materialController.dispose();
    _discountController.dispose();
    _advanceController.dispose();
    _notesController.dispose();
    _warrantyController.dispose();
    super.dispose();
  }

  double get _totalAmount {
    final labour = double.tryParse(_labourController.text.trim()) ?? 0.0;
    final material = double.tryParse(_materialController.text.trim()) ?? 0.0;
    final discount = double.tryParse(_discountController.text.trim()) ?? 0.0;
    final total = labour + material - discount;
    return total < 0.0 ? 0.0 : total;
  }

  double get _remainingAmount {
    final advance = double.tryParse(_advanceController.text.trim()) ?? 0.0;
    final remaining = _totalAmount - advance;
    return remaining < 0.0 ? 0.0 : remaining;
  }

  Future<void> _submitJob() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCustomerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया ग्राहक निवडा (Select customer)'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final repairDao = ref.read(repairJobDaoProvider);
      final customerDao = ref.read(customerDaoProvider);

      final customer = await customerDao.getCustomerById(_selectedCustomerId!);
      final labour = double.tryParse(_labourController.text.trim()) ?? 0.0;
      final material = double.tryParse(_materialController.text.trim()) ?? 0.0;
      final discount = double.tryParse(_discountController.text.trim()) ?? 0.0;
      final advance = double.tryParse(_advanceController.text.trim()) ?? 0.0;
      final finalAmt = _totalAmount;
      final remaining = _remainingAmount;

      if (_isEdit) {
        await repairDao.updateJob(
          RepairJobsCompanion(
            id: drift.Value(widget.jobId!),
            customerId: drift.Value(_selectedCustomerId!),
            customerNameSnapshot: drift.Value(customer?.name),
            customerMobileSnapshot: drift.Value(customer?.mobile),
            motorType: drift.Value(_motorType),
            motorBrand: drift.Value(_brandController.text.trim()),
            motorHp: drift.Value(_hpController.text.trim()),
            motorPhase: drift.Value(_phase),
            motorSerialNumber: drift.Value(_serialController.text.trim().isEmpty ? null : _serialController.text.trim()),
            problemDescription: drift.Value(_problemController.text.trim()),
            workDescription: drift.Value(_workController.text.trim().isEmpty ? null : _workController.text.trim()),
            labourCharges: drift.Value(labour),
            materialCharges: drift.Value(material),
            discount: drift.Value(discount),
            finalAmount: drift.Value(finalAmt),
            advancePayment: drift.Value(advance),
            remainingAmount: drift.Value(remaining),
            expectedDeliveryDate: drift.Value(_expectedDelivery),
            warrantyInfo: drift.Value(_warrantyController.text.trim().isEmpty ? null : _warrantyController.text.trim()),
            notes: drift.Value(_notesController.text.trim().isEmpty ? null : _notesController.text.trim()),
          ),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('जॉब कार्ड $_existingJobNumber दुरुस्त केले!'), backgroundColor: Colors.green),
          );
          context.pop();
        }
      } else {
        final jobNumber = await repairDao.generateNextJobNumber();
        final jobId = await repairDao.insertJob(
          job: RepairJobsCompanion.insert(
            jobNumber: jobNumber,
            customerId: _selectedCustomerId!,
            customerNameSnapshot: drift.Value(customer?.name),
            customerMobileSnapshot: drift.Value(customer?.mobile),
            motorType: _motorType,
            motorBrand: _brandController.text.trim(),
            motorHp: _hpController.text.trim(),
            motorPhase: _phase,
            motorSerialNumber: drift.Value(_serialController.text.trim().isEmpty ? null : _serialController.text.trim()),
            problemDescription: _problemController.text.trim(),
            workDescription: drift.Value(_workController.text.trim().isEmpty ? null : _workController.text.trim()),
            labourCharges: drift.Value(labour),
            materialCharges: drift.Value(material),
            discount: drift.Value(discount),
            finalAmount: drift.Value(finalAmt),
            advancePayment: drift.Value(advance),
            remainingAmount: drift.Value(remaining),
            expectedDeliveryDate: drift.Value(_expectedDelivery),
            warrantyInfo: drift.Value(_warrantyController.text.trim().isEmpty ? null : _warrantyController.text.trim()),
            notes: drift.Value(_notesController.text.trim().isEmpty ? null : _notesController.text.trim()),
          ),
          advancePayment: advance,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('जॉब कार्ड $jobNumber तयार झाले!'), backgroundColor: Colors.green),
          );
          context.pop();
          context.push('/jobs/$jobId');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
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
        title: Text(_isEdit ? 'काम दुरुस्त करा (Edit Job Card)' : strings.newRepairJob),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Customer Selector
            customersAsync.when(
              data: (customers) {
                return DropdownButtonFormField<int>(
                  value: _selectedCustomerId,
                  decoration: InputDecoration(
                    labelText: '${strings.customerName} *',
                    prefixIcon: const Icon(Icons.person),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.person_add),
                      onPressed: () => context.push('/customers/add'),
                    ),
                  ),
                  items: customers.map((c) {
                    return DropdownMenuItem(
                      value: c.id,
                      child: Text('${c.name} (${c.mobile})'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedCustomerId = val),
                  validator: (v) => v == null ? 'कृपया ग्राहक निवडा' : null,
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Error loading customers: $e'),
            ),
            const SizedBox(height: 16),

            // Motor Details Section
            const Text('मोटर माहिती (Motor Specifications)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _motorType,
              decoration: const InputDecoration(labelText: 'मोटर प्रकार (Motor Type) *', prefixIcon: Icon(Icons.category)),
              items: _motorTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _motorType = val);
              },
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: 'ब्रँड (Brand) *'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'आवश्यक आहे' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _hpController,
                    decoration: const InputDecoration(labelText: 'एच.पी. (HP) *', hintText: 'उदा. 1 HP / 5 HP'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'आवश्यक आहे' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _phase,
              decoration: const InputDecoration(labelText: 'फेज (Phase) *', prefixIcon: Icon(Icons.bolt)),
              items: const [
                DropdownMenuItem(value: 'सिंगल फेज (Single Phase)', child: Text('सिंगल फेज (Single Phase)')),
                DropdownMenuItem(value: 'थ्री फेज (Three Phase)', child: Text('थ्री फेज (Three Phase)')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _phase = val);
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _serialController,
              decoration: const InputDecoration(labelText: 'सिरीयल नंबर (Optional)', prefixIcon: Icon(Icons.tag)),
            ),
            const SizedBox(height: 20),

            // Problem & Work Description
            const Text('समस्या व काम (Problem & Work)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            TextFormField(
              controller: _problemController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'समस्या / फॉल्ट वर्णन *',
                hintText: 'उदा. मोटर जळाली आहे, बेअरिंग आवाज करते',
                prefixIcon: Icon(Icons.warning_amber),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'समस्या लिहा' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _workController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'करावयाचे काम (Work Description)',
                hintText: 'उदा. पूर्ण रिवाइंडिंग + दोन्ही बेअरिंग बदलणे',
                prefixIcon: Icon(Icons.build),
              ),
            ),
            const SizedBox(height: 12),

            // Expected Delivery Date
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today, color: AppTheme.primaryBlue),
              title: const Text('अपेक्षित देण्याची तारीख (Delivery Date)'),
              subtitle: Text(
                _expectedDelivery != null ? '${_expectedDelivery!.day}/${_expectedDelivery!.month}/${_expectedDelivery!.year}' : 'तारीख निवडा',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.edit_calendar),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _expectedDelivery ?? DateTime.now().add(const Duration(days: 2)),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                );
                if (picked != null) {
                  setState(() => _expectedDelivery = picked);
                }
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _warrantyController,
              decoration: const InputDecoration(
                labelText: 'वॉरंटी माहिती (Warranty Info)',
                hintText: 'उदा. १ महिना / ६ महिने वॉरंटी',
                prefixIcon: Icon(Icons.verified_user),
              ),
            ),
            const SizedBox(height: 20),

            // Estimated Cost & Advance
            const Text('खर्च व अॅडव्हान्स (Charges & Payment)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _labourController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'मजुरी आकार (₹)'),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _materialController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'मटेरियल आकार (₹)'),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _discountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'सवलत/Discount (₹)'),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _advanceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'अॅडव्हान्स जमा (₹)'),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'इतर टीप (Notes)',
                prefixIcon: Icon(Icons.note),
              ),
            ),
            const SizedBox(height: 16),

            // Calculated Totals Preview
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('अंतिम एकूण रक्कम:', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      Text('₹ ${_totalAmount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('बाकी रक्कम:', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      Text('₹ ${_remainingAmount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.errorRed)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _submitJob,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(_isEdit ? 'अपडेट करा (Update Job Card)' : 'जॉब कार्ड तयार करा (Create Job Card)', style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
