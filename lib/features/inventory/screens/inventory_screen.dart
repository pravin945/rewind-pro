import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/daos/product_dao.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

final inventorySearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final inventoryLowStockFilterProvider = StateProvider.autoDispose<bool>((ref) => false);
final inventoryCategoryFilterProvider = StateProvider.autoDispose<int?>((ref) => null);

final inventoryListProvider = StreamProvider.autoDispose<List<ProductWithCategory>>((ref) {
  final query = ref.watch(inventorySearchQueryProvider);
  final lowStock = ref.watch(inventoryLowStockFilterProvider);
  final catId = ref.watch(inventoryCategoryFilterProvider);

  return ref.watch(productDaoProvider).watchProducts(
        query: query,
        lowStockOnly: lowStock,
        categoryId: catId,
      );
});

class InventoryScreen extends ConsumerWidget {
  final bool? initialLowStock;
  const InventoryScreen({super.key, this.initialLowStock});

  void _showAdjustStockDialog(BuildContext context, WidgetRef ref, ProductWithCategory item) {
    final qtyController = TextEditingController();
    String type = 'purchase'; // purchase or adjustment_in or adjustment_out
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('${item.product.name} - स्टॉक बदल'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('सध्याचा स्टॉक: ${item.product.currentStock} ${item.product.unit}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: type,
                decoration: const InputDecoration(labelText: 'कृती (Action)'),
                items: const [
                  DropdownMenuItem(value: 'purchase', child: Text('नवीन खरेदी (Purchase +)')),
                  DropdownMenuItem(value: 'adjustment_in', child: Text('स्टॉक वाढवा (Add Stock +)')),
                  DropdownMenuItem(value: 'adjustment_out', child: Text('स्टॉक कमी करा (Reduce Stock -)')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => type = v);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'प्रमाण (${item.product.unit}) *'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'कारण / टीप (Reason)'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा')),
            ElevatedButton(
              onPressed: () async {
                final qty = double.tryParse(qtyController.text.trim()) ?? 0.0;
                if (qty <= 0) return;

                final delta = type == 'adjustment_out' ? -qty : qty;

                await ref.read(productDaoProvider).adjustStock(
                      productId: item.product.id,
                      quantityDelta: delta,
                      movementType: type,
                      notes: notesController.text.trim(),
                    );

                if (context.mounted) Navigator.pop(ctx);
              },
              child: const Text('जतन करा'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final productsAsync = ref.watch(inventoryListProvider);
    final isLowStock = ref.watch(inventoryLowStockFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.inventory),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'नवीन उत्पादन जोडा',
            onPressed: () => context.push('/more/inventory/add'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'नाव किंवा मॉडेल शोधा...',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                    ),
                    onChanged: (v) => ref.read(inventorySearchQueryProvider.notifier).state = v,
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('कमी स्टॉक'),
                  selected: isLowStock,
                  selectedColor: Colors.orange.shade100,
                  checkmarkColor: Colors.orange.shade800,
                  onSelected: (v) => ref.read(inventoryLowStockFilterProvider.notifier).state = v,
                ),
              ],
            ),
          ),
          Expanded(
            child: productsAsync.when(
              data: (products) {
                if (products.isEmpty) {
                  return const Center(child: Text('कोणतेही उत्पादन सापडले नाही'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, idx) {
                    final item = products[idx];
                    final p = item.product;

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: item.isLowStock ? Colors.orange.shade100 : Colors.blue.shade50,
                          child: Icon(
                            Icons.inventory_2,
                            color: item.isLowStock ? Colors.orange.shade800 : AppTheme.primaryBlue,
                          ),
                        ),
                        title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          '${item.category?.name ?? ""} • विक्री दर: ${Formatters.currency(p.sellingPrice)}\nस्टॉक: ${p.currentStock} ${p.unit} (किमान: ${p.minimumStockLevel})',
                          style: TextStyle(color: item.isLowStock ? AppTheme.errorRed : Colors.grey.shade700),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit_note, color: AppTheme.primaryBlue, size: 28),
                          tooltip: 'स्टॉक बदला',
                          onPressed: () => _showAdjustStockDialog(context, ref, item),
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
        onPressed: () => context.push('/more/inventory/add'),
        tooltip: 'नवीन उत्पादन जोडा',
        child: const Icon(Icons.add),
      ),
    );
  }
}

