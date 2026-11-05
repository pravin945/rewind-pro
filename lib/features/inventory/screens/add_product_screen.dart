import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  int? _categoryId;
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _hpController = TextEditingController();
  final _purchasePriceController = TextEditingController(text: '0');
  final _sellingPriceController = TextEditingController(text: '0');
  final _initialStockController = TextEditingController(text: '1');
  final _minStockController = TextEditingController(text: '2');
  String _unit = 'pcs';
  final _descController = TextEditingController();

  bool _isLoading = false;

  final List<String> _units = ['pcs (नग)', 'kg (किलो)', 'mtr (मीटर)', 'set (संच)', 'roll (रोल)'];

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _hpController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _initialStockController.dispose();
    _minStockController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final purchase = double.tryParse(_purchasePriceController.text.trim()) ?? 0.0;
      final selling = double.tryParse(_sellingPriceController.text.trim()) ?? 0.0;
      final stock = double.tryParse(_initialStockController.text.trim()) ?? 0.0;
      final minStock = double.tryParse(_minStockController.text.trim()) ?? 0.0;

      await ref.read(productDaoProvider).insertProduct(
            ProductsCompanion.insert(
              name: _nameController.text.trim(),
              categoryId: drift.Value(_categoryId),
              brand: drift.Value(_brandController.text.trim().isEmpty ? null : _brandController.text.trim()),
              modelNumber: drift.Value(_modelController.text.trim().isEmpty ? null : _modelController.text.trim()),
              hp: drift.Value(_hpController.text.trim().isEmpty ? null : _hpController.text.trim()),
              description: drift.Value(_descController.text.trim().isEmpty ? null : _descController.text.trim()),
              purchasePrice: drift.Value(purchase),
              sellingPrice: drift.Value(selling),
              currentStock: drift.Value(stock),
              minimumStockLevel: drift.Value(minStock),
              unit: drift.Value(_unit),
            ),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('उत्पादन यशस्वीपणे जतन झाले!'), backgroundColor: Colors.green),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('नवीन उत्पादन जोडा (Add Product)'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'उत्पादनाचे नाव (Product Name) *',
                hintText: 'उदा. Submersible Pump 1HP / Bearing 6204',
                prefixIcon: Icon(Icons.shopping_bag),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'नाव आवश्यक आहे' : null,
            ),
            const SizedBox(height: 12),

            FutureBuilder<List<ProductCategory>>(
              future: ref.read(productDaoProvider).getAllCategories(),
              builder: (context, snapshot) {
                final cats = snapshot.data ?? [];
                return DropdownButtonFormField<int>(
                  value: _categoryId,
                  decoration: const InputDecoration(labelText: 'वर्गवारी (Category)', prefixIcon: Icon(Icons.category)),
                  items: cats.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                  onChanged: (val) => setState(() => _categoryId = val),
                );
              },
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: 'ब्रँड (Brand)'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _hpController,
                    decoration: const InputDecoration(labelText: 'एच.पी. (HP)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _purchasePriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'खरेदी दर (₹) *'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _sellingPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'विक्री दर (₹) *'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _initialStockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'सध्याचा स्टॉक *'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _minStockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'किमान स्टॉक मर्यादा'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _unit,
              decoration: const InputDecoration(labelText: 'युनिट (Unit)'),
              items: _units.map((u) => DropdownMenuItem(value: u.split(' ')[0], child: Text(u))).toList(),
              onChanged: (v) {
                if (v != null) setState(() => _unit = v);
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _descController,
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'इतर वर्णन (Description)'),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _saveProduct,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('उत्पादन जतन करा (Save Product)', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

