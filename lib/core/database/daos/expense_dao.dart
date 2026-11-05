import 'package:drift/drift.dart';
import '../app_database.dart';

class ExpenseDao {
  final AppDatabase db;

  ExpenseDao(this.db);

  Stream<List<Expense>> watchExpensesForDateRange(DateTime start, DateTime end) {
    final startOfDay = DateTime(start.year, start.month, start.day);
    final endOfDay = DateTime(end.year, end.month, end.day, 23, 59, 59, 999);

    return (db.select(db.expenses)
          ..where((tbl) =>
              tbl.expenseDate.isBiggerOrEqual(Variable(startOfDay)) &
              tbl.expenseDate.isSmallerOrEqual(Variable(endOfDay)))
          ..orderBy([(t) => OrderingTerm(expression: t.expenseDate, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<List<Expense>> getExpensesForDateRange(DateTime start, DateTime end) {
    final startOfDay = DateTime(start.year, start.month, start.day);
    final endOfDay = DateTime(end.year, end.month, end.day, 23, 59, 59, 999);

    return (db.select(db.expenses)
          ..where((tbl) =>
              tbl.expenseDate.isBiggerOrEqual(Variable(startOfDay)) &
              tbl.expenseDate.isSmallerOrEqual(Variable(endOfDay)))
          ..orderBy([(t) => OrderingTerm(expression: t.expenseDate, mode: OrderingMode.desc)]))
        .get();
  }

  Future<int> insertExpense(ExpensesCompanion expense) {
    return db.transaction(() async {
      final id = await db.into(db.expenses).insert(expense);
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'CREATE',
              targetEntity: 'Expense',
              entityId: Value(id),
              details: Value('Added expense: ₹${expense.amount.value} for ${expense.category.value}'),
            ),
          );
      return id;
    });
  }

  Future<int> deleteExpense(int id) {
    return db.transaction(() async {
      final result = await (db.delete(db.expenses)..where((tbl) => tbl.id.equals(id))).go();
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'DELETE',
              targetEntity: 'Expense',
              entityId: Value(id),
              details: Value('Deleted expense #$id'),
            ),
          );
      return result;
    });
  }
}
