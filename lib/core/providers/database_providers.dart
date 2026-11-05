import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../database/daos/customer_dao.dart';
import '../database/daos/repair_job_dao.dart';
import '../database/daos/invoice_dao.dart';
import '../database/daos/payment_dao.dart';
import '../database/daos/product_dao.dart';
import '../database/daos/daily_work_dao.dart';
import '../database/daos/settings_dao.dart';
import '../database/daos/expense_dao.dart';
import '../database/daos/report_dao.dart';
import '../services/backup_service.dart';

/// Database singleton provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// DAO Providers
final customerDaoProvider = Provider<CustomerDao>((ref) {
  return CustomerDao(ref.watch(databaseProvider));
});

final repairJobDaoProvider = Provider<RepairJobDao>((ref) {
  return RepairJobDao(ref.watch(databaseProvider));
});

final invoiceDaoProvider = Provider<InvoiceDao>((ref) {
  return InvoiceDao(ref.watch(databaseProvider));
});

final paymentDaoProvider = Provider<PaymentDao>((ref) {
  return PaymentDao(ref.watch(databaseProvider));
});

final productDaoProvider = Provider<ProductDao>((ref) {
  return ProductDao(ref.watch(databaseProvider));
});

final dailyWorkDaoProvider = Provider<DailyWorkDao>((ref) {
  return DailyWorkDao(ref.watch(databaseProvider));
});

final settingsDaoProvider = Provider<SettingsDao>((ref) {
  return SettingsDao(ref.watch(databaseProvider));
});

final expenseDaoProvider = Provider<ExpenseDao>((ref) {
  return ExpenseDao(ref.watch(databaseProvider));
});

final reportDaoProvider = Provider<ReportDao>((ref) {
  return ReportDao(ref.watch(databaseProvider));
});

/// Reactive Streams Providers
final businessSettingsStreamProvider = StreamProvider<BusinessSetting>((ref) {
  return ref.watch(settingsDaoProvider).watchSettings();
});

final allCustomersStreamProvider = StreamProvider.autoDispose<List<Customer>>((ref) {
  return ref.watch(customerDaoProvider).watchAllCustomers();
});

final allJobsStreamProvider = StreamProvider.autoDispose<List<RepairJob>>((ref) {
  return ref.watch(repairJobDaoProvider).watchAllJobs();
});

final allInvoicesStreamProvider = StreamProvider.autoDispose<List<Invoice>>((ref) {
  return ref.watch(invoiceDaoProvider).watchAllInvoices();
});

final allProductsStreamProvider = StreamProvider.autoDispose<List<ProductWithCategory>>((ref) {
  return ref.watch(productDaoProvider).watchProducts();
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(
    db: ref.watch(databaseProvider),
    settingsDao: ref.watch(settingsDaoProvider),
  );
});

