import 'package:drift/drift.dart';
import '../app_database.dart';

class DashboardSummary {
  final double totalIncome;
  final double receivedPayment;
  final double pendingPayment;
  final int newJobsToday;
  final int activeJobsCount;
  final int completedJobsCount;
  final int deliveredJobsCount;
  final double totalPendingCustomerPayments;
  final double todaySalesAmount;
  final int lowStockProductsCount;

  DashboardSummary({
    required this.totalIncome,
    required this.receivedPayment,
    required this.pendingPayment,
    required this.newJobsToday,
    required this.activeJobsCount,
    required this.completedJobsCount,
    required this.deliveredJobsCount,
    required this.totalPendingCustomerPayments,
    required this.todaySalesAmount,
    required this.lowStockProductsCount,
  });
}

class CategoryIncomeBreakdown {
  final double repairIncome;
  final double motorSalesIncome;
  final double partsSalesIncome;
  final double totalExpenses;

  CategoryIncomeBreakdown({
    required this.repairIncome,
    required this.motorSalesIncome,
    required this.partsSalesIncome,
    required this.totalExpenses,
  });

  double get netProfit => (repairIncome + motorSalesIncome + partsSalesIncome) - totalExpenses;
}

class ReportDao {
  final AppDatabase db;

  ReportDao(this.db);

  Future<DashboardSummary> getDashboardSummary({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final now = DateTime.now();
    final start = startDate ?? DateTime(now.year, now.month, now.day);
    final end = endDate ?? DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    // 1. Payments received during the period
    final payments = await (db.select(db.payments)
          ..where((tbl) =>
              tbl.paymentDate.isBiggerOrEqual(Variable(start)) &
              tbl.paymentDate.isSmallerOrEqual(Variable(end)) &
              tbl.isDeleted.equals(false)))
        .get();

    final totalReceived = payments.fold<double>(0.0, (acc, p) => acc + p.amountReceived);

    // 2. Invoices generated during the period
    final invoices = await (db.select(db.invoices)
          ..where((tbl) =>
              tbl.invoiceDate.isBiggerOrEqual(Variable(start)) &
              tbl.invoiceDate.isSmallerOrEqual(Variable(end)) &
              tbl.isCancelled.equals(false)))
        .get();

    final totalBilled = invoices.fold<double>(0.0, (acc, inv) => acc + inv.grandTotal);
    final periodPending = invoices.fold<double>(0.0, (acc, inv) => acc + inv.pendingAmount);

    // Today sales (motor_sales + parts_sales)
    final salesInvoices = invoices.where((i) => i.category == 'motor_sales' || i.category == 'parts_sales');
    final todaySales = salesInvoices.fold<double>(0.0, (acc, inv) => acc + inv.grandTotal);

    // 3. New jobs today / in range
    final periodJobs = await (db.select(db.repairJobs)
          ..where((tbl) =>
              tbl.receivedDate.isBiggerOrEqual(Variable(start)) &
              tbl.receivedDate.isSmallerOrEqual(Variable(end)) &
              tbl.isDeleted.equals(false)))
        .get();

    // 4. All active jobs
    final allActiveJobs = await (db.select(db.repairJobs)
          ..where((tbl) =>
              tbl.isDeleted.equals(false) &
              tbl.jobStatus.equals('completed').not() &
              tbl.jobStatus.equals('delivered').not()))
        .get();

    final completedJobs = await (db.select(db.repairJobs)
          ..where((tbl) => tbl.isDeleted.equals(false) & tbl.jobStatus.equals('completed')))
        .get();

    final deliveredJobs = await (db.select(db.repairJobs)
          ..where((tbl) => tbl.isDeleted.equals(false) & tbl.jobStatus.equals('delivered')))
        .get();

    // 5. Total pending customer payments across ALL uncancelled invoices
    final allUncancelledInvoices = await (db.select(db.invoices)
          ..where((tbl) => tbl.isCancelled.equals(false)))
        .get();

    final allActivePayments = await (db.select(db.payments)
          ..where((tbl) => tbl.isDeleted.equals(false)))
        .get();

    final grandBilled = allUncancelledInvoices.fold<double>(0.0, (acc, inv) => acc + inv.grandTotal);
    final grandPaid = allActivePayments.fold<double>(0.0, (acc, p) => acc + p.amountReceived);
    final totalPendingOverall = grandBilled > grandPaid ? grandBilled - grandPaid : 0.0;

    // 6. Low stock products count
    final products = await (db.select(db.products)
          ..where((tbl) => tbl.isDeleted.equals(false)))
        .get();

    final lowStockCount = products.where((p) => p.currentStock <= p.minimumStockLevel).length;

    return DashboardSummary(
      totalIncome: totalBilled,
      receivedPayment: totalReceived,
      pendingPayment: periodPending,
      newJobsToday: periodJobs.length,
      activeJobsCount: allActiveJobs.length,
      completedJobsCount: completedJobs.length,
      deliveredJobsCount: deliveredJobs.length,
      totalPendingCustomerPayments: totalPendingOverall,
      todaySalesAmount: todaySales,
      lowStockProductsCount: lowStockCount,
    );
  }

  Future<CategoryIncomeBreakdown> getCategoryIncomeBreakdown(DateTime start, DateTime end) async {
    final startOfDay = DateTime(start.year, start.month, start.day);
    final endOfDay = DateTime(end.year, end.month, end.day, 23, 59, 59, 999);

    final invoices = await (db.select(db.invoices)
          ..where((tbl) =>
              tbl.invoiceDate.isBiggerOrEqual(Variable(startOfDay)) &
              tbl.invoiceDate.isSmallerOrEqual(Variable(endOfDay)) &
              tbl.isCancelled.equals(false)))
        .get();

    double repair = 0.0;
    double motorSales = 0.0;
    double partsSales = 0.0;

    for (final inv in invoices) {
      if (inv.category == 'repair') {
        repair += inv.grandTotal;
      } else if (inv.category == 'motor_sales') {
        motorSales += inv.grandTotal;
      } else if (inv.category == 'parts_sales') {
        partsSales += inv.grandTotal;
      }
    }

    final expenses = await (db.select(db.expenses)
          ..where((tbl) =>
              tbl.expenseDate.isBiggerOrEqual(Variable(startOfDay)) &
              tbl.expenseDate.isSmallerOrEqual(Variable(endOfDay))))
        .get();

    final totalExp = expenses.fold<double>(0.0, (acc, e) => acc + e.amount);

    return CategoryIncomeBreakdown(
      repairIncome: repair,
      motorSalesIncome: motorSales,
      partsSalesIncome: partsSales,
      totalExpenses: totalExp,
    );
  }
}
