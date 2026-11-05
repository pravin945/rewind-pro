import 'package:drift/drift.dart';
import '../app_database.dart';

class CustomerLedgerEntry {
  final DateTime date;
  final String type; // 'INVOICE' (Debit) or 'PAYMENT' (Credit)
  final String description;
  final String? referenceNumber;
  final double debit; // Bill amount
  final double credit; // Payment amount
  final double runningBalance;

  CustomerLedgerEntry({
    required this.date,
    required this.type,
    required this.description,
    this.referenceNumber,
    required this.debit,
    required this.credit,
    required this.runningBalance,
  });
}

class CustomerPendingInfo {
  final Customer customer;
  final double totalBilled;
  final double totalPaid;
  final double remainingBalance;
  final DateTime? oldestPendingDate;
  final int numberOfPendingBills;

  CustomerPendingInfo({
    required this.customer,
    required this.totalBilled,
    required this.totalPaid,
    required this.remainingBalance,
    this.oldestPendingDate,
    required this.numberOfPendingBills,
  });
}

class PaymentDao {
  final AppDatabase db;

  PaymentDao(this.db);

  Stream<List<Payment>> watchPayments({int? customerId, int? invoiceId}) {
    final statement = db.select(db.payments)
      ..where((tbl) => tbl.isDeleted.equals(false));

    if (customerId != null) {
      statement.where((tbl) => tbl.customerId.equals(customerId));
    }

    if (invoiceId != null) {
      statement.where((tbl) => tbl.invoiceId.equals(invoiceId));
    }

    statement.orderBy([
      (tbl) => OrderingTerm(expression: tbl.paymentDate, mode: OrderingMode.desc),
    ]);

    return statement.watch();
  }

  Future<List<Payment>> getPayments({
    int? customerId,
    int? invoiceId,
    int? repairJobId,
  }) async {
    final statement = db.select(db.payments)
      ..where((tbl) => tbl.isDeleted.equals(false));

    if (customerId != null) {
      statement.where((tbl) => tbl.customerId.equals(customerId));
    }

    if (invoiceId != null) {
      statement.where((tbl) => tbl.invoiceId.equals(invoiceId));
    }

    if (repairJobId != null) {
      statement.where((tbl) => tbl.repairJobId.equals(repairJobId));
    }

    statement.orderBy([
      (tbl) => OrderingTerm(expression: tbl.paymentDate, mode: OrderingMode.desc),
    ]);

    return statement.get();
  }

