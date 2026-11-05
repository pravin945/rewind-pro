import 'package:drift/drift.dart';
import '../app_database.dart';

class ProductWithCategory {
  final Product product;
  final ProductCategory? category;

  ProductWithCategory({
    required this.product,
    this.category,
  });

  bool get isLowStock => product.currentStock <= product.minimumStockLevel;
  double get estimatedProfitPerUnit => product.sellingPrice - product.purchasePrice;
}

class ProductDao {
  final AppDatabase db;

  ProductDao(this.db);

  Stream<List<ProductWithCategory>> watchProducts({
    int? categoryId,
    String? query,
    bool lowStockOnly = false,
  }) {
    final queryJoin = db.select(db.products).join([
      leftOuterJoin(
        db.productCategories,
        db.productCategories.id.equalsExp(db.products.categoryId),
      ),
    ])..where(db.products.isDeleted.equals(false));

    if (categoryId != null) {
      queryJoin.where(db.products.categoryId.equals(categoryId));
    }

    if (query != null && query.trim().isNotEmpty) {
      final term = '%${query.trim()}%';
      queryJoin.where(
        db.products.name.like(term) |
            db.products.brand.like(term) |
            db.products.modelNumber.like(term),
      );
    }

    if (lowStockOnly) {
      queryJoin.where(db.products.currentStock.isSmallerOrEqual(db.products.minimumStockLevel));
    }

    queryJoin.orderBy([
      OrderingTerm(expression: db.products.name, mode: OrderingMode.asc),
    ]);

    return queryJoin.watch().map((rows) {
      return rows.map((row) {
        return ProductWithCategory(
          product: row.readTable(db.products),
          category: row.readTableOrNull(db.productCategories),
        );
      }).toList();
    });
  }

  Future<List<ProductWithCategory>> getAllProducts({
    int? categoryId,
    String? query,
    bool lowStockOnly = false,
  }) async {
    final queryJoin = db.select(db.products).join([
      leftOuterJoin(
        db.productCategories,
        db.productCategories.id.equalsExp(db.products.categoryId),
      ),
    ])..where(db.products.isDeleted.equals(false));

    if (categoryId != null) {
      queryJoin.where(db.products.categoryId.equals(categoryId));
    }

    if (query != null && query.trim().isNotEmpty) {
      final term = '%${query.trim()}%';
      queryJoin.where(
        db.products.name.like(term) |
            db.products.brand.like(term) |
            db.products.modelNumber.like(term),
      );
    }

    if (lowStockOnly) {
      queryJoin.where(db.products.currentStock.isSmallerOrEqual(db.products.minimumStockLevel));
    }

    queryJoin.orderBy([
      OrderingTerm(expression: db.products.name, mode: OrderingMode.asc),
    ]);

    final rows = await queryJoin.get();
    return rows.map((row) {
      return ProductWithCategory(
        product: row.readTable(db.products),
        category: row.readTableOrNull(db.productCategories),
      );
    }).toList();
  }

  Future<Product?> getProductById(int id) {
    return (db.select(db.products)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertProduct(ProductsCompanion product) {
    return db.transaction(() async {
      final id = await db.into(db.products).insert(product);

      // Record initial stock movement if starting stock > 0
      final stock = product.currentStock.present ? product.currentStock.value : 0.0;
      if (stock > 0) {
        await db.into(db.stockMovements).insert(
              StockMovementsCompanion.insert(
                productId: id,
                movementType: 'adjustment_in',
                quantity: stock,
                unitPrice: product.purchasePrice,
                referenceType: const Value('initial_stock'),
                notes: const Value('Initial inventory stock entry'),
              ),
            );
      }

      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'CREATE',
              targetEntity: 'Product',
              entityId: Value(id),
              details: Value('Created product ${product.name.value}'),
            ),
          );

      return id;
    });
  }

  Future<bool> updateProduct(ProductsCompanion product) {
    return db.transaction(() async {
      final updated = await (db.update(db.products)..where((tbl) => tbl.id.equals(product.id.value))).write(
        product.copyWith(updatedAt: Value(DateTime.now())),
      );

      if (updated > 0) {
        await db.into(db.auditLogs).insert(
              AuditLogsCompanion.insert(
                action: 'UPDATE',
                targetEntity: 'Product',
                entityId: product.id,
                details: Value('Updated product ${product.name.value}'),
              ),
            );
      }

      return updated > 0;
    });
  }

  Future<void> adjustStock({
    required int productId,
    required double quantityDelta,
    required String movementType, // purchase, sale, repair_use, adjustment_in, adjustment_out
    double? unitPrice,
    String? referenceType,
    int? referenceId,
    String? notes,
    bool allowNegative = false,
  }) {
    return db.transaction(() async {
      final prod = await getProductById(productId);
      if (prod == null) throw Exception('Product not found: $productId');

      final newStock = prod.currentStock + quantityDelta;
      if (newStock < 0.0 && !allowNegative) {
        throw Exception(
          'Negative stock prevented: Current ${prod.currentStock}, change $quantityDelta would result in $newStock.',
        );
      }

      await (db.update(db.products)..where((tbl) => tbl.id.equals(productId))).write(
        ProductsCompanion(
          currentStock: Value(newStock),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await db.into(db.stockMovements).insert(
            StockMovementsCompanion.insert(
              productId: productId,
              movementType: movementType,
              quantity: quantityDelta.abs(),
              unitPrice: Value(unitPrice ?? prod.purchasePrice),
              referenceType: Value(referenceType),
              referenceId: Value(referenceId),
              notes: Value(notes),
            ),
          );

      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'STOCK_ADJUSTMENT',
              targetEntity: 'Product',
              entityId: Value(productId),
              details: Value('$movementType: $quantityDelta units (New stock: $newStock)'),
            ),
          );
    });
  }

  Future<int> softDeleteProduct(int id) {
    return db.transaction(() async {
      final result = await (db.update(db.products)..where((tbl) => tbl.id.equals(id))).write(
        ProductsCompanion(
          isDeleted: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'DELETE',
              targetEntity: 'Product',
              entityId: Value(id),
              details: const Value('Soft deleted product'),
            ),
          );

      return result;
    });
  }

  // Categories
  Stream<List<ProductCategory>> watchCategories() {
    return (db.select(db.productCategories)
          ..orderBy([(t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)]))
        .watch();
  }

  Future<List<ProductCategory>> getAllCategories() {
    return (db.select(db.productCategories)
          ..orderBy([(t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)]))
        .get();
  }

  Future<int> insertCategory(ProductCategoriesCompanion category) {
    return db.into(db.productCategories).insert(category);
  }

  // Stock movements
  Future<List<StockMovement>> getStockMovements(int productId) {
    return (db.select(db.stockMovements)
          ..where((tbl) => tbl.productId.equals(productId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]))
        .get();
  }
}

