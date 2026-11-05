import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motorshop_manager/core/database/app_database.dart';
import 'package:motorshop_manager/core/database/daos/customer_dao.dart';
import 'package:motorshop_manager/core/database/daos/daily_work_dao.dart';
import 'package:motorshop_manager/core/database/daos/invoice_dao.dart';
import 'package:motorshop_manager/core/database/daos/product_dao.dart';
import 'package:motorshop_manager/core/database/daos/repair_job_dao.dart';
import 'package:motorshop_manager/core/providers/database_providers.dart';
import 'package:motorshop_manager/features/daily_work/screens/daily_work_screen.dart';
import 'package:motorshop_manager/features/repair_job/screens/repair_job_details_screen.dart';
import 'package:motorshop_manager/features/repair_job/screens/repair_job_list_screen.dart';

void main() {
  late AppDatabase db;
  late CustomerDao customerDao;
  late RepairJobDao repairJobDao;
  late ProductDao productDao;
  late InvoiceDao invoiceDao;
  late DailyWorkDao dailyWorkDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customerDao = CustomerDao(db);
    repairJobDao = RepairJobDao(db);
    productDao = ProductDao(db);
    invoiceDao = InvoiceDao(db);
    dailyWorkDao = DailyWorkDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Milestone 3: Repair Job Management & Status Progression', () {
    test('Job Number generates sequentially and unique per year', () async {
      final num1 = await repairJobDao.generateNextJobNumber();
      expect(num1, contains('JOB-'));

      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'संजय माने', mobile: '9822334455'),
      );

      await repairJobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: num1,
          customerId: custId,
          motorType: 'सबमर्सिबल',
          motorBrand: 'किर्लोस्कर',
          motorHp: '3 HP',
          motorPhase: 'थ्री फेज',
          problemDescription: 'जळाली आहे',
        ),
      );

      final num2 = await repairJobDao.generateNextJobNumber();
      expect(num2, isNot(equals(num1)));
      expect(num2, contains('JOB-'));
    });

    test('Job Status updates record complete audit trail in job_status_histories', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'संजय माने', mobile: '9822334455'),
      );

      final jobId = await repairJobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: 'JOB-2026-0001',
          customerId: custId,
          motorType: 'मोनोब्लॉक',
          motorBrand: 'क्रॉम्प्टन',
          motorHp: '1 HP',
          motorPhase: 'सिंगल फेज',
          problemDescription: 'आवाज करतो आणि पाणी उचलत नाही',
          labourCharges: const drift.Value(600.0),
          finalAmount: const drift.Value(600.0),
          remainingAmount: const drift.Value(600.0),
        ),
      );

      // Progression: received -> inspection -> inProgress -> completed -> delivered
      await repairJobDao.updateJobStatus(jobId, 'inspection', notes: 'तपासणी सुरू केली, सील खराब आहे');
      await repairJobDao.updateJobStatus(jobId, 'inProgress', notes: 'नवीन मेकॅनिकल सील बसवले');
      await repairJobDao.updateJobStatus(jobId, 'completed', notes: 'मोटर टेस्ट केली, व्यवस्थित चालते');
      await repairJobDao.updateJobStatus(jobId, 'delivered', notes: 'ग्राहकाने मोटर नेली');

      final details = await repairJobDao.getJobDetails(jobId);
      expect(details, isNotNull);
      expect(details!.job.jobStatus, 'delivered');
      expect(details.job.deliveryDate, isNotNull);

      // Verify status histories
      final histories = details.statusHistory;
      expect(histories.length, 5); // 1 initial creation + 4 transitions
      expect(histories.last.toStatus, 'delivered');
      expect(histories.last.fromStatus, 'completed');
    });

    test('Adding and removing spare parts automatically manages stock and recalculates job amount', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'राहुल शिंदे', mobile: '9988776655'),
      );

      // 1. Create a product with stock = 10
      final prodId = await productDao.insertProduct(
        ProductsCompanion.insert(
          name: 'Bearing 6204 SKF',
          sellingPrice: const drift.Value(250.0),
          currentStock: const drift.Value(10.0),
        ),
      );

      // 2. Create job with Labour = ₹500
      final jobId = await repairJobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: 'JOB-2026-0002',
          customerId: custId,
          motorType: 'सबमर्सिबल',
          motorBrand: 'टेक्समो',
          motorHp: '2 HP',
          motorPhase: 'सिंगल फेज',
          problemDescription: 'बेअरिंग आवाज',
          labourCharges: const drift.Value(500.0),
          materialCharges: const drift.Value(0.0),
          finalAmount: const drift.Value(500.0),
          remainingAmount: const drift.Value(500.0),
        ),
      );

      // 3. Add 2 bearings to the job
      await repairJobDao.addJobParts(jobId, [
        RepairJobPartsCompanion.insert(
          repairJobId: jobId,
          productId: drift.Value(prodId),
          partName: 'Bearing 6204 SKF',
          quantity: const drift.Value(2.0),
          unitPrice: const drift.Value(250.0),
          totalPrice: const drift.Value(500.0),
        ),
      ]);

      // Check stock reduced from 10 to 8
      var prod = await productDao.getProductById(prodId);
      expect(prod?.currentStock, 8.0);

      // Check job amount updated: labour (500) + material (500) = 1000
      var job = await repairJobDao.getJobById(jobId);
      expect(job?.materialCharges, 500.0);
      expect(job?.finalAmount, 1000.0);
      expect(job?.remainingAmount, 1000.0);

      // 4. Remove part from the job
      final details = await repairJobDao.getJobDetails(jobId);
      final partId = details!.parts.first.id;
      await repairJobDao.removeJobPart(partId);

      // Stock is restored back to 10
      prod = await productDao.getProductById(prodId);
      expect(prod?.currentStock, 10.0);

      // Job amount is recalculated back to 500
      job = await repairJobDao.getJobById(jobId);
      expect(job?.materialCharges, 0.0);
      expect(job?.finalAmount, 500.0);
      expect(job?.remainingAmount, 500.0);
    });

    test('Duplicate bill detection properly identifies existing bill for repair job', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'विजय पाटील', mobile: '9123412345'),
      );

      final jobId = await repairJobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: 'JOB-2026-0003',
          customerId: custId,
          motorType: 'सबमर्सिबल',
          motorBrand: 'किर्लोस्कर',
          motorHp: '5 HP',
          motorPhase: 'थ्री फेज',
          problemDescription: 'रिवाइंडिंग',
          labourCharges: const drift.Value(3000.0),
          finalAmount: const drift.Value(3000.0),
          remainingAmount: const drift.Value(3000.0),
        ),
      );

      // Initially no bill exists
      var existing = await invoiceDao.getInvoiceForRepairJob(jobId);
      expect(existing, isNull);

      // Generate invoice for this job
      await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: 'INV-JOB-1',
          repairJobId: drift.Value(jobId),
          customerId: drift.Value(custId),
          category: 'repair',
          subtotal: const drift.Value(3000.0),
          grandTotal: const drift.Value(3000.0),
          paidAmount: const drift.Value(0.0),
          pendingAmount: const drift.Value(3000.0),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'Motor Rewinding 5 HP',
            quantity: const drift.Value(1.0),
            unitPrice: const drift.Value(3000.0),
            amount: const drift.Value(3000.0),
          ),
        ],
      );

      // Now query finds the existing bill
      existing = await invoiceDao.getInvoiceForRepairJob(jobId);
      expect(existing, isNotNull);
      expect(existing?.invoiceNumber, 'INV-JOB-1');
    });
  });

  group('Milestone 3: Daily Work Register & Date Filtering', () {
    test('Daily work entries can be added, updated, filtered and deleted', () async {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));

      // 1. Log for today
      final log1 = await dailyWorkDao.insertLog(
        DailyWorkLogsCompanion.insert(
          logDate: drift.Value(today),
          customerName: const drift.Value('दत्तात्रय चव्हाण'),
          motorDetails: const drift.Value('3 HP Submersible'),
          workPerformed: 'पूर्ण कॉपर रिवाइंडिंग',
          labourCharges: const drift.Value(2500.0),
          paymentReceived: const drift.Value(2000.0),
          pendingAmount: const drift.Value(500.0),
        ),
      );

      // 2. Log for yesterday
      await dailyWorkDao.insertLog(
        DailyWorkLogsCompanion.insert(
          logDate: drift.Value(yesterday),
          customerName: const drift.Value('सुरेश थोरात'),
          motorDetails: const drift.Value('1 HP Monoblock'),
          workPerformed: 'बेअरिंग व सील बदलले',
          labourCharges: const drift.Value(600.0),
          paymentReceived: const drift.Value(600.0),
          pendingAmount: const drift.Value(0.0),
        ),
      );

      // Query today's logs
      final todayLogs = await dailyWorkDao.getLogsForDateRange(today, today);
      expect(todayLogs.length, 1);
      expect(todayLogs.first.customerName, 'दत्तात्रय चव्हाण');
      expect(todayLogs.first.labourCharges, 2500.0);

      // Query yesterday's logs
      final yesterdayLogs = await dailyWorkDao.getLogsForDateRange(yesterday, yesterday);
      expect(yesterdayLogs.length, 1);
      expect(yesterdayLogs.first.customerName, 'सुरेश थोरात');

      // Update log
      await dailyWorkDao.updateLog(
        DailyWorkLogsCompanion(
          id: drift.Value(log1),
          paymentReceived: const drift.Value(2500.0),
          pendingAmount: const drift.Value(0.0),
        ),
      );

      final updated = (await dailyWorkDao.getLogsForDateRange(today, today)).first;
      expect(updated.paymentReceived, 2500.0);
      expect(updated.pendingAmount, 0.0);

      // Delete log
      await dailyWorkDao.deleteLog(log1);
      final afterDelete = await dailyWorkDao.getLogsForDateRange(today, today);
      expect(afterDelete.isEmpty, true);
    });
  });

  group('Milestone 3: UI Widget Tests', () {
    testWidgets('RepairJobListScreen displays status filter chips and empty state', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
          ],
          child: const MaterialApp(
            home: RepairJobListScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify filter chips exist
      expect(find.byType(FilterChip), findsWidgets);
      // Verify floating add button exists
      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('RepairJobDetailsScreen displays header, customer, parts and bill button', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'संजय माने', mobile: '9822334455'),
      );

      final jobId = await repairJobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: 'JOB-2026-0001',
          customerId: custId,
          motorType: 'सबमर्सिबल',
          motorBrand: 'किर्लोस्कर',
          motorHp: '5 HP',
          motorPhase: 'थ्री फेज',
          problemDescription: 'कॉइल जळाली आहे',
          labourCharges: const drift.Value(2000.0),
          finalAmount: const drift.Value(2000.0),
          remainingAmount: const drift.Value(2000.0),
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
          ],
          child: MaterialApp(
            home: RepairJobDetailsScreen(jobId: jobId),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Job number in AppBar and header
      expect(find.text('JOB-2026-0001'), findsWidgets);
      // Verify motor details
      expect(find.text('सबमर्सिबल • किर्लोस्कर 5 HP'), findsOneWidget);
      // Verify Customer name
      expect(find.text('संजय माने'), findsOneWidget);
      // Verify Parts Card with "पार्ट जोडा" button
      expect(find.text('पार्ट जोडा'), findsOneWidget);
      // Verify Generate bill button
      expect(find.text('या कामाचे बिल बनवा (Generate Bill)'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('DailyWorkScreen displays date filter bar and add button', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
          ],
          child: const MaterialApp(
            home: DailyWorkScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Date range filter bar exists
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      // Verify Floating action button exists
      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });
  });
}
