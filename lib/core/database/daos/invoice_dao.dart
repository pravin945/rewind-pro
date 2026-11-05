import 'package:drift/drift.dart';
import '../app_database.dart';

class InvoiceWithDetails {
  final Invoice invoice;
  final Customer? customer;
  final List<InvoiceItem> items;
  final List<Payment> payments;

  InvoiceWithDetails({
    required this.invoice,
    this.customer,
    required this.items,
    required this.payments,
  });
}

class InvoiceDao {
  final AppDatabase db;

  InvoiceDao(this.db);

  Stream<List<Invoice>> watchAllInvoices({String? category, int? customerId}) {
    final statement = db.select(db.invoices)
      ..where((tbl) => tbl.isCancelled.equals(false));

    if (category != null && category.isNotEmpty) {
      statement.where((tbl) => tbl.category.equals(category));
    }

    if (customerId != null) {
      statement.where((tbl) => tbl.customerId.equals(customerId));
    }

    statement.orderBy([
      (tbl) => OrderingTerm(expression: tbl.invoiceDate, mode: OrderingMode.desc),
    ]);

    return statement.watch();
  }

  Future<List<Invoice>> getAllInvoices({
    String? category,
    int? customerId,
    bool includeCancelled = false,
  }) async {
    final statement = db.select(db.invoices);

    if (!includeCancelled) {
      statement.where((tbl) => tbl.isCancelled.equals(false));
    }

    if (category != null && category.isNotEmpty) {
      statement.where((tbl) => tbl.category.equals(category));
    }

    if (customerId != null) {
      statement.where((tbl) => tbl.customerId.equals(customerId));
    }

    statement.orderBy([
      (tbl) => OrderingTerm(expression: tbl.invoiceDate, mode: OrderingMode.desc),
    ]);

    return statement.get();
  }

  Future<Invoice?> getInvoiceById(int id) {
    return (db.select(db.invoices)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<Invoice?> getInvoiceByNumber(String invoiceNumber) {
    return (db.select(db.invoices)
          ..where((tbl) => tbl.invoiceNumber.equals(invoiceNumber.trim())))
        .getSingleOrNull();
  }

  Future<Invoice?> getInvoiceForRepairJob(int repairJobId) {
    return (db.select(db.invoices)
          ..where((tbl) => tbl.repairJobId.equals(repairJobId) & tbl.isCancelled.equals(false)))
        .getSingleOrNull();
  }

  Future<InvoiceWithDetails?> getInvoiceDetails(int id) async {
    final inv = await getInvoiceById(id);
    if (inv == null) return null;

    Customer? customer;
    if (inv.customerId != null) {
      customer = await (db.select(db.customers)
            ..where((tbl) => tbl.id.equals(inv.customerId!)))
          .getSingleOrNull();
    }

    final items = await (db.select(db.invoiceItems)
          ..where((tbl) => tbl.invoiceId.equals(inv.id)))
        .get();

    final payments = await (db.select(db.payments)
          ..where((tbl) => tbl.invoiceId.equals(inv.id) & tbl.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.paymentDate, mode: OrderingMode.asc)]))
        .get();

    return InvoiceWithDetails(
      invoice: inv,
      customer: customer,
      items: items,
      payments: payments,
    );
  }

  Future<String> generateNextInvoiceNumber() async {
    final settings = await (db.select(db.businessSettings)..limit(1)).getSingleOrNull();
    final prefix = settings?.invoicePrefix ?? 'INV-';
    final now = DateTime.now();
    final year = now.year.toString();

    // Query all invoices matching prefix + year, even cancelled ones to prevent reuse!
    final allInvoices = await (db.select(db.invoices)
          ..where((tbl) => tbl.invoiceNumber.like('$prefix$year-%')))
        .get();

    int maxSeq = 0;
    final yearPrefix = '$prefix$year-';
    for (final inv in allInvoices) {
      if (inv.invoiceNumber.startsWith(yearPrefix)) {
        final rest = inv.invoiceNumber.substring(yearPrefix.length);
        final num = int.tryParse(rest);
        if (num != null && num > maxSeq) {
          maxSeq = num;
        }
      }
    }

    final nextSeq = (maxSeq + 1).toString().padLeft(4, '0');
    return '$prefix$year-$nextSeq';
  }

