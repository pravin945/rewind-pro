import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileController = TextEditingController();
  final _altMobileController = TextEditingController();
  final _gstinController = TextEditingController();
  final _invoicePrefixController = TextEditingController();
  final _jobPrefixController = TextEditingController();
  final _taxRateController = TextEditingController();
  final _pdfFooterController = TextEditingController();
  final _warrantyTermsController = TextEditingController();
  final _paymentInstructionsController = TextEditingController();

  bool _isGstEnabled = false;
  bool _isLoading = false;
  AppLanguage _selectedLanguage = AppLanguage.marathiEnglish;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await ref.read(settingsDaoProvider).getSettings();
    if (mounted) {
      _shopNameController.text = settings.shopName;
      _ownerNameController.text = settings.ownerName;
      _addressController.text = settings.shopAddress;
      _mobileController.text = settings.mobileNumber;
      _altMobileController.text = settings.alternateMobile ?? '';
      _gstinController.text = settings.gstin ?? '';
      _invoicePrefixController.text = settings.invoicePrefix;
      _jobPrefixController.text = settings.jobPrefix;
      _taxRateController.text = settings.defaultTaxRate.toString();
      _pdfFooterController.text = settings.pdfFooter ?? '';
      _warrantyTermsController.text = settings.warrantyTerms ?? '';
      _paymentInstructionsController.text = settings.paymentInstructions ?? '';
      _isGstEnabled = settings.isGstEnabled;
      _selectedLanguage = AppLanguage.fromCode(settings.defaultLanguage);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _ownerNameController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _altMobileController.dispose();
    _gstinController.dispose();
    _invoicePrefixController.dispose();
    _jobPrefixController.dispose();
    _taxRateController.dispose();
    _pdfFooterController.dispose();
    _warrantyTermsController.dispose();
    _paymentInstructionsController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final taxRate = double.tryParse(_taxRateController.text.trim()) ?? 0.0;

      await ref.read(settingsDaoProvider).updateSettings(
            BusinessSettingsCompanion(
              shopName: drift.Value(_shopNameController.text.trim()),
              ownerName: drift.Value(_ownerNameController.text.trim()),
              shopAddress: drift.Value(_addressController.text.trim()),
              mobileNumber: drift.Value(_mobileController.text.trim()),
              alternateMobile: drift.Value(_altMobileController.text.trim().isEmpty ? null : _altMobileController.text.trim()),
              gstin: drift.Value(_gstinController.text.trim().isEmpty ? null : _gstinController.text.trim()),
              invoicePrefix: drift.Value(_invoicePrefixController.text.trim()),
              jobPrefix: drift.Value(_jobPrefixController.text.trim()),
              defaultTaxRate: drift.Value(taxRate),
              isGstEnabled: drift.Value(_isGstEnabled),
              defaultLanguage: drift.Value(_selectedLanguage.code),
              pdfFooter: drift.Value(_pdfFooterController.text.trim().isEmpty ? null : _pdfFooterController.text.trim()),
              warrantyTerms: drift.Value(_warrantyTermsController.text.trim().isEmpty ? null : _warrantyTermsController.text.trim()),
              paymentInstructions: drift.Value(_paymentInstructionsController.text.trim().isEmpty ? null : _paymentInstructionsController.text.trim()),
            ),
          );

      // Update in-memory language provider
      ref.read(appLanguageProvider.notifier).setLanguage(_selectedLanguage);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('सेटिंग्ज यशस्वीरीत्या जतन केल्या! (Settings saved successfully)'),
            backgroundColor: Colors.green,
          ),
        );
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
        title: Text(strings.settings),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Shop Details Section
            const Text(
              'दुकान माहिती (Shop Information)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _shopNameController,
              decoration: InputDecoration(
                labelText: '${strings.shopName} *',
                prefixIcon: const Icon(Icons.store),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'कृपया दुकानाचे नाव लिहा' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _ownerNameController,
              decoration: InputDecoration(
                labelText: '${strings.ownerName} *',
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'कृपया मालकाचे नाव लिहा' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: '${strings.mobileNumber} *',
                prefixIcon: const Icon(Icons.phone),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'मोबाईल नंबर आवश्यक आहे' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _altMobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: strings.altMobileNumber,
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _addressController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: '${strings.address} *',
                prefixIcon: const Icon(Icons.location_on),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'पत्ता आवश्यक आहे' : null,
            ),
            const SizedBox(height: 20),

            // Billing & GST Section
            const Text(
              'बिलिंग व टॅक्स पर्याय (Billing & GST)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SwitchListTile(
              title: const Text('GST बिलिंग सुरू करा (Enable GST Billing)'),
              subtitle: const Text('जीएसटी नोंदणी नसल्यास हे बंद ठेवा'),
              value: _isGstEnabled,
              onChanged: (val) => setState(() => _isGstEnabled = val),
            ),

            if (_isGstEnabled) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _gstinController,
                decoration: const InputDecoration(
                  labelText: 'GSTIN Number',
                  prefixIcon: Icon(Icons.badge),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _taxRateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Default Tax Rate (%)',
                  prefixIcon: Icon(Icons.percent),
                  hintText: '18.0',
                ),
              ),
            ],
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _invoicePrefixController,
                    decoration: const InputDecoration(
                      labelText: 'बिल नंबर प्रिफिक्स (Prefix)',
                      hintText: 'INV-',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _jobPrefixController,
                    decoration: const InputDecoration(
                      labelText: 'जॉब नंबर प्रिफिक्स (Prefix)',
                      hintText: 'JOB-',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Language Selection
            const Text(
              'अॅपची भाषा (App Language)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<AppLanguage>(
              value: _selectedLanguage,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.language),
              ),
              items: AppLanguage.values.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang.displayName),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedLanguage = val);
              },
            ),
            const SizedBox(height: 20),

            // Terms & Footer
            const Text(
              'बिल नियम व अटी (Invoice Terms & Footer)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _warrantyTermsController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'वॉरंटी नियम (Warranty Terms)',
                prefixIcon: Icon(Icons.verified_user),
              ),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _paymentInstructionsController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'पेमेंट सूचना (Payment Instructions)',
                prefixIcon: Icon(Icons.account_balance),
              ),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _pdfFooterController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'बिल तळटीप (PDF Footer Note)',
                prefixIcon: Icon(Icons.notes),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _saveSettings,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(strings.save, style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

