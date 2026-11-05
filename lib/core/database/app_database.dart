import 'package:drift/drift.dart';
import 'connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Customers,
  ProductCategories,
  Products,
  RepairJobs,
  RepairJobParts,
  Invoices,
  InvoiceItems,
  Payments,
  StockMovements,
  DailyWorkLogs,
  BusinessSettings,
  BackupHistories,
  JobStatusHistories,
  Expenses,
  AuditLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openDatabaseConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _createIndexes();
          await _seedDefaultData();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Schema migrations for future versions
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  Future<void> _createIndexes() async {
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_customers_mobile ON customers(mobile);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_customers_name ON customers(name);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_repair_jobs_number ON repair_jobs(job_number);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_repair_jobs_customer ON repair_jobs(customer_id);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_repair_jobs_status ON repair_jobs(job_status);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_invoices_number ON invoices(invoice_number);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_invoices_customer ON invoices(customer_id);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_payments_customer ON payments(customer_id);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_payments_invoice ON payments(invoice_id);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_products_name ON products(name);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_stock_movements_product ON stock_movements(product_id);');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_daily_work_date ON daily_work_logs(log_date);');
  }

  Future<void> _seedDefaultData() async {
    // 1. Seed Business Settings default row
    await into(businessSettings).insert(
      BusinessSettingsCompanion.insert(
        shopName: const Value('Pratap Electricals & Motor Rewinding (प्रताप इलेक्ट्रिकल्स)'),
        ownerName: const Value('Dinesh Jadhav (दिनेश जाधव)'),
        shopAddress: const Value('फाकटे, तालुका शिरूर, जिल्हा पुणे'),
        mobileNumber: const Value('9623314436'),
        invoicePrefix: const Value('INV-'),
        jobPrefix: const Value('JOB-'),
        defaultTaxRate: const Value(0.0),
        isGstEnabled: const Value(false),
        currency: const Value('₹'),
        defaultLanguage: const Value('mr_en'),
        pdfFooter: const Value(
            'आमच्याकडे सर्व प्रकारच्या मोटार पंप रिपेअरिंग, रिवाइंडिंग व नवीन विक्री केली जाते. धन्यवाद!'),
        warrantyTerms: const Value(
            'रिवाइंडिंग कामाची १ महिन्याची हमी. पाण्याचा संपर्क, ओव्हरलोड किंवा फेज फॉल्टमुळे जळाल्यास गॅरंटी लागू नाही.'),
        paymentInstructions: const Value('रोख रक्कम किंवा UPI द्वारे पेमेंट स्वीकारा.'),
        autoBackupEnabled: const Value(true),
        backupScheduleTime: const Value('22:00'),
        backupRetentionCount: const Value(7),
      ),
    );

    // 2. Seed Default Product Categories
    final defaultCategories = [
      'Motor Pump (मोटर पंप)',
      'Copper Wire (कॉपर वायर)',
      'Bearing (बेअरिंग)',
      'Capacitor (कॅपॅसिटर)',
      'Mechanical Seal (मेकॅनिकल सील)',
      'Impeller (इम्पेलर)',
      'Starter & Panel (स्टार्टर व पॅनेल)',
      'Submersible Cable (केबल)',
      'Spare Parts (इतर स्पेअर पार्ट्स)',
    ];

    for (final catName in defaultCategories) {
      await into(productCategories).insert(
        ProductCategoriesCompanion.insert(
          name: catName,
          description: Value('Category for $catName'),
        ),
      );
    }
  }
}