  Future<int> createInvoice({
    required InvoicesCompanion invoice,
    required List<InvoiceItemsCompanion> items,
    double initialPayment = 0.0,
    String paymentMode = 'cash',
    String? paymentRef,
  }) {
    return db.transaction(() async {
      // 1. If linked to repair job, ensure duplicate bill does not exist
      if (invoice.repairJobId.present && invoice.repairJobId.value != null) {
        final existing = await getInvoiceForRepairJob(invoice.repairJobId.value!);
        if (existing != null) {
          throw Exception('A bill already exists for this repair job: ${existing.invoiceNumber}');
        }
      }

      // 2. Insert invoice
      final invoiceId = await db.into(db.invoices).insert(invoice);

      // 3. Insert items & reduce stock if product linked
      for (final item in items) {
        await db.into(db.invoiceItems).insert(item.copyWith(invoiceId: Value(invoiceId)));

        if (item.productId.present && item.productId.value != null) {
          final prodId = item.productId.value!;
          final prod = await (db.select(db.products)..where((tbl) => tbl.id.equals(prodId))).getSingleOrNull();
          if (prod != null) {
            final newStock = prod.currentStock - item.quantity.value;
            await (db.update(db.products)..where((tbl) => tbl.id.equals(prodId))).write(
              ProductsCompanion(
                currentStock: Value(newStock),
                updatedAt: Value(DateTime.now()),
              ),
            );

            await db.into(db.stockMovements).insert(
              StockMovementsCompanion.insert(
                productId: prodId,
                movementType: 'sale',
                quantity: item.quantity.value,
                unitPrice: Value(item.unitPrice.value),
                referenceType: const Value('invoice'),
                referenceId: Value(invoiceId),
                notes: Value('Sold in invoice ${invoice.invoiceNumber.value}'),
              ),
            );
          }
        }
      }

      // 4. Record initial payment if provided
      if (initialPayment > 0.0) {
        int? custId = invoice.customerId.present ? invoice.customerId.value : null;
        if (custId == null || custId == 0) {
          final walkIn = await (db.select(db.customers)
                ..where((tbl) => tbl.name.equals('Walk-in Customer') | tbl.mobile.equals('0000000000')))
              .getSingleOrNull();
          if (walkIn != null) {
            custId = walkIn.id;
          } else {
            custId = await db.into(db.customers).insert(
                  CustomersCompanion.insert(
                    name: (invoice.customerName.present && invoice.customerName.value?.isNotEmpty == true)
                        ? invoice.customerName.value!
                        : 'Walk-in Customer',
                    mobile: (invoice.customerMobile.present && invoice.customerMobile.value?.isNotEmpty == true)
                        ? invoice.customerMobile.value!
                        : '0000000000',
                  ),
                );
          }
        }

        await db.into(db.payments).insert(
              PaymentsCompanion.insert(
                customerId: custId,
                invoiceId: Value(invoiceId),
                repairJobId: invoice.repairJobId,
                amountReceived: initialPayment,
                paymentMode: Value(paymentMode),
                transactionReference: Value(paymentRef),
                notes: Value('Payment received at billing for ${invoice.invoiceNumber.value}'),
              ),
            );

        // Update paid & pending on invoice
        final grandTotal = invoice.grandTotal.value;
        final pending = grandTotal - initialPayment;
        await (db.update(db.invoices)..where((tbl) => tbl.id.equals(invoiceId))).write(
          InvoicesCompanion(
            paidAmount: Value(initialPayment),
            pendingAmount: Value(pending < 0.0 ? 0.0 : pending),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      // 5. Audit log
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'CREATE',
              targetEntity: 'Invoice',
              entityId: Value(invoiceId),
              details: Value('Created invoice ${invoice.invoiceNumber.value} for ₹${invoice.grandTotal.value}'),
            ),
          );

      return invoiceId;
    });
  }

  Future<void> cancelInvoice(int id, String reason) {
    return db.transaction(() async {
      final inv = await getInvoiceById(id);
      if (inv == null) return;

      // 1. Mark invoice cancelled
      await (db.update(db.invoices)..where((tbl) => tbl.id.equals(id))).write(
        InvoicesCompanion(
          isCancelled: const Value(true),
          cancellationReason: Value(reason),
          updatedAt: Value(DateTime.now()),
        ),
      );

      // 2. Revert inventory changes for items sold
      final items = await (db.select(db.invoiceItems)..where((tbl) => tbl.invoiceId.equals(id))).get();
      for (final item in items) {
        if (item.productId != null) {
          final prod = await (db.select(db.products)..where((tbl) => tbl.id.equals(item.productId!))).getSingleOrNull();
          if (prod != null) {
            final revertedStock = prod.currentStock + item.quantity;
            await (db.update(db.products)..where((tbl) => tbl.id.equals(item.productId!))).write(
              ProductsCompanion(
                currentStock: Value(revertedStock),
                updatedAt: Value(DateTime.now()),
              ),
            );

            await db.into(db.stockMovements).insert(
              StockMovementsCompanion.insert(
                productId: item.productId!,
                movementType: 'adjustment_in',
                quantity: item.quantity,
                unitPrice: Value(item.unitPrice),
                referenceType: const Value('invoice_cancel'),
                referenceId: Value(id),
                notes: Value('Stock restored due to cancellation of ${inv.invoiceNumber}: $reason'),
              ),
            );
          }
        }
      }

      // 3. Audit log
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'CANCEL',
              targetEntity: 'Invoice',
              entityId: Value(id),
              details: Value('Cancelled invoice ${inv.invoiceNumber}. Reason: $reason'),
            ),
          );
    });
  }
}

