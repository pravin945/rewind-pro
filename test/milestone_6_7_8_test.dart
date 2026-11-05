import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:motorshop_manager/core/database/app_database.dart';
import 'package:motorshop_manager/core/database/daos/customer_dao.dart';
import 'package:motorshop_manager/core/database/daos/expense_dao.dart';
import 'package:motorshop_manager/core/database/daos/invoice_dao.dart';
import 'package:motorshop_manager/core/database/daos/report_dao.dart';
import 'package:motorshop_manager/core/database/daos/settings_dao.dart';
import 'package:motorshop_manager/core/services/backup_service.dart';
import 'package:motorshop_manager/core/services/pdf_invoice_service.dart';
import 'package:motorshop_manager/core/utils/customer_action_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late CustomerDao customerDao;
  late InvoiceDao invoiceDao;
  late ExpenseDao expenseDao;
  late ReportDao reportDao;
  late SettingsDao settingsDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customerDao = CustomerDao(db);
    invoiceDao = InvoiceDao(db);
    expenseDao = ExpenseDao(db);
    reportDao = ReportDao(db);
    settingsDao = SettingsDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Milestone 6: SMS & WhatsApp Customer Communication', () {
    test('Phone number cleaning extracts clean digits with country code', () {
      expect(CustomerActionHelper.cleanPhoneNumber('96233 14436'), '9623314436');
      expect(CustomerActionHelper.cleanPhoneNumber('+91 96233-14436'), '+919623314436');
      expect(CustomerActionHelper.cleanPhoneNumber(' (020) 123-456 '), '020123456');
    });

    test('Customer Ledger WhatsApp statement formats complete Marathi summary', () {
      final entries = [
        CustomerLedgerEntry(
          date: DateTime(2026, 3, 1),
          type: 'debit',
          title: 'INV-2026-0001',
          subtitle: 'बिल (मोटर रिपेअर)',
          debit: 3500.0,
          credit: 0.0,
          runningBalance: 3500.0,
        ),
        CustomerLedgerEntry(
          date: DateTime(2026, 3, 2),
          type: 'credit',
          title: 'पेमेंट (CASH)',
          subtitle: 'जमा पेमेंट',
          debit: 0.0,
          credit: 2000.0,
          runningBalance: 1500.0,
        ),
      ];

      final text = CustomerActionHelper.generateLedgerStatementText(
        customerName: 'रमेश पाटील',
        rawPhone: '9876543210',
        entries: entries,
        totalBilled: 3500.0,
        totalPaid: 2000.0,
        outstandingBalance: 1500.0,
        shopName: 'Pratap Electricals & Motor Rewinding',
        ownerName: 'Dinesh Jadhav',
        ownerPhone: '9623314436',
      );

      expect(text.contains('Pratap Electricals'), isTrue);
      expect(text.contains('रमेश पाटील'), isTrue);
      expect(text.contains('INV-2026-0001'), isTrue);
      expect(text.contains('Dinesh Jadhav'), isTrue);
      expect(text.contains('9623314436'), isTrue);
      expect(text.contains('3,500'), isTrue);
      expect(text.contains('2,000'), isTrue);
      expect(text.contains('1,500'), isTrue);
    });
  });

  group('Milestone 7: Reports & Profit-Loss Analytics', () {
    test('ReportDao computes repair income, expenses, and net profit correctly', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'संजय शिंदे', mobile: '9123456789'),
      );

      final now = DateTime.now();

      // Create a repair invoice of 4500
      await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: 'INV-2026-0001',
          invoiceDate: drift.Value(now),
          category: 'repair',
          customerId: drift.Value(custId),
          subtotal: const drift.Value(4500.0),
          grandTotal: const drift.Value(4500.0),
          paidAmount: const drift.Value(4500.0),
          pendingAmount: const drift.Value(0.0),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: '5 HP मोटर रिवाइंडिंग व बेअरिंग बदलणे',
            quantity: const drift.Value(1),
            unitPrice: const drift.Value(4500.0),
            amount: const drift.Value(4500.0),
          ),
        ],
        initialPayment: 4500.0,
        paymentMode: 'cash',
      );

      // Create shop expenses: copper wire (1200) and varnish (300) = 1500
      await expenseDao.insertExpense(
        ExpensesCompanion.insert(
          category: 'copper_wire',
          amount: 1200.0,
          notes: const drift.Value('कॉपर वायर खरेदी (Copper Wire)'),
          expenseDate: drift.Value(now),
        ),
      );
      await expenseDao.insertExpense(
        ExpensesCompanion.insert(
          category: 'varnish',
          amount: 300.0,
          notes: const drift.Value('वॉर्निश (Varnish)'),
          expenseDate: drift.Value(now),
        ),
      );

      final startDate = DateTime(now.year, now.month, 1);
      final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

      final breakdown = await reportDao.getCategoryIncomeBreakdown(startDate, endDate);

      expect(breakdown.repairIncome, equals(4500.0));
      expect(breakdown.totalExpenses, equals(1500.0));
      // Net Profit = 4500 - 1500 = 3000
      expect(breakdown.netProfit, equals(3000.0));
    });

    test('PdfInvoiceService generates valid business report PDF bytes', () async {
      final now = DateTime.now();
      final settings = await settingsDao.getSettings();

      final bytes = await PdfInvoiceService.generateReportPdf(
        startDate: DateTime(now.year, now.month, 1),
        endDate: now,
        grossIncome: 4500.0,
        totalExpenses: 1500.0,
        netProfit: 3000.0,
        totalPendingReceivables: 500.0,
        settings: settings,
      );

      expect(bytes, isNotEmpty);
      expect(bytes.length, greaterThan(1000));
    });
  });

  group('Milestone 8: Backup & Restore Service', () {
    test('isValidSqliteFile verifies SQLite format header accurately', () async {
      final tempDir = await Directory.systemTemp.createTemp('motorshop_backup_test');
      final validFile = File('${tempDir.path}/valid.sqlite');
      final invalidFile = File('${tempDir.path}/invalid.txt');

      // SQLite 3 file starts with "SQLite format 3\000" (16 bytes)
      final header = 'SQLite format 3\x00'.codeUnits;
      await validFile.writeAsBytes(header + List.filled(500, 0));
      await invalidFile.writeAsString('This is not a SQLite database file');

      expect(BackupService.isValidSqliteFile(validFile), isTrue);
      expect(BackupService.isValidSqliteFile(invalidFile), isFalse);

      await tempDir.delete(recursive: true);
    });

    test('SettingsDao records backup history and updates last backup timestamp', () async {
      final now = DateTime.now();
      await settingsDao.recordBackupHistory(
        BackupHistoriesCompanion.insert(
          fileName: 'motorshop_backup_test.db',
          fileSize: 102400,
          status: 'success',
          backupType: const drift.Value('local'),
          backupDate: drift.Value(now),
        ),
      );

      await settingsDao.updateBackupTimestamp(now, 'success');

      final histories = await settingsDao.getBackupHistories();
      expect(histories.length, equals(1));
      expect(histories.first.fileName, equals('motorshop_backup_test.db'));
      expect(histories.first.status, equals('success'));

      final settings = await settingsDao.getSettings();
      expect(settings.lastBackupStatus, equals('success'));
      expect(settings.lastBackupTimestamp, isNotNull);
    });
  });
}