  Future<int> recordPayment(PaymentsCompanion payment) {
    return db.transaction(() async {
      // 1. Insert payment record
      final paymentId = await db.into(db.payments).insert(payment);

      // 2. If linked to an invoice, recalculate invoice balance
      if (payment.invoiceId.present && payment.invoiceId.value != null) {
        final invId = payment.invoiceId.value!;
        final invoice = await (db.select(db.invoices)..where((tbl) => tbl.id.equals(invId))).getSingleOrNull();
        if (invoice != null) {
          // Calculate sum of all non-deleted payments for this invoice
          final allPayments = await (db.select(db.payments)
                ..where((tbl) => tbl.invoiceId.equals(invId) & tbl.isDeleted.equals(false)))
              .get();

          final totalPaid = allPayments.fold<double>(0.0, (acc, p) => acc + p.amountReceived);
          final pending = invoice.grandTotal - totalPaid;

          await (db.update(db.invoices)..where((tbl) => tbl.id.equals(invId))).write(
            InvoicesCompanion(
              paidAmount: Value(totalPaid),
              pendingAmount: Value(pending < 0.0 ? 0.0 : pending),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }

      // 3. If linked to a repair job directly without an invoice yet
      if (payment.repairJobId.present && payment.repairJobId.value != null) {
        final jobId = payment.repairJobId.value!;
        final job = await (db.select(db.repairJobs)..where((tbl) => tbl.id.equals(jobId))).getSingleOrNull();
        if (job != null) {
          final allJobPayments = await (db.select(db.payments)
                ..where((tbl) => tbl.repairJobId.equals(jobId) & tbl.isDeleted.equals(false)))
              .get();
          final totalAdvance = allJobPayments.fold<double>(0.0, (acc, p) => acc + p.amountReceived);
          final remaining = job.finalAmount - totalAdvance;

          await (db.update(db.repairJobs)..where((tbl) => tbl.id.equals(jobId))).write(
            RepairJobsCompanion(
              advancePayment: Value(totalAdvance),
              remainingAmount: Value(remaining < 0.0 ? 0.0 : remaining),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }

      // 4. Audit log
      final mode = payment.paymentMode.present ? payment.paymentMode.value : 'cash';
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'PAYMENT_RECEIVED',
              targetEntity: 'Payment',
              entityId: Value(paymentId),
              details: Value('Received ₹${payment.amountReceived.value} via $mode'),
            ),
          );

      return paymentId;
    });
  }

  Future<void> softDeletePayment(int paymentId) {
    return db.transaction(() async {
      final payment = await (db.select(db.payments)..where((tbl) => tbl.id.equals(paymentId))).getSingleOrNull();
      if (payment == null) return;

      await (db.update(db.payments)..where((tbl) => tbl.id.equals(paymentId))).write(
        const PaymentsCompanion(isDeleted: Value(true)),
      );

      // Recalculate invoice if linked
      if (payment.invoiceId != null) {
        final invId = payment.invoiceId!;
        final invoice = await (db.select(db.invoices)..where((tbl) => tbl.id.equals(invId))).getSingleOrNull();
        if (invoice != null) {
          final allPayments = await (db.select(db.payments)
                ..where((tbl) => tbl.invoiceId.equals(invId) & tbl.isDeleted.equals(false)))
              .get();
          final totalPaid = allPayments.fold<double>(0.0, (acc, p) => acc + p.amountReceived);
          final pending = invoice.grandTotal - totalPaid;

          await (db.update(db.invoices)..where((tbl) => tbl.id.equals(invId))).write(
            InvoicesCompanion(
              paidAmount: Value(totalPaid),
              pendingAmount: Value(pending < 0.0 ? 0.0 : pending),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }

      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'DELETE',
              targetEntity: 'Payment',
              entityId: Value(paymentId),
              details: Value('Deleted payment of ₹${payment.amountReceived}'),
            ),
          );
    });
  }

  Future<List<CustomerLedgerEntry>> getCustomerLedger(int customerId) async {
    // Invoices are DEBIT (amount customer owes)
    final invoices = await (db.select(db.invoices)
          ..where((tbl) => tbl.customerId.equals(customerId) & tbl.isCancelled.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.invoiceDate, mode: OrderingMode.asc)]))
        .get();

    // Payments are CREDIT (amount customer paid)
    final payments = await (db.select(db.payments)
          ..where((tbl) => tbl.customerId.equals(customerId) & tbl.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.paymentDate, mode: OrderingMode.asc)]))
        .get();

    // Merge and sort chronologically
    final allEvents = <_LedgerEvent>[];

    for (final inv in invoices) {
      allEvents.add(
        _LedgerEvent(
          date: inv.invoiceDate,
          type: 'INVOICE',
          description: 'बिल (${inv.category == 'repair' ? 'मोटर रिपेअर' : 'विक्री'})',
          ref: inv.invoiceNumber,
          debit: inv.grandTotal,
          credit: 0.0,
        ),
      );
    }

    for (final p in payments) {
      allEvents.add(
        _LedgerEvent(
          date: p.paymentDate,
          type: 'PAYMENT',
          description: 'जमा रक्कम (${p.paymentMode.toUpperCase()})',
          ref: p.transactionReference,
          debit: 0.0,
          credit: p.amountReceived,
        ),
      );
    }

    allEvents.sort((a, b) => a.date.compareTo(b.date));

    final ledger = <CustomerLedgerEntry>[];
    double running = 0.0;

    for (final ev in allEvents) {
      running += (ev.debit - ev.credit);
      ledger.add(
        CustomerLedgerEntry(
          date: ev.date,
          type: ev.type,
          description: ev.description,
          referenceNumber: ev.ref,
          debit: ev.debit,
          credit: ev.credit,
          runningBalance: running,
        ),
      );
    }

    return ledger;
  }

  Future<List<CustomerPendingInfo>> getPendingPaymentsList({
    String sortBy = 'amount', // 'amount' or 'oldest'
  }) async {
    final customers = await (db.select(db.customers)
          ..where((tbl) => tbl.isDeleted.equals(false)))
        .get();

    final result = <CustomerPendingInfo>[];

    for (final cust in customers) {
      final invoices = await (db.select(db.invoices)
            ..where((tbl) => tbl.customerId.equals(cust.id) & tbl.isCancelled.equals(false)))
          .get();

      final payments = await (db.select(db.payments)
            ..where((tbl) => tbl.customerId.equals(cust.id) & tbl.isDeleted.equals(false)))
          .get();

      final totalBilled = invoices.fold<double>(0.0, (acc, inv) => acc + inv.grandTotal);
      final totalPaid = payments.fold<double>(0.0, (acc, p) => acc + p.amountReceived);
      final remaining = totalBilled - totalPaid;

      if (remaining > 0.01) {
        // Find oldest pending bill date
        DateTime? oldest;
        int pendingBills = 0;
        for (final inv in invoices) {
          if (inv.pendingAmount > 0.01) {
            pendingBills++;
            if (oldest == null || inv.invoiceDate.isBefore(oldest)) {
              oldest = inv.invoiceDate;
            }
          }
        }

        result.add(
          CustomerPendingInfo(
            customer: cust,
            totalBilled: totalBilled,
            totalPaid: totalPaid,
            remainingBalance: remaining,
            oldestPendingDate: oldest,
            numberOfPendingBills: pendingBills,
          ),
        );
      }
    }

    if (sortBy == 'amount') {
      result.sort((a, b) => b.remainingBalance.compareTo(a.remainingBalance));
    } else {
      result.sort((a, b) {
        if (a.oldestPendingDate == null) return 1;
        if (b.oldestPendingDate == null) return -1;
        return a.oldestPendingDate!.compareTo(b.oldestPendingDate!);
      });
    }

    return result;
  }
}

class _LedgerEvent {
  final DateTime date;
  final String type;
  final String description;
  final String? ref;
  final double debit;
  final double credit;

  _LedgerEvent({
    required this.date,
    required this.type,
    required this.description,
    this.ref,
    required this.debit,
    required this.credit,
  });
}

