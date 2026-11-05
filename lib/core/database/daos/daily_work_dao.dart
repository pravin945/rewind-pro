import 'package:drift/drift.dart';
import '../app_database.dart';

class DailyWorkDao {
  final AppDatabase db;

  DailyWorkDao(this.db);

  Stream<List<DailyWorkLog>> watchLogsForDate(DateTime date) {
    return watchLogsForDateRange(date, date);
  }

  Stream<List<DailyWorkLog>> watchLogsForDateRange(DateTime start, DateTime end) {
    final startOfDay = DateTime(start.year, start.month, start.day);
    final endOfDay = DateTime(end.year, end.month, end.day, 23, 59, 59, 999);

    return (db.select(db.dailyWorkLogs)
          ..where((tbl) =>
              tbl.logDate.isBiggerOrEqual(Variable(startOfDay)) &
              tbl.logDate.isSmallerOrEqual(Variable(endOfDay)))
          ..orderBy([(t) => OrderingTerm(expression: t.logDate, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<List<DailyWorkLog>> getLogsForDateRange(DateTime start, DateTime end) {
    final startOfDay = DateTime(start.year, start.month, start.day);
    final endOfDay = DateTime(end.year, end.month, end.day, 23, 59, 59, 999);

    return (db.select(db.dailyWorkLogs)
          ..where((tbl) =>
              tbl.logDate.isBiggerOrEqual(Variable(startOfDay)) &
              tbl.logDate.isSmallerOrEqual(Variable(endOfDay)))
          ..orderBy([(t) => OrderingTerm(expression: t.logDate, mode: OrderingMode.desc)]))
        .get();
  }

  Future<int> insertLog(DailyWorkLogsCompanion log) {
    return db.transaction(() async {
      final id = await db.into(db.dailyWorkLogs).insert(log);
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'CREATE',
              targetEntity: 'DailyWorkLog',
              entityId: Value(id),
              details: Value('Added daily work log: ${log.workPerformed.value}'),
            ),
          );
      return id;
    });
  }

  Future<bool> updateLog(DailyWorkLogsCompanion log) {
    return db.transaction(() async {
      final updated = await (db.update(db.dailyWorkLogs)..where((tbl) => tbl.id.equals(log.id.value))).write(
        log.copyWith(updatedAt: Value(DateTime.now())),
      );

      if (updated > 0) {
        await db.into(db.auditLogs).insert(
              AuditLogsCompanion.insert(
                action: 'UPDATE',
                targetEntity: 'DailyWorkLog',
                entityId: log.id,
                details: Value('Updated daily work log #${log.id.value}'),
              ),
            );
      }

      return updated > 0;
    });
  }

  Future<int> deleteLog(int id) {
    return db.transaction(() async {
      final result = await (db.delete(db.dailyWorkLogs)..where((tbl) => tbl.id.equals(id))).go();
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'DELETE',
              targetEntity: 'DailyWorkLog',
              entityId: Value(id),
              details: Value('Deleted daily work log #$id'),
            ),
          );
      return result;
    });
  }
}
