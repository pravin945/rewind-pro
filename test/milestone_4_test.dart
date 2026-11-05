import 'dart:typed_data';
import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motorshop_manager/core/database/app_database.dart';
import 'package:motorshop_manager/core/database/daos/customer_dao.dart';
import 'package:motorshop_manager/core/database/daos/invoice_dao.dart';
import 'package:motorshop_manager/core/database/daos/payment_dao.dart';
import 'package:motorshop_manager/core/database/daos/product_dao.dart';
import 'package:motorshop_manager/core/database/daos/repair_job_dao.dart';
import 'package:motorshop_manager/core/database/daos/settings_dao.dart';
import 'package:motorshop_manager/core/services/pdf_invoice_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late CustomerDao customerDao;
  late RepairJobDao repairJobDao;
  late ProductDao productDao;
  late InvoiceDao invoiceDao;
  late PaymentDao paymentDao;
  late SettingsDao settingsDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customerDao = CustomerDao(db);
    repairJobDao = RepairJobDao(db);
    productDao = ProductDao(db);
    invoiceDao = InvoiceDao(db);
    paymentDao = PaymentDao(db);
    settingsDao = SettingsDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Milestone 4: Billing, PDF Invoices & Payment Management', () {
    test('Sequential unique invoice number generation', () async {
      final invNum1 = await invoiceDao.generateNextInvoiceNumber();
      expect(invNum1, contains('INV-'));

      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'अनिल पवार', mobile: '9822112233'),
      );

      await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNum1,
          category: 'repair',
          customerId: drift.Value(custId),
          subtotal: const drift.Value(1500),
          grandTotal: const drift.Value(1500),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: '1 HP रिवाइंडिंग',
            quantity: const drift.Value(1),
            unitPrice: const drift.Value(1500),
            amount: const drift.Value(1500),
          ),
        ],
      );

      final invNum2 = await invoiceDao.generateNextInvoiceNumber();
      expect(invNum2, isNot(equals(invNum1)));
      expect(invNum2, contains('-0002'));
    });

    test('Motor repair bill generation links to job and prevents duplicate bill', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'सचिन पाटील', mobile: '9922334455'),
      );

      final jobId = await repairJobDao.insertJob(
        job: RepairJobsCompanion.insert(
          jobNumber: 'JOB-2026-0001',
          customerId: custId,
          motorType: 'Submersible Pump (पाणबुडी)',
          motorBrand: 'CRI',
          motorHp: '3 HP',
          motorPhase: 'Three Phase (३ फेज)',
          problemDescription: 'मोटर जळाली आहे (Motor burnt)',
          labourCharges: const drift.Value(1200),
          finalAmount: const drift.Value(1200),
        ),
      );

      final invNum = await invoiceDao.generateNextInvoiceNumber();

      final invId = await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNum,
          category: 'repair',
          customerId: drift.Value(custId),
          repairJobId: drift.Value(jobId),
          subtotal: const drift.Value(1200),
          grandTotal: const drift.Value(1200),
          paidAmount: const drift.Value(500),
          pendingAmount: const drift.Value(700),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'सबमर्सिबल पंप रिवाइंडिंग मजुरी',
            quantity: const drift.Value(1),
            unitPrice: const drift.Value(1200),
            amount: const drift.Value(1200),
          ),
        ],
        initialPayment: 500,
        paymentMode: 'cash',
      );

      expect(invId, greaterThan(0));

      // Check invoice retrieval
      final invoice = await invoiceDao.getInvoiceById(invId);
      expect(invoice, isNotNull);
      expect(invoice!.repairJobId, equals(jobId));
      expect(invoice.grandTotal, equals(1200));
      expect(invoice.paidAmount, equals(500));
      expect(invoice.pendingAmount, equals(700));

      // Attempting to create duplicate bill for same repair job throws Exception
      expect(
        () => invoiceDao.createInvoice(
          invoice: InvoicesCompanion.insert(
            invoiceNumber: 'INV-2026-9999',
            category: 'repair',
            customerId: drift.Value(custId),
            repairJobId: drift.Value(jobId),
            subtotal: const drift.Value(1200),
            grandTotal: const drift.Value(1200),
          ),
          items: [],
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Spare parts & motor sales bill reduces inventory stock automatically', () async {
      // 1. Create a product in inventory with 10 units stock
      final prodId = await productDao.insertProduct(
        ProductsCompanion.insert(
          name: 'Bearing 6204',
          brand: const drift.Value('SKF'),
          sellingPrice: const drift.Value(180.0),
          currentStock: const drift.Value(10),
          minimumStockLevel: const drift.Value(2),
        ),
      );

      // 2. Create bill selling 3 units
      final invNum = await invoiceDao.generateNextInvoiceNumber();
      await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNum,
          category: 'parts_sales',
          subtotal: const drift.Value(540),
          grandTotal: const drift.Value(540),
          paidAmount: const drift.Value(540),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            productId: drift.Value(prodId),
            description: 'Bearing 6204 (SKF)',
            quantity: const drift.Value(3),
            unitPrice: const drift.Value(180),
            amount: const drift.Value(540),
          ),
        ],
        initialPayment: 540,
      );

      // 3. Verify stock reduced from 10 to 7
      final updatedProd = await productDao.getProductById(prodId);
      expect(updatedProd!.currentStock, equals(7.0));

      // 4. Verify stock movement was recorded as 'sale'
      final movements = await productDao.getStockMovements(prodId);
      expect(movements.any((m) => m.movementType == 'sale' && m.quantity == 3.0), isTrue);
    });

    test('Multiple installment payments correctly recalculate outstanding invoice balance', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'राहुल शिंदे', mobile: '9890112233'),
      );

      final invNum = await invoiceDao.generateNextInvoiceNumber();
      final invId = await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNum,
          category: 'motor_sales',
          customerId: drift.Value(custId),
          subtotal: const drift.Value(10000),
          grandTotal: const drift.Value(10000),
          paidAmount: const drift.Value(4000),
          pendingAmount: const drift.Value(6000),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'Kirloskar 2 HP Monoblock Pump',
            quantity: const drift.Value(1),
            unitPrice: const drift.Value(10000),
            amount: const drift.Value(10000),
          ),
        ],
        initialPayment: 4000,
        paymentMode: 'cash',
      );

      // Customer still owes 6000
      var inv = await invoiceDao.getInvoiceById(invId);
      expect(inv!.pendingAmount, equals(6000));
      expect(inv.paidAmount, equals(4000));

      // Pay installment 1: 3500 via UPI
      await paymentDao.recordPayment(
        PaymentsCompanion.insert(
          customerId: custId,
          invoiceId: drift.Value(invId),
          amountReceived: 3500,
          paymentMode: const drift.Value('upi'),
          transactionReference: const drift.Value('UPI-123456'),
        ),
      );

      inv = await invoiceDao.getInvoiceById(invId);
      expect(inv!.paidAmount, equals(7500));
      expect(inv.pendingAmount, equals(2500));

      // Pay installment 2: 2500 via Cash (Fully paid)
      await paymentDao.recordPayment(
        PaymentsCompanion.insert(
          customerId: custId,
          invoiceId: drift.Value(invId),
          amountReceived: 2500,
          paymentMode: const drift.Value('cash'),
        ),
      );

      inv = await invoiceDao.getInvoiceById(invId);
      expect(inv!.paidAmount, equals(10000));
      expect(inv.pendingAmount, equals(0));

      // Verify pending list shows 0 remaining for Rahul
      final pendingList = await paymentDao.getPendingPaymentsList();
      expect(pendingList.any((p) => p.customer.id == custId), isFalse);
    });

    test('Customer ledger accurately computes running balance for invoices and payments', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(name: 'विकास देशमुख', mobile: '9765432100'),
      );

      final t0 = DateTime.now().subtract(const Duration(minutes: 10));
      final t1 = DateTime.now().subtract(const Duration(minutes: 5));
      final t2 = DateTime.now();

      // Bill 1: 2000
      await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: 'INV-2026-0001',
          category: 'repair',
          customerId: drift.Value(custId),
          invoiceDate: drift.Value(t0),
          subtotal: const drift.Value(2000),
          grandTotal: const drift.Value(2000),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'Motor Repair',
            quantity: const drift.Value(1),
            unitPrice: const drift.Value(2000),
            amount: const drift.Value(2000),
          ),
        ],
      );

      // Payment 1: 1500
      await paymentDao.recordPayment(
        PaymentsCompanion.insert(
          customerId: custId,
          paymentDate: drift.Value(t1),
          amountReceived: 1500,
          paymentMode: const drift.Value('cash'),
        ),
      );

      // Bill 2: 1000
      await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: 'INV-2026-0002',
          category: 'parts_sales',
          customerId: drift.Value(custId),
          invoiceDate: drift.Value(t2),
          subtotal: const drift.Value(1000),
          grandTotal: const drift.Value(1000),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'Capacitor 50mfd',
            quantity: const drift.Value(1),
            unitPrice: const drift.Value(1000),
            amount: const drift.Value(1000),
          ),
        ],
      );

      final ledger = await paymentDao.getCustomerLedger(custId);
      expect(ledger.length, equals(3));

      // Running balance after Bill 1: 2000
      expect(ledger[0].runningBalance, equals(2000));
      // Running balance after Payment: 2000 - 1500 = 500
      expect(ledger[1].runningBalance, equals(500));
      // Running balance after Bill 2: 500 + 1000 = 1500
      expect(ledger[2].runningBalance, equals(1500));
    });

    test('Invoice soft cancellation restores stock and prevents invoice number reuse', () async {
      // 1. Create product with initial stock 5
      final prodId = await productDao.insertProduct(
        ProductsCompanion.insert(
          name: 'Starter 5 HP',
          sellingPrice: const drift.Value(1200.0),
          currentStock: const drift.Value(5),
          minimumStockLevel: const drift.Value(1),
        ),
      );

      // 2. Sell 2 units in invoice INV-2026-0001
      final invNum = await invoiceDao.generateNextInvoiceNumber();
      final invId = await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: invNum,
          category: 'parts_sales',
          subtotal: const drift.Value(2400),
          grandTotal: const drift.Value(2400),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            productId: drift.Value(prodId),
            description: 'Starter 5 HP',
            quantity: const drift.Value(2),
            unitPrice: const drift.Value(1200),
            amount: const drift.Value(2400),
          ),
        ],
      );

      // Stock should now be 3
      var prod = await productDao.getProductById(prodId);
      expect(prod!.currentStock, equals(3.0));

      // 3. Cancel the invoice
      await invoiceDao.cancelInvoice(invId, 'ग्राहक परत गेला / साहित्य रद्द');

      // 4. Verify invoice is soft-cancelled
      final cancelledInv = await invoiceDao.getInvoiceById(invId);
      expect(cancelledInv!.isCancelled, isTrue);
      expect(cancelledInv.cancellationReason, contains('साहित्य रद्द'));

      // 5. Verify stock was restored from 3 back to 5
      prod = await productDao.getProductById(prodId);
      expect(prod!.currentStock, equals(5.0));

      // 6. Next generated invoice number must be INV-2026-0002, NOT reusing 0001!
      final nextInvNum = await invoiceDao.generateNextInvoiceNumber();
      expect(nextInvNum, isNot(equals(invNum)));
      expect(nextInvNum, contains('-0002'));
    });

    test('PDF Invoice service generates valid non-empty byte buffer without errors', () async {
      final custId = await customerDao.insertCustomer(
        CustomersCompanion.insert(
          name: 'दिनेश जाधव',
          mobile: '9623314436',
          villageCity: const drift.Value('सातारा'),
        ),
      );

      final invId = await invoiceDao.createInvoice(
        invoice: InvoicesCompanion.insert(
          invoiceNumber: 'INV-2026-0001',
          category: 'repair',
          customerId: drift.Value(custId),
          subtotal: const drift.Value(2500),
          discount: const drift.Value(200),
          taxAmount: const drift.Value(0),
          grandTotal: const drift.Value(2300),
          paidAmount: const drift.Value(2000),
          pendingAmount: const drift.Value(300),
          paymentMode: const drift.Value('upi'),
        ),
        items: [
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: '5 HP Submersible Rewinding (Copper Wire)',
            quantity: const drift.Value(1),
            unitPrice: const drift.Value(2200),
            amount: const drift.Value(2200),
          ),
          InvoiceItemsCompanion.insert(
            invoiceId: 0,
            description: 'Bushing 5 HP',
            quantity: const drift.Value(1),
            unitPrice: const drift.Value(300),
            amount: const drift.Value(300),
          ),
        ],
        initialPayment: 2000,
        paymentMode: 'upi',
      );

      final details = await invoiceDao.getInvoiceDetails(invId);
      expect(details, isNotNull);

      final settings = await settingsDao.getSettings();

      final pdfBytes = await PdfInvoiceService.generateInvoicePdf(details!, settings);
      expect(pdfBytes, isNotNull);
      expect(pdfBytes, isA<Uint8List>());
      expect(pdfBytes.length, greaterThan(100)); // Non-empty valid PDF byte stream
    });
  });
}
