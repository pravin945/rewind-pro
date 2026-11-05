import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motorshop_manager/core/database/app_database.dart';
import 'package:motorshop_manager/core/database/daos/customer_dao.dart';
import 'package:motorshop_manager/core/database/daos/repair_job_dao.dart';
import 'package:motorshop_manager/core/database/daos/invoice_dao.dart';
import 'package:motorshop_manager/core/database/daos/payment_dao.dart';
import 'package:motorshop_manager/core/database/daos/product_dao.dart';
import 'package:motorshop_manager/core/database/daos/daily_work_dao.dart';
import 'package:motorshop_manager/core/database/daos/settings_dao.dart';
import 'package:motorshop_manager/core/database/daos/report_dao.dart';

void main() {
  late AppDatabase db;
  late CustomerDao customerDao;
  late RepairJobDao jobDao;
  late InvoiceDao invoiceDao;
  late PaymentDao paymentDao;
  late ProductDao productDao;
  late DailyWorkDao dailyWorkDao;
  late SettingsDao settingsDao;
  late ReportDao reportDao;

  setUp(() {
    // In-memory isolated database for pure, fast testing
    db = AppDatabase(NativeDatabase.memory());
    customerDao = CustomerDao(db);
    jobDao = RepairJobDao(db);
    invoiceDao = InvoiceDao(db);
    paymentDao = PaymentDao(db);
    productDao = ProductDao(db);
    dailyWorkDao = DailyWorkDao(db);
    settingsDao = SettingsDao(db);
    reportDao = ReportDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Milestone 1: Database Setup & Seeding', () {
    test('Default Business Settings and Categories are seeded on database creation', () async {
      final settings = await settingsDao.getSettings();
      expect(settings.shopName, contains('प्रताप'));
      expect(settings.currency, equals('₹'));
      expect(settings.invoicePrefix, equals('INV-'));
      expect(settings.jobPrefix, equals('JOB-'));

      final categories = await productDao.getAllCategories();
      expect(categories.length, greaterThanOrEqualTo(8));
      expect(categories.any((c) => c.name.contains('Motor Pump')), isTrue);
      expect(categories.any((c) => c.name.contains('Copper Wire')), isTrue);
    });
  });

  group('Customer Management', () {
    test('Add customer and verify fields', () async {
      final id = await customerDao.insertCustomer(
        CustomersCompanion.insert(
          name: 'रमेश पाटील',
          mobile: '9623314436',
          villageCity: const drift.Value('बारामती'),
          address: const drift.Value('स्टेशन रोड'),
        ),
      );
      expect(id, isPositive);

      final customer = await customerDao.getCustomerById(id);
      expect(customer, isNotNull);
      expect(customer!.name, equals('रमेश पाटील'));
      expect(customer.mobile, equals('9623314436'));
      expect(customer.villageCity, equals('बारामती'));
      expect(customer.isDeleted, isFalse);
    });

    test('Duplicate mobile check identifies existing number', () async {
      await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'गणेश शिंदे', mobile: '9988776655'),
      );

      final exists = await customerDao.checkMobileExists('9988776655');
      expect(exists, isTrue);

      final nonExistent = await customerDao.checkMobileExists('9000000000');
      expect(nonExistent, isFalse);
    });

    test('Customer soft deletion preserves data integrity for financial records', () async {
      final id = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'सुरेश जाधव', mobile: '9123456780'),
      );

      await customerDao.softDeleteCustomer(id);

      final activeCustomers = await customerDao.getAllCustomers(includeDeleted: false);
      expect(activeCustomers.any((c) => c.id == id), isFalse);

      final allCustomers = await customerDao.getAllCustomers(includeDeleted: true);
      final deletedCust = allCustomers.firstWhere((c) => c.id == id);
      expect(deletedCust.isDeleted, isTrue);
    });
  });

  group('Repair Job Management', () {
    test('Job Number is generated sequentially and uniquely', () async {
      final nextNumber1 = await jobDao.generateNextJobNumber();
      expect(nextNumber1, contains('JOB-'));

      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'सचिन कदम', mobile: '9811122233'),
      );

      await jobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: nextNumber1,
          customerId: custId,
          motorType: 'सबमर्सिबल',
          motorBrand: 'किर्लोस्कर',
          motorHp: '5 HP',
          motorPhase: 'थ्री फेज',
          problemDescription: 'मोटर जळाली आहे',
          finalAmount: const drift.Value(4500.0),
        ),
      );

      final nextNumber2 = await jobDao.generateNextJobNumber();
      expect(nextNumber2, isNot(equals(nextNumber1)));
    });

    test('Status updates maintain full audit history in JobStatusHistories', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'विकास मोरे', mobile: '9822233344'),
      );
      final jobNum = await jobDao.generateNextJobNumber();

      final jobId = await jobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: jobNum,
          customerId: custId,
          motorType: 'मोनोब्लॉक',
          motorBrand: 'टेक्समो',
          motorHp: '1 HP',
          motorPhase: 'सिंगल फेज',
          problemDescription: 'बेअरिंग आवाज',
        ),
      );

      await jobDao.updateJobStatus(jobId, 'inProgress', notes: 'वाइंडिंग सुरू');
      await jobDao.updateJobStatus(jobId, 'completed', notes: 'फिटिंग व टेस्टिंग पूर्ण');

      final details = await jobDao.getJobDetails(jobId);
      expect(details, isNotNull);
      expect(details!.job.jobStatus, equals('completed'));
      expect(details.statusHistory.length, equals(3)); // received, inProgress, completed
    });
  });

  group('Inventory and Stock Movements', () {
    test('Product stock is reduced upon usage in repair job and movement logged', () async {
      // 1. Create a product with initial stock = 10
      final prodId = await productDao.insertProduct(
        ProductsCompanion.insert(
          name: 'Bearing 6204',
          currentStock: const drift.Value(10.0),
          purchasePrice: const drift.Value(120.0),
          sellingPrice: const drift.Value(180.0),
        ),
      );

      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'विजय पवार', mobile: '9833344455'),
      );
      final jobNum = await jobDao.generateNextJobNumber();

      // 2. Use 2 bearings in repair job
      await jobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: jobNum,
          customerId: custId,
          motorType: 'सबमर्सिबल',
          motorBrand: 'क्रॉम्प्टन',
          motorHp: '3 HP',
          motorPhase: 'थ्री फेज',
          problemDescription: 'आवाज व जाम',
        ),
        parts: [
          RepairJobPartsCompanion.insert(
            repairJobId: 0,
            productId: drift.Value(prodId),
            partName: 'Bearing 6204',
            quantity: const drift.Value(2.0),
            unitPrice: const drift.Value(180.0),
            totalPrice: const drift.Value(360.0),
          ),
        ],
      );

      // 3. Verify product stock reduced from 10 to 8
      final updatedProd = await productDao.getProductById(prodId);
      expect(updatedProd!.currentStock, equals(8.0));

      final movements = await productDao.getStockMovements(prodId);
      expect(movements.any((m) => m.movementType == 'repair_use'), isTrue);
    });

    test('Negative stock is prevented when allowNegative is false', () async {
      final prodId = await productDao.insertProduct(
        ProductsCompanion.insert(
          name: 'Capacitor 50 MFD',
          currentStock: const drift.Value(2.0),
          sellingPrice: const drift.Value(250.0),
        ),
      );

      expect(
        () => productDao.adjustStock(
          productId: prodId,
          quantityDelta: -5.0, // Trying to deduct 5 when only 2 exist
          movementType: 'sale',
          allowNegative: false,
        ),
        throwsException,
      );
    });
  });

  group('Billing, Multiple Payments & Outstanding Balance Derivation', () {
    test('Sequential invoice numbers, multiple payments and balance derivation', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'अशोक चव्हाण', mobile: '9844455566'),
      );

      final invNum = await invoiceDao.generateNextInvoiceNumber();
      expect(invNum, contains('INV-'));

      // Create an invoice of ₹10,000 with initial advance of ₹3,000
      final invId = await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNum,
          category: 'repair',
          customerId: drift.Value(custId),
          subtotal: const drift.Value(10000.0),
          grandTotal: const drift.Value(10000.0),
          paidAmount: const drift.Value(3000.0),
          pendingAmount: const drift.Value(7000.0),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'मोटर पूर्ण रिवाइंडिंग काम',
            quantity: const drift.Value(1.0),
            unitPrice: const drift.Value(10000.0),
            amount: const drift.Value(10000.0),
          ),
        ],
        initialPayment: 3000.0,
      );

      // Check first stage: ₹10,000 bill, ₹3,000 paid, ₹7,000 pending
      var summary = await customerDao.getCustomerFinancialSummary(custId);
      expect(summary.totalBilled, equals(10000.0));
      expect(summary.totalPaid, equals(3000.0));
      expect(summary.outstandingBalance, equals(7000.0));

      // Second payment of ₹2,000
      await paymentDao.recordPayment(
        PaymentsCompanion.insert(
          customerId: custId,
          invoiceId: drift.Value(invId),
          amountReceived: 2000.0,
          paymentMode: const drift.Value('upi'),
        ),
      );

      summary = await customerDao.getCustomerFinancialSummary(custId);
      expect(summary.totalPaid, equals(5000.0));
      expect(summary.outstandingBalance, equals(5000.0));

      // Third payment of ₹5,000 (completing bill)
      await paymentDao.recordPayment(
        PaymentsCompanion.insert(
          customerId: custId,
          invoiceId: drift.Value(invId),
          amountReceived: 5000.0,
          paymentMode: const drift.Value('cash'),
        ),
      );

      summary = await customerDao.getCustomerFinancialSummary(custId);
      expect(summary.totalPaid, equals(10000.0));
      expect(summary.outstandingBalance, equals(0.0));

      // Check Customer Ledger shows all events with correct running balances
      final ledger = await paymentDao.getCustomerLedger(custId);
      expect(ledger.length, equals(4)); // 1 invoice + 3 payments
      expect(ledger.last.runningBalance, equals(0.0));
    });

    test('Invoice soft cancellation restores inventory and updates balance', () async {
      // Product with 5 in stock
      final prodId = await productDao.insertProduct(
        ProductsCompanion.insert(
          name: 'Openwell Pump 3HP',
          currentStock: const drift.Value(5.0),
          sellingPrice: const drift.Value(15000.0),
        ),
      );

      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'दिलीप सावंत', mobile: '9855566677'),
      );
      final invNum = await invoiceDao.generateNextInvoiceNumber();

      // Sell 1 pump
      final invId = await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNum,
          category: 'motor_sales',
          customerId: drift.Value(custId),
          subtotal: const drift.Value(15000.0),
          grandTotal: const drift.Value(15000.0),
          paidAmount: const drift.Value(0.0),
          pendingAmount: const drift.Value(15000.0),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            productId: drift.Value(prodId),
            description: 'Openwell Pump 3HP',
            quantity: const drift.Value(1.0),
            unitPrice: const drift.Value(15000.0),
            amount: const drift.Value(15000.0),
          ),
        ],
      );

      var prod = await productDao.getProductById(prodId);
      expect(prod!.currentStock, equals(4.0)); // reduced

      // Now cancel invoice
      await invoiceDao.cancelInvoice(invId, 'ग्राहक ऑर्डर रद्द केली');

      prod = await productDao.getProductById(prodId);
      expect(prod!.currentStock, equals(5.0)); // restored

      final summary = await customerDao.getCustomerFinancialSummary(custId);
      expect(summary.totalBilled, equals(0.0)); // cancelled bills not counted in active balance
    });
  });

  group('Reports & Dashboard Aggregates', () {
    test('Dashboard summary computes real values across database transactions', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'सुभाष गायकवाड', mobile: '9866677788'),
      );

      final invNum = await invoiceDao.generateNextInvoiceNumber();
      await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNum,
          category: 'repair',
          customerId: drift.Value(custId),
          subtotal: const drift.Value(3000.0),
          grandTotal: const drift.Value(3000.0),
          paidAmount: const drift.Value(1000.0),
          pendingAmount: const drift.Value(2000.0),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'रिपेअरिंग',
            quantity: const drift.Value(1.0),
            unitPrice: const drift.Value(3000.0),
            amount: const drift.Value(3000.0),
          ),
        ],
        initialPayment: 1000.0,
      );

      final summary = await reportDao.getDashboardSummary();
      expect(summary.totalIncome, equals(3000.0));
      expect(summary.receivedPayment, equals(1000.0));
      expect(summary.pendingPayment, equals(2000.0));
    });

    test('Daily work logs creation, retrieval and deletion', () async {
      final now = DateTime.now();
      final logId = await dailyWorkDao.insertLog(
        DailyWorkLogsCompanion.insert(
          logDate: drift.Value(now),
          customerName: const drift.Value('प्रमोद पाटील'),
          workPerformed: 'स्टार्टर रिले बदलणे',
          labourCharges: const drift.Value(300.0),
          paymentReceived: const drift.Value(300.0),
        ),
      );
      expect(logId, isPositive);

      final logs = await dailyWorkDao.getLogsForDateRange(now, now);
      expect(logs.any((l) => l.id == logId), isTrue);

      await dailyWorkDao.deleteLog(logId);
      final afterDelete = await dailyWorkDao.getLogsForDateRange(now, now);
      expect(afterDelete.any((l) => l.id == logId), isFalse);
    });
  });
}

