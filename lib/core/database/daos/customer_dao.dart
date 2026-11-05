import 'package:drift/drift.dart';
import '../app_database.dart';

class CustomerFinancialSummary {
  final double totalBilled;
  final double totalPaid;
  final double outstandingBalance;
  final int totalJobsCount;
  final int pendingJobsCount;
  final int pendingBillsCount;

  const CustomerFinancialSummary({
    required this.totalBilled,
    required this.totalPaid,
    required this.outstandingBalance,
    required this.totalJobsCount,
    required this.pendingJobsCount,
    required this.pendingBillsCount,
  });
}

class CustomerDao {
  final AppDatabase db;

  CustomerDao(this.db);

  Stream<List<Customer>> watchAllCustomers({String? query}) {
    final statement = db.select(db.customers)
      ..where((tbl) => tbl.isDeleted.equals(false));

    if (query != null && query.trim().isNotEmpty) {
      final term = '%${query.trim()}%';
      statement.where((tbl) => tbl.name.like(term) | tbl.mobile.like(term));
    }

    statement.orderBy([
      (tbl) => OrderingTerm(expression: tbl.name, mode: OrderingMode.asc),
    ]);

    return statement.watch();
  }

  Future<List<Customer>> getAllCustomers({String? query, bool includeDeleted = false}) async {
    final statement = db.select(db.customers);
    if (!includeDeleted) {
      statement.where((tbl) => tbl.isDeleted.equals(false));
    }

    if (query != null && query.trim().isNotEmpty) {
      final term = '%${query.trim()}%';
      statement.where((tbl) => tbl.name.like(term) | tbl.mobile.like(term));
    }

    statement.orderBy([
      (tbl) => OrderingTerm(expression: tbl.name, mode: OrderingMode.asc),
    ]);

    return statement.get();
  }

  Future<Customer?> getCustomerById(int id) {
    return (db.select(db.customers)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<Customer?> getCustomerByMobile(String mobile) {
    return (db.select(db.customers)
          ..where((tbl) => tbl.mobile.equals(mobile.trim()) & tbl.isDeleted.equals(false)))
        .getSingleOrNull();
  }

  Future<bool> checkMobileExists(String mobile, {int? excludeCustomerId}) async {
    final statement = db.select(db.customers)
      ..where((tbl) => tbl.mobile.equals(mobile.trim()) & tbl.isDeleted.equals(false));
    if (excludeCustomerId != null) {
      statement.where((tbl) => tbl.id.isNotValue(excludeCustomerId));
    }
    final result = await statement.get();
    return result.isNotEmpty;
  }

  Future<int> insertCustomer(CustomersCompanion customer) {
    return db.transaction(() async {
      final id = await db.into(db.customers).insert(customer);
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'CREATE',
              targetEntity: 'Customer',
              entityId: Value(id),
              details: Value('Created customer ${customer.name.value} (${customer.mobile.value})'),
            ),
          );
      return id;
    });
  }

  Future<bool> updateCustomer(CustomersCompanion customer) {
    return db.transaction(() async {
      final updated = await db.update(db.customers).replace(
            customer.copyWith(updatedAt: Value(DateTime.now())),
          );
      if (updated) {
        await db.into(db.auditLogs).insert(
              AuditLogsCompanion.insert(
                action: 'UPDATE',
                targetEntity: 'Customer',
                entityId: customer.id,
                details: Value('Updated customer details'),
              ),
            );
      }
      return updated;
    });
  }

  Future<int> softDeleteCustomer(int id) {
    return db.transaction(() async {
      final result = await (db.update(db.customers)..where((tbl) => tbl.id.equals(id))).write(
        CustomersCompanion(
          isDeleted: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'DELETE',
              targetEntity: 'Customer',
              entityId: Value(id),
              details: const Value('Soft deleted customer'),
            ),
          );
      return result;
    });
  }

