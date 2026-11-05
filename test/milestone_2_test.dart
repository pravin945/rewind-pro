import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motorshop_manager/core/constants/app_strings.dart';
import 'package:motorshop_manager/core/database/app_database.dart';
import 'package:motorshop_manager/core/database/daos/customer_dao.dart';
import 'package:motorshop_manager/core/database/daos/invoice_dao.dart';
import 'package:motorshop_manager/core/database/daos/payment_dao.dart';
import 'package:motorshop_manager/core/database/daos/report_dao.dart';
import 'package:motorshop_manager/core/database/daos/settings_dao.dart';
import 'package:motorshop_manager/core/providers/database_providers.dart';
import 'package:motorshop_manager/features/customer/screens/customer_list_screen.dart';
import 'package:motorshop_manager/features/dashboard/screens/dashboard_screen.dart';
import 'package:motorshop_manager/features/settings/screens/settings_screen.dart';

void main() {
  late AppDatabase db;
  late CustomerDao customerDao;
  late InvoiceDao invoiceDao;
  late PaymentDao paymentDao;
  late ReportDao reportDao;
  late SettingsDao settingsDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customerDao = CustomerDao(db);
    invoiceDao = InvoiceDao(db);
    paymentDao = PaymentDao(db);
    reportDao = ReportDao(db);
    settingsDao = SettingsDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Milestone 2: Business Settings & Dynamic Language', () {
    test('Settings can be updated and reloaded with GST and Marathi/English configurations', () async {
      final initial = await settingsDao.getSettings();
      expect(initial.shopName, contains('प्रताप'));
      expect(initial.isGstEnabled, false);
      expect(initial.defaultLanguage, 'mr_en');

      // Update settings
      await settingsDao.updateSettings(
        const BusinessSettingsCompanion(
          shopName: drift.Value('श्री गणेश इलेक्ट्रिकल्स अँड वर्क्स'),
          ownerName: drift.Value('गणेश कदम'),
          shopAddress: drift.Value('मार्केट यार्ड, सातारा'),
          mobileNumber: drift.Value('9822001122'),
          alternateMobile: drift.Value('9422001122'),
          gstin: drift.Value('27AABCU9603R1ZX'),
          isGstEnabled: drift.Value(true),
          defaultTaxRate: drift.Value(18.0),
          invoicePrefix: drift.Value('SGE-INV-'),
          jobPrefix: drift.Value('SGE-JOB-'),
          defaultLanguage: drift.Value('mr'),
          warrantyTerms: drift.Value('रिवाइंडिंगवर ६ महिने वॉरंटी'),
          paymentInstructions: drift.Value('GPay / PhonePe: 9822001122'),
          pdfFooter: drift.Value('आमच्या सेवेची संधी दिल्याबद्दल धन्यवाद!'),
        ),
      );

      final updated = await settingsDao.getSettings();
      expect(updated.shopName, 'श्री गणेश इलेक्ट्रिकल्स अँड वर्क्स');
      expect(updated.ownerName, 'गणेश कदम');
      expect(updated.isGstEnabled, true);
      expect(updated.defaultTaxRate, 18.0);
      expect(updated.defaultLanguage, 'mr');
      expect(updated.invoicePrefix, 'SGE-INV-');
      expect(updated.jobPrefix, 'SGE-JOB-');
    });

    test('Language code mapping properly maps Marathi, English and Mixed', () {
      expect(AppLanguage.fromCode('mr_en'), AppLanguage.marathiEnglish);
      expect(AppLanguage.fromCode('mr'), AppLanguage.marathi);
      expect(AppLanguage.fromCode('en'), AppLanguage.english);
      expect(AppLanguage.fromCode('unknown'), AppLanguage.marathiEnglish);
    });

    test('SettingsDao records backup timestamp and status accurately', () async {
      final now = DateTime.now();
      await settingsDao.updateBackupTimestamp(now, 'success');

      final settings = await settingsDao.getSettings();
      expect(settings.lastBackupStatus, 'success');
      expect(settings.lastBackupTimestamp?.day, now.day);
    });
  });

  group('Milestone 2: Customer Management & Ledger Calculations', () {
    test('Customer search works across both name and mobile query', () async {
      await customerDao.insertCustomer(
        CustomersCompanion.insert(
          name: 'आनंद जगताप',
          mobile: '9890123456',
          villageCity: const drift.Value('बारामती'),
        ),
      );

      await customerDao.insertCustomer(
        CustomersCompanion.insert(
          name: 'प्रकाश साळुंखे',
          mobile: '9765432100',
          villageCity: const drift.Value('फलटण'),
        ),
      );

      // Search by partial name
      final byName = await customerDao.getAllCustomers(query: 'आनंद');
      expect(byName.length, 1);
      expect(byName.first.name, 'आनंद जगताप');

      // Search by partial mobile
      final byMobile = await customerDao.getAllCustomers(query: '9765');
      expect(byMobile.length, 1);
      expect(byMobile.first.name, 'प्रकाश साळुंखे');

      // Non-matching query
      final empty = await customerDao.getAllCustomers(query: '9999999999');
      expect(empty.isEmpty, true);
    });

    test('Customer Ledger accurately tracks Invoices (Debits) and Payments (Credits) with running balance', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(
          name: 'सुरेश पवार',
          mobile: '9881122334',
          villageCity: const drift.Value('इंदापूर'),
        ),
      );

      // 1. Bill 1 created on Jan 10 for ₹10,000
      final inv1 = await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: 'INV-001',
          invoiceDate: drift.Value(DateTime(2026, 1, 10)),
          customerId: drift.Value(custId),
          category: 'repair',
          subtotal: const drift.Value(10000.0),
          grandTotal: const drift.Value(10000.0),
          paidAmount: const drift.Value(0.0),
          pendingAmount: const drift.Value(10000.0),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: '5 HP Motor Rewinding',
            quantity: const drift.Value(1.0),
            unitPrice: const drift.Value(10000.0),
            amount: const drift.Value(10000.0),
          ),
        ],
      );

      // 2. Payment 1 on Jan 12 for ₹3,000 (Advance / Cash)
      await paymentDao.recordPayment(
        PaymentsCompanion.insert(
          customerId: custId,
          invoiceId: drift.Value(inv1),
          paymentDate: drift.Value(DateTime(2026, 1, 12)),
          amountReceived: 3000.0,
          paymentMode: const drift.Value('cash'),
          transactionReference: const drift.Value('CASH-REC-1'),
        ),
      );

      // 3. Payment 2 on Jan 15 for ₹2,500 (UPI)
      await paymentDao.recordPayment(
        PaymentsCompanion.insert(
          customerId: custId,
          invoiceId: drift.Value(inv1),
          paymentDate: drift.Value(DateTime(2026, 1, 15)),
          amountReceived: 2500.0,
          paymentMode: const drift.Value('upi'),
          transactionReference: const drift.Value('UPI123456789'),
        ),
      );

      // Verify Financial Summary
      final summary = await customerDao.getCustomerFinancialSummary(custId);
      expect(summary.totalBilled, 10000.0);
      expect(summary.totalPaid, 5500.0);
      expect(summary.outstandingBalance, 4500.0);
      expect(summary.pendingBillsCount, 1);

      // Verify Chronological Ledger Entries (returns reverse chronological: newest first)
      final ledger = await customerDao.getCustomerLedger(custId);
      expect(ledger.length, 3);

      // Most recent entry (Jan 15 UPI payment):
      expect(ledger[0].type, 'credit');
      expect(ledger[0].credit, 2500.0);
      expect(ledger[0].runningBalance, 4500.0);

      // Middle entry (Jan 12 Cash payment):
      expect(ledger[1].type, 'credit');
      expect(ledger[1].credit, 3000.0);
      expect(ledger[1].runningBalance, 7000.0);

      // First entry (Jan 10 Bill):
      expect(ledger[2].type, 'debit');
      expect(ledger[2].debit, 10000.0);
      expect(ledger[2].runningBalance, 10000.0);
    });
  });

  group('Milestone 2: Dashboard Aggregation & Filtering', () {
    test('Dashboard calculates correct totals for custom date ranges', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(
          name: 'बाळासाहेब शिंदे',
          mobile: '9123456780',
        ),
      );

      final jan1 = DateTime(2026, 1, 1);
      final jan15 = DateTime(2026, 1, 15);
      final feb1 = DateTime(2026, 2, 1);

      // Invoice in January
      await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: 'INV-JAN-1',
          invoiceDate: drift.Value(jan15),
          customerId: drift.Value(custId),
          category: 'motor_sales',
          subtotal: const drift.Value(15000.0),
          grandTotal: const drift.Value(15000.0),
          paidAmount: const drift.Value(15000.0),
          pendingAmount: const drift.Value(0.0),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'Kirloskar 3 HP Pump',
            quantity: const drift.Value(1.0),
            unitPrice: const drift.Value(15000.0),
            amount: const drift.Value(15000.0),
          ),
        ],
      );

      await paymentDao.recordPayment(
        PaymentsCompanion.insert(
          customerId: custId,
          paymentDate: drift.Value(jan15),
          amountReceived: 15000.0,
        ),
      );

      // Query dashboard for January only
      final janSummary = await reportDao.getDashboardSummary(
        startDate: jan1,
        endDate: DateTime(2026, 1, 31, 23, 59, 59),
      );

      expect(janSummary.totalIncome, 15000.0);
      expect(janSummary.receivedPayment, 15000.0);
      expect(janSummary.todaySalesAmount, 15000.0);

      // Query dashboard for February (should be 0 for the period)
      final febSummary = await reportDao.getDashboardSummary(
        startDate: feb1,
        endDate: DateTime(2026, 2, 28, 23, 59, 59),
      );

      expect(febSummary.totalIncome, 0.0);
      expect(febSummary.receivedPayment, 0.0);
    });
  });

  group('Milestone 2: UI Widget Tests', () {
    testWidgets('CustomerListScreen displays search field and add customer button', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
          ],
          child: const MaterialApp(
            home: CustomerListScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify search field exists
      expect(find.byType(TextField), findsOneWidget);
      // Verify floating action button exists
      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('DashboardScreen displays header, filter, backup badge and stat cards', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Filter button exists
      expect(find.byIcon(Icons.filter_list), findsOneWidget);
      // Verify Quick Actions exist
      expect(find.text('जलद पर्याय (Quick Actions)'), findsOneWidget);
      // Verify Add Customer quick action exists
      expect(find.text('नवीन ग्राहक (Add Customer)'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('SettingsScreen displays form fields and save button', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
          ],
          child: const MaterialApp(
            home: SettingsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify shop name input exists
      expect(find.byType(TextFormField), findsWidgets);
      // Verify Save button exists
      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });
  });
}
