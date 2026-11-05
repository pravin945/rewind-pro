import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';

class AddEditCustomerScreen extends ConsumerStatefulWidget {
  final int? customerId;

  const AddEditCustomerScreen({super.key, this.customerId});

  @override
  ConsumerState<AddEditCustomerScreen> createState() => _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends ConsumerState<AddEditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _altMobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _villageCityController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isLoading = false;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.customerId != null;
    if (_isEdit) {
      _loadExistingCustomer();
    }
  }

  Future<void> _loadExistingCustomer() async {
    final customer = await ref.read(customerDaoProvider).getCustomerById(widget.customerId!);
    if (customer != null && mounted) {
      _nameController.text = customer.name;
      _mobileController.text = customer.mobile;
      _altMobileController.text = customer.alternateMobile ?? '';
      _addressController.text = customer.address ?? '';
      _villageCityController.text = customer.villageCity ?? '';
      _notesController.text = customer.notes ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _altMobileController.dispose();
    _addressController.dispose();
    _villageCityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    final mobile = _mobileController.text.trim();
    final customerDao = ref.read(customerDaoProvider);

    setState(() => _isLoading = true);

    try {
      // Duplicate mobile check warning
      final mobileExists = await customerDao.checkMobileExists(
        mobile,
        excludeCustomerId: widget.customerId,
      );

      if (mobileExists && mounted) {
        final proceed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                SizedBox(width: 8),
                Text('मोबाईल नंबर आधीच नोंदवला आहे'),
              ],
            ),
            content: Text(
              'हा मोबाईल नंबर ($mobile) इतर ग्राहकासाठी आधीच वापरलेला आहे. तरीही हा ग्राहक जतन करायचा आहे का?\n\n(This mobile number already exists for another customer. Proceed anyway?)',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('रद्द करा (Cancel)'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('पुढे जा (Proceed)'),
              ),
            ],
          ),
        );

        if (proceed != true) {
          setState(() => _isLoading = false);
          return;
        }
      }

      if (_isEdit) {
        await customerDao.updateCustomer(
          CustomersCompanion(
            id: drift.Value(widget.customerId!),
            name: drift.Value(_nameController.text.trim()),
            mobile: drift.Value(mobile),
            alternateMobile: drift.Value(_altMobileController.text.trim().isEmpty ? null : _altMobileController.text.trim()),
            address: drift.Value(_addressController.text.trim().isEmpty ? null : _addressController.text.trim()),
            villageCity: drift.Value(_villageCityController.text.trim().isEmpty ? null : _villageCityController.text.trim()),
            notes: drift.Value(_notesController.text.trim().isEmpty ? null : _notesController.text.trim()),
          ),
        );
      } else {
        await customerDao.insertCustomer(
          CustomersCompanion.insert(
            name: _nameController.text.trim(),
            mobile: mobile,
            alternateMobile: drift.Value(_altMobileController.text.trim().isEmpty ? null : _altMobileController.text.trim()),
            address: drift.Value(_addressController.text.trim().isEmpty ? null : _addressController.text.trim()),
            villageCity: drift.Value(_villageCityController.text.trim().isEmpty ? null : _villageCityController.text.trim()),
            notes: drift.Value(_notesController.text.trim().isEmpty ? null : _notesController.text.trim()),
          ),
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEdit ? 'ग्राहक माहिती अपडेट केली!' : 'नवीन ग्राहक जतन केला!'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'ग्राहक दुरुस्त करा (Edit Customer)' : strings.addCustomer),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: '${strings.customerName} *',
                prefixIcon: const Icon(Icons.person),
                hintText: 'उदा. रमेश पाटील',
              ),
              textCapitalization: TextCapitalization.words,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'कृपया ग्राहकाचे नाव लिहा (Enter name)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: '${strings.mobileNumber} *',
                prefixIcon: const Icon(Icons.phone),
                hintText: 'उदा. 9623314436',
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'कृपया मोबाईल नंबर लिहा (Enter mobile)';
                }
                if (val.trim().length < 10) {
                  return 'कमीत कमी 10 अंकी मोबाईल नंबर असावा';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _altMobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: strings.altMobileNumber,
                prefixIcon: const Icon(Icons.phone_outlined),
                hintText: 'पर्यायी मोबाईल नंबर (ऐच्छिक)',
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _villageCityController,
              decoration: InputDecoration(
                labelText: strings.villageCity,
                prefixIcon: const Icon(Icons.location_city),
                hintText: 'उदा. बारामती / वाघोली',
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _addressController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: strings.address,
                prefixIcon: const Icon(Icons.home),
                hintText: 'घराचा / शेताचा / दुकानाचा पत्ता',
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _notesController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: strings.notes,
                prefixIcon: const Icon(Icons.note),
                hintText: 'इतर विशेष टीप (Optional)',
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _saveCustomer,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(
                      _isEdit ? 'अपडेट करा (Update)' : strings.save,
                      style: const TextStyle(fontSize: 18),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

