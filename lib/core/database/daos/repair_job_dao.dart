import 'package:drift/drift.dart';
import '../app_database.dart';

class RepairJobWithDetails {
  final RepairJob job;
  final Customer? customer;
  final List<RepairJobPart> parts;
  final List<JobStatusHistory> statusHistory;

  RepairJobWithDetails({
    required this.job,
    this.customer,
    required this.parts,
    required this.statusHistory,
  });
}

class RepairJobDao {
  final AppDatabase db;

  RepairJobDao(this.db);

  Stream<List<RepairJob>> watchAllJobs({String? status, int? customerId}) {
    final statement = db.select(db.repairJobs)
      ..where((tbl) => tbl.isDeleted.equals(false));

    if (status != null && status.isNotEmpty) {
      statement.where((tbl) => tbl.jobStatus.equals(status));
    }

    if (customerId != null) {
      statement.where((tbl) => tbl.customerId.equals(customerId));
    }

    statement.orderBy([
      (tbl) => OrderingTerm(expression: tbl.receivedDate, mode: OrderingMode.desc),
    ]);

    return statement.watch();
  }

  Future<List<RepairJob>> getAllJobs({
    String? status,
    int? customerId,
    bool includeDeleted = false,
  }) async {
    final statement = db.select(db.repairJobs);

    if (!includeDeleted) {
      statement.where((tbl) => tbl.isDeleted.equals(false));
    }

    if (status != null && status.isNotEmpty) {
      statement.where((tbl) => tbl.jobStatus.equals(status));
    }

    if (customerId != null) {
      statement.where((tbl) => tbl.customerId.equals(customerId));
    }

    statement.orderBy([
      (tbl) => OrderingTerm(expression: tbl.receivedDate, mode: OrderingMode.desc),
    ]);

    return statement.get();
  }

  Future<RepairJob?> getJobById(int id) {
    return (db.select(db.repairJobs)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<RepairJob?> getJobByNumber(String jobNumber) {
    return (db.select(db.repairJobs)
          ..where((tbl) => tbl.jobNumber.equals(jobNumber.trim())))
        .getSingleOrNull();
  }

  Future<RepairJobWithDetails?> getJobDetails(int id) async {
    final job = await getJobById(id);
    if (job == null) return null;

    final customer = await (db.select(db.customers)
          ..where((tbl) => tbl.id.equals(job.customerId)))
        .getSingleOrNull();

    final parts = await (db.select(db.repairJobParts)
          ..where((tbl) => tbl.repairJobId.equals(job.id)))
        .get();

    final history = await (db.select(db.jobStatusHistories)
          ..where((tbl) => tbl.repairJobId.equals(job.id))
          ..orderBy([(t) => OrderingTerm(expression: t.changedAt, mode: OrderingMode.asc)]))
        .get();

    return RepairJobWithDetails(
      job: job,
      customer: customer,
      parts: parts,
      statusHistory: history,
    );
  }

  Future<String> generateNextJobNumber() async {
    final settings = await (db.select(db.businessSettings)..limit(1)).getSingleOrNull();
    final prefix = settings?.jobPrefix ?? 'JOB-';
    final now = DateTime.now();
    final year = now.year.toString();

    // Find the highest sequence number for this year
    final allJobs = await (db.select(db.repairJobs)
          ..where((tbl) => tbl.jobNumber.like('$prefix$year-%')))
        .get();

    int maxSeq = 0;
    final yearPrefix = '$prefix$year-';
    for (final j in allJobs) {
      if (j.jobNumber.startsWith(yearPrefix)) {
        final rest = j.jobNumber.substring(yearPrefix.length);
        final num = int.tryParse(rest);
        if (num != null && num > maxSeq) {
          maxSeq = num;
        }
      }
    }

    final nextSeq = (maxSeq + 1).toString().padLeft(4, '0');
    return '$prefix$year-$nextSeq';
  }

  Future<int> insertJob({
    required RepairJobsCompanion job,
    List<RepairJobPartsCompanion> parts = const [],
    double advancePayment = 0.0,
    String paymentMode = 'cash',
  }) {
    return db.transaction(() async {
      // 1. Insert the repair job
      final jobId = await db.into(db.repairJobs).insert(job);

      // 2. Insert parts and update stock if product linked
      for (final part in parts) {
        final partToInsert = part.copyWith(repairJobId: Value(jobId));
        await db.into(db.repairJobParts).insert(partToInsert);

        // Stock reduction if linked to an inventory product
        if (part.productId.present && part.productId.value != null) {
          final prodId = part.productId.value!;
          final prod = await (db.select(db.products)..where((tbl) => tbl.id.equals(prodId))).getSingleOrNull();
          if (prod != null) {
            final newStock = prod.currentStock - part.quantity.value;
            await (db.update(db.products)..where((tbl) => tbl.id.equals(prodId))).write(
              ProductsCompanion(
                currentStock: Value(newStock),
                updatedAt: Value(DateTime.now()),
              ),
            );

            await db.into(db.stockMovements).insert(
              StockMovementsCompanion.insert(
                productId: prodId,
                movementType: 'repair_use',
                quantity: part.quantity.value,
                unitPrice: Value(part.unitPrice.value),
                referenceType: const Value('repair_job'),
                referenceId: Value(jobId),
                notes: Value('Used in repair job ${job.jobNumber.value}'),
              ),
            );
          }
        }
      }

      // 3. Insert initial status history
      final initialStatus = job.jobStatus.present ? job.jobStatus.value : 'received';
      await db.into(db.jobStatusHistories).insert(
            JobStatusHistoriesCompanion.insert(
              repairJobId: jobId,
              fromStatus: const Value(null),
              toStatus: initialStatus,
              notes: const Value('Job card created'),
            ),
          );

      // 4. Record advance payment if greater than 0
      if (advancePayment > 0.0) {
        await db.into(db.payments).insert(
              PaymentsCompanion.insert(
                customerId: job.customerId.value,
                repairJobId: Value(jobId),
                amountReceived: advancePayment,
                paymentMode: Value(paymentMode),
                notes: Value('Advance payment for ${job.jobNumber.value}'),
              ),
            );
      }

      // 5. Audit log
      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'CREATE',
              targetEntity: 'RepairJob',
              entityId: Value(jobId),
              details: Value('Created job ${job.jobNumber.value} for motor ${job.motorType.value} ${job.motorHp.value}'),
            ),
          );

      return jobId;
    });
  }