  Future<CustomerFinancialSummary> getCustomerFinancialSummary(int customerId) async {
    // 1. Total billed from active, non-cancelled invoices
    final invoices = await (db.select(db.invoices)
          ..where((tbl) => tbl.customerId.equals(customerId) & tbl.isCancelled.equals(false)))
        .get();

    double totalBilled = 0.0;
    int pendingBillsCount = 0;
    for (final inv in invoices) {
      totalBilled += inv.grandTotal;
      if (inv.pendingAmount > 0) {
        pendingBillsCount++;
      }
    }

    // 2. Total paid from non-deleted payments
    final payments = await (db.select(db.payments)
          ..where((tbl) => tbl.customerId.equals(customerId) & tbl.isDeleted.equals(false)))
        .get();

    double totalPaid = 0.0;
    for (final p in payments) {
      totalPaid += p.amountReceived;
    }

    // 3. Outstanding balance derived directly from transactions
    final outstanding = (totalBilled - totalPaid);

    // 4. Job counts
    final jobs = await (db.select(db.repairJobs)
          ..where((tbl) => tbl.customerId.equals(customerId) & tbl.isDeleted.equals(false)))
        .get();

    final totalJobs = jobs.length;
    final pendingJobs = jobs.where((j) => j.jobStatus != 'delivered').length;

    return CustomerFinancialSummary(
      totalBilled: totalBilled,
      totalPaid: totalPaid,
      outstandingBalance: outstanding < 0.0 ? 0.0 : outstanding,
      totalJobsCount: totalJobs,
      pendingJobsCount: pendingJobs,
      pendingBillsCount: pendingBillsCount,
    );
  }

  Future<List<CustomerLedgerEntry>> getCustomerLedger(int customerId) async {
    // 1. Get all uncancelled invoices for this customer
    final invoices = await (db.select(db.invoices)
          ..where((tbl) => tbl.customerId.equals(customerId) & tbl.isCancelled.equals(false))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.invoiceDate, mode: OrderingMode.asc)]))
        .get();

    // 2. Get all non-deleted payments for this customer
    final payments = await (db.select(db.payments)
          ..where((tbl) => tbl.customerId.equals(customerId) & tbl.isDeleted.equals(false))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.paymentDate, mode: OrderingMode.asc)]))
        .get();

    // 3. Merge them chronologically
    final List<_RawLedgerItem> rawItems = [];
    for (final inv in invoices) {
      rawItems.add(_RawLedgerItem(
        date: inv.invoiceDate,
        isDebit: true,
        title: inv.invoiceNumber,
        subtitle: 'बिल (${inv.category == "repair" ? "मोटर रिपेअर" : inv.category == "motor_sales" ? "मोटर विक्री" : "पार्ट्स विक्री"})',
        amount: inv.grandTotal,
        invoiceId: inv.id,
      ));
    }

    for (final p in payments) {
      rawItems.add(_RawLedgerItem(
        date: p.paymentDate,
        isDebit: false,
        title: 'पेमेंट (${p.paymentMode.toUpperCase()})',
        subtitle: p.transactionReference != null && p.transactionReference!.isNotEmpty
            ? 'Ref: ${p.transactionReference}'
            : (p.notes ?? 'जमा पेमेंट'),
        amount: p.amountReceived,
        paymentId: p.id,
      ));
    }

    // Sort ascending by date
    rawItems.sort((a, b) => a.date.compareTo(b.date));

    // 4. Calculate running balance
    double currentBalance = 0.0;
    final List<CustomerLedgerEntry> ledger = [];

    for (final item in rawItems) {
      if (item.isDebit) {
        currentBalance += item.amount;
        ledger.add(CustomerLedgerEntry(
          date: item.date,
          type: 'debit',
          title: item.title,
          subtitle: item.subtitle,
          debit: item.amount,
          credit: 0.0,
          runningBalance: currentBalance,
          invoiceId: item.invoiceId,
        ));
      } else {
        currentBalance -= item.amount;
        ledger.add(CustomerLedgerEntry(
          date: item.date,
          type: 'credit',
          title: item.title,
          subtitle: item.subtitle,
          debit: 0.0,
          credit: item.amount,
          runningBalance: currentBalance,
          paymentId: item.paymentId,
        ));
      }
    }

    // Return descending for UI presentation (newest first)
    return ledger.reversed.toList();
  }
}

class CustomerLedgerEntry {
  final DateTime date;
  final String type; // 'debit' or 'credit'
  final String title;
  final String subtitle;
  final double debit;
  final double credit;
  final double runningBalance;
  final int? invoiceId;
  final int? paymentId;

  const CustomerLedgerEntry({
    required this.date,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.debit,
    required this.credit,
    required this.runningBalance,
    this.invoiceId,
    this.paymentId,
  });
}

class _RawLedgerItem {
  final DateTime date;
  final bool isDebit;
  final String title;
  final String subtitle;
  final double amount;
  final int? invoiceId;
  final int? paymentId;

  _RawLedgerItem({
    required this.date,
    required this.isDebit,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.invoiceId,
    this.paymentId,
  });
}

