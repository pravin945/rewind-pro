import 'package:drift/drift.dart';

/// 1. Customers Table
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get mobile => text().withLength(min: 10, max: 15)();
  TextColumn get alternateMobile => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get villageCity => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

/// 2. Product Categories Table
class ProductCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 3. Products / Inventory Table
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get categoryId => integer().nullable().references(ProductCategories, #id)();
  TextColumn get brand => text().nullable()();
  TextColumn get modelNumber => text().nullable()();
  TextColumn get hp => text().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get purchasePrice => real().withDefault(const Constant(0.0))();
  RealColumn get sellingPrice => real().withDefault(const Constant(0.0))();
  RealColumn get currentStock => real().withDefault(const Constant(0.0))();
  RealColumn get minimumStockLevel => real().withDefault(const Constant(0.0))();
  TextColumn get unit => text().withDefault(const Constant('pcs'))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 4. Repair Jobs Table
class RepairJobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get jobNumber => text().unique()();
  IntColumn get customerId => integer().references(Customers, #id)();
  TextColumn get customerNameSnapshot => text().nullable()();
  TextColumn get customerMobileSnapshot => text().nullable()();
  TextColumn get motorType => text()(); // Submersible, Monoblock, Openwell, Induction, etc.
  TextColumn get motorBrand => text()();
  TextColumn get motorHp => text()();
  TextColumn get motorPhase => text()(); // Single Phase / Three Phase
  TextColumn get motorVoltage => text().nullable()();
  TextColumn get motorSerialNumber => text().nullable()();
  TextColumn get problemDescription => text()();
  TextColumn get workDescription => text().nullable()();
  RealColumn get labourCharges => real().withDefault(const Constant(0.0))();
  RealColumn get materialCharges => real().withDefault(const Constant(0.0))();
  RealColumn get otherCharges => real().withDefault(const Constant(0.0))();
  RealColumn get discount => real().withDefault(const Constant(0.0))();
  RealColumn get finalAmount => real().withDefault(const Constant(0.0))();
  RealColumn get advancePayment => real().withDefault(const Constant(0.0))();
  RealColumn get remainingAmount => real().withDefault(const Constant(0.0))();
  // Statuses: received, inspection, inProgress, waitingForParts, completed, delivered
  TextColumn get jobStatus => text().withDefault(const Constant('received'))();
  DateTimeColumn get receivedDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expectedDeliveryDate => dateTime().nullable()();
  DateTimeColumn get deliveryDate => dateTime().nullable()();
  TextColumn get warrantyInfo => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 5. Repair Job Parts Table
class RepairJobParts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get repairJobId => integer().references(RepairJobs, #id)();
  IntColumn get productId => integer().nullable().references(Products, #id)();
  TextColumn get partName => text()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  RealColumn get unitPrice => real().withDefault(const Constant(0.0))();
  RealColumn get totalPrice => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 6. Invoices Table
class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNumber => text().unique()();
  TextColumn get category => text()(); // repair, motor_sales, parts_sales
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  TextColumn get customerName => text().nullable()();
  TextColumn get customerMobile => text().nullable()();
  IntColumn get repairJobId => integer().nullable().references(RepairJobs, #id)();
  DateTimeColumn get invoiceDate => dateTime().withDefault(currentDateAndTime)();
  RealColumn get subtotal => real().withDefault(const Constant(0.0))();
  RealColumn get discount => real().withDefault(const Constant(0.0))();
  RealColumn get taxRate => real().withDefault(const Constant(0.0))();
  RealColumn get taxAmount => real().withDefault(const Constant(0.0))();
  RealColumn get grandTotal => real().withDefault(const Constant(0.0))();
  RealColumn get paidAmount => real().withDefault(const Constant(0.0))();
  RealColumn get pendingAmount => real().withDefault(const Constant(0.0))();
  TextColumn get paymentMode => text().withDefault(const Constant('cash'))();
  TextColumn get notes => text().nullable()();
  TextColumn get termsAndConditions => text().nullable()();
  BoolColumn get isCancelled => boolean().withDefault(const Constant(false))();
  TextColumn get cancellationReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 7. Invoice Items Table
class InvoiceItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId => integer().references(Invoices, #id)();
  IntColumn get productId => integer().nullable().references(Products, #id)();
  TextColumn get description => text()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  RealColumn get unitPrice => real().withDefault(const Constant(0.0))();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 8. Payments Table
class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get invoiceId => integer().nullable().references(Invoices, #id)();
  IntColumn get repairJobId => integer().nullable().references(RepairJobs, #id)();
  DateTimeColumn get paymentDate => dateTime().withDefault(currentDateAndTime)();
  RealColumn get amountReceived => real()();
  TextColumn get paymentMode => text().withDefault(const Constant('cash'))(); // cash, upi, bank_transfer, other
  TextColumn get transactionReference => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 9. Stock Movements Table
class StockMovements extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  TextColumn get movementType => text()(); // purchase, sale, repair_use, adjustment_in, adjustment_out
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real().withDefault(const Constant(0.0))();
  TextColumn get referenceType => text().nullable()(); // invoice, repair_job, manual
  IntColumn get referenceId => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 10. Daily Work Logs Table
class DailyWorkLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get logDate => dateTime().withDefault(currentDateAndTime)();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  TextColumn get customerName => text().nullable()();
  IntColumn get repairJobId => integer().nullable().references(RepairJobs, #id)();
  TextColumn get jobNumber => text().nullable()();
  TextColumn get motorDetails => text().nullable()();
  TextColumn get workPerformed => text()();
  TextColumn get partsUsed => text().nullable()();
  RealColumn get labourCharges => real().withDefault(const Constant(0.0))();
  RealColumn get paymentReceived => real().withDefault(const Constant(0.0))();
  RealColumn get pendingAmount => real().withDefault(const Constant(0.0))();
  TextColumn get workStatus => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 11. Business Settings Table
class BusinessSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get shopName => text().withDefault(const Constant('प्रताप मोटर रिवाइंडिंग अँड सेल्स'))();
  TextColumn get ownerName => text().withDefault(const Constant('प्रोप्राईटर'))();
  TextColumn get shopAddress => text().withDefault(const Constant('फाकटे, तालुका शिरूर, जिल्हा पुणे'))();
  TextColumn get mobileNumber => text().withDefault(const Constant(''))();
  TextColumn get alternateMobile => text().nullable()();
  TextColumn get gstin => text().nullable()();
  TextColumn get invoicePrefix => text().withDefault(const Constant('INV-'))();
  TextColumn get jobPrefix => text().withDefault(const Constant('JOB-'))();
  RealColumn get defaultTaxRate => real().withDefault(const Constant(0.0))();
  BoolColumn get isGstEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get currency => text().withDefault(const Constant('₹'))();
  TextColumn get defaultLanguage => text().withDefault(const Constant('mr_en'))();
  TextColumn get pdfFooter => text().nullable()();
  TextColumn get warrantyTerms => text().nullable()();
  TextColumn get paymentInstructions => text().nullable()();
  BoolColumn get autoBackupEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get backupScheduleTime => text().withDefault(const Constant('22:00'))();
  IntColumn get backupRetentionCount => integer().withDefault(const Constant(7))();
  DateTimeColumn get lastBackupTimestamp => dateTime().nullable()();
  TextColumn get lastBackupStatus => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 12. Backup Histories Table
class BackupHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get backupDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get fileName => text()();
  IntColumn get fileSize => integer()();
  TextColumn get driveFileId => text().nullable()();
  TextColumn get backupType => text().withDefault(const Constant('manual'))(); // automatic, manual
  TextColumn get status => text()(); // success, failed
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 13. Job Status Histories Table
class JobStatusHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get repairJobId => integer().references(RepairJobs, #id)();
  TextColumn get fromStatus => text().nullable()();
  TextColumn get toStatus => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get changedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 14. Expenses Table
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get expenseDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get category => text()();
  RealColumn get amount => real()();
  TextColumn get paymentMode => text().withDefault(const Constant('cash'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 15. Audit Logs Table
class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get action => text()(); // CREATE, UPDATE, DELETE, CANCEL, BACKUP, RESTORE
  TextColumn get targetEntity => text()();
  IntColumn get entityId => integer().nullable()();
  TextColumn get details => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