  Future<void> updateJobStatus(int jobId, String newStatus, {String? notes}) {
    return db.transaction(() async {
      final job = await getJobById(jobId);
      if (job == null) return;
      final oldStatus = job.jobStatus;

      final now = DateTime.now();
      DateTime? deliveredDate = job.deliveryDate;
      if (newStatus == 'delivered' && deliveredDate == null) {
        deliveredDate = now;
      }

      await (db.update(db.repairJobs)..where((tbl) => tbl.id.equals(jobId))).write(
        RepairJobsCompanion(
          jobStatus: Value(newStatus),
          deliveryDate: Value(deliveredDate),
          updatedAt: Value(now),
        ),
      );

      await db.into(db.jobStatusHistories).insert(
            JobStatusHistoriesCompanion.insert(
              repairJobId: jobId,
              fromStatus: Value(oldStatus),
              toStatus: newStatus,
              notes: Value(notes ?? 'Status changed from $oldStatus to $newStatus'),
              changedAt: Value(now),
            ),
          );

      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'UPDATE_STATUS',
              targetEntity: 'RepairJob',
              entityId: Value(jobId),
              details: Value('Status updated to $newStatus'),
            ),
          );
    });
  }

  Future<void> updateJob(RepairJobsCompanion job) {
    return db.transaction(() async {
      await (db.update(db.repairJobs)..where((tbl) => tbl.id.equals(job.id.value))).write(
        job.copyWith(updatedAt: Value(DateTime.now())),
      );

      await db.into(db.auditLogs).insert(
            AuditLogsCompanion.insert(
              action: 'UPDATE',
              targetEntity: 'RepairJob',
              entityId: job.id,
              details: Value('Updated job ${job.jobNumber.value}'),
            ),
          );
    });
  }

  Future<void> addJobParts(int jobId, List<RepairJobPartsCompanion> parts) {
    return db.transaction(() async {
      for (final p in parts) {
        await db.into(db.repairJobParts).insert(p.copyWith(repairJobId: Value(jobId)));

        if (p.productId.present && p.productId.value != null) {
          final prodId = p.productId.value!;
          final prod = await (db.select(db.products)..where((tbl) => tbl.id.equals(prodId))).getSingleOrNull();
          if (prod != null) {
            final newStock = prod.currentStock - p.quantity.value;
            await (db.update(db.products)..where((tbl) => tbl.id.equals(prodId))).write(
              ProductsCompanion(
                currentStock: Value(newStock),
                updatedAt: Value(DateTime.now()),
              ),
            );

            await db.into(db.stockMovements).insert(
              StockMovementsCompanion.insert(
                productId: prodId,
                movementType: 'repair_use',
                quantity: p.quantity.value,
                unitPrice: Value(p.unitPrice.value),
                referenceType: const Value('repair_job'),
                referenceId: Value(jobId),
                notes: const Value('Additional parts added to repair job'),
              ),
            );
          }
        }
      }

      // Recalculate material charges & final amount for the job
      final allParts = await (db.select(db.repairJobParts)..where((tbl) => tbl.repairJobId.equals(jobId))).get();
      final totalMaterial = allParts.fold<double>(0.0, (acc, item) => acc + item.totalPrice);

      final job = await getJobById(jobId);
      if (job != null) {
        final newFinal = job.labourCharges + totalMaterial + job.otherCharges - job.discount;
        final newRemaining = newFinal - job.advancePayment;
        await (db.update(db.repairJobs)..where((tbl) => tbl.id.equals(jobId))).write(
          RepairJobsCompanion(
            materialCharges: Value(totalMaterial),
            finalAmount: Value(newFinal),
            remainingAmount: Value(newRemaining),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }

  Future<void> removeJobPart(int partId) {
    return db.transaction(() async {
      final part = await (db.select(db.repairJobParts)..where((tbl) => tbl.id.equals(partId))).getSingleOrNull();
      if (part == null) return;
      final jobId = part.repairJobId;

      // 1. If product was linked, restore inventory stock
      if (part.productId != null) {
        final prod = await (db.select(db.products)..where((tbl) => tbl.id.equals(part.productId!))).getSingleOrNull();
        if (prod != null) {
          final restoredStock = prod.currentStock + part.quantity;
          await (db.update(db.products)..where((tbl) => tbl.id.equals(part.productId!))).write(
            ProductsCompanion(
              currentStock: Value(restoredStock),
              updatedAt: Value(DateTime.now()),
            ),
          );

          await db.into(db.stockMovements).insert(
            StockMovementsCompanion.insert(
              productId: part.productId!,
              movementType: 'adjustment_in',
              quantity: part.quantity,
              unitPrice: Value(part.unitPrice),
              referenceType: const Value('repair_job'),
              referenceId: Value(jobId),
              notes: Value('Restored from removed repair job part #${part.id}'),
            ),
          );
        }
      }

      // 2. Delete the part
      await (db.delete(db.repairJobParts)..where((tbl) => tbl.id.equals(partId))).go();

      // 3. Recalculate material charges & final amount for the job
      final allParts = await (db.select(db.repairJobParts)..where((tbl) => tbl.repairJobId.equals(jobId))).get();
      final totalMaterial = allParts.fold<double>(0.0, (acc, item) => acc + item.totalPrice);

      final job = await getJobById(jobId);
      if (job != null) {
        final newFinal = job.labourCharges + totalMaterial + job.otherCharges - job.discount;
        final newRemaining = newFinal - job.advancePayment;
        await (db.update(db.repairJobs)..where((tbl) => tbl.id.equals(jobId))).write(
          RepairJobsCompanion(
            materialCharges: Value(totalMaterial),
            finalAmount: Value(newFinal),
            remainingAmount: Value(newRemaining),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }

  Future<int> softDeleteJob(int jobId) {
    return db.transaction(() async {
      final result = await (db.update(db.repairJobs)..where((tbl) => tbl.id.equals(jobId))).write(
        RepairJobsCompanion(
          isDeleted: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await db.into(db.auditLogs).insert(
        AuditLogsCompanion.insert(
          action: 'DELETE',
          targetEntity: 'RepairJob',
          entityId: Value(jobId),
          details: const Value('Soft deleted repair job'),
        ),
      );

      return result;
    });
  }
}

