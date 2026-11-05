import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../database/app_database.dart';
import '../database/daos/invoice_dao.dart';

class PdfInvoiceService {
  /// Generates a professional PDF document for the invoice
  static Future<Uint8List> generateInvoicePdf(
    InvoiceWithDetails details,
    BusinessSetting? settings, {
    PdfPageFormat pageFormat = PdfPageFormat.a4,
  }) async {
    pw.Font regularFont;
    pw.Font boldFont;
    bool isDevanagariSupported = false;

    try {
      regularFont = await PdfGoogleFonts.notoSansDevanagariRegular();
      boldFont = await PdfGoogleFonts.notoSansDevanagariBold();
      isDevanagariSupported = true;
    } catch (_) {
      // Fallback for completely offline environments without cached google fonts
      regularFont = pw.Font.helvetica();
      boldFont = pw.Font.helveticaBold();
      isDevanagariSupported = false;
    }

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(
        base: regularFont,
        bold: boldFont,
      ),
    );

    final inv = details.invoice;
    final customer = details.customer;
    final items = details.items;
    final payments = details.payments;

    // Primary Brand Colors
    final primaryColor = PdfColor.fromHex('1A365D'); // Deep Navy
    final secondaryColor = PdfColor.fromHex('2B6CB0'); // Vibrant Slate Blue
    final tableHeaderBg = PdfColor.fromHex('EDF2F7'); // Soft Gray
    final borderColor = PdfColor.fromHex('CBD5E0');
    final accentGreen = PdfColor.fromHex('22543D');
    final accentRed = PdfColor.fromHex('742A2A');

    String safeText(String text, {String fallback = 'Item'}) {
      if (isDevanagariSupported) return text;
      final buffer = StringBuffer();
      for (final char in text.runes) {
        if (char <= 127) {
          buffer.writeCharCode(char);
        }
      }
      final res = buffer.toString().trim();
      return res.isEmpty ? fallback : res;
    }

    // Business details
    final shopName = isDevanagariSupported
        ? (settings?.shopName ?? 'Pratap Electricals & Motor Rewinding')
        : 'Pratap Electricals & Motor Rewinding';
    final ownerName = isDevanagariSupported
        ? (settings?.ownerName ?? 'Dinesh Jadhav')
        : 'Dinesh Jadhav';
    final shopPhone = settings?.mobileNumber ?? '9623314436';
    final shopAddress = isDevanagariSupported
        ? (settings?.shopAddress ?? 'Main Road, Market Yard')
        : safeText(settings?.shopAddress ?? 'Main Road, Market Yard', fallback: 'Main Road, Market Yard');
    final isGst = settings?.isGstEnabled == true && (settings?.gstin?.isNotEmpty ?? false);
    final gstNumber = settings?.gstin ?? '';

    // Customer display
    final customerName = safeText(inv.customerName ?? customer?.name ?? 'Walk-in Customer', fallback: 'Walk-in Customer');
    final customerMobile = safeText(inv.customerMobile ?? customer?.mobile ?? '-', fallback: '-');
    final customerVillage = safeText(customer?.villageCity ?? '', fallback: '');

    // Date
    final invoiceDateStr = DateFormat('dd/MM/yyyy').format(inv.invoiceDate);

    // Category Label
    String categoryLabel;
    if (inv.category == 'repair') {
      categoryLabel = isDevanagariSupported ? 'मोटर रिपेअरिंग बिल (Repair Invoice)' : 'Motor Repair Invoice';
    } else if (inv.category == 'motor_sales') {
      categoryLabel = isDevanagariSupported ? 'नवीन मोटर विक्री बिल (Motor Sales)' : 'New Motor Sales Invoice';
    } else {
      categoryLabel = isDevanagariSupported ? 'पार्ट्स विक्री बिल (Spare Parts Sales)' : 'Spare Parts Sales Invoice';
    }

    doc.addPage(
      pw.Page(
        pageFormat: pageFormat,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 1. Header Box
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: primaryColor, width: 1.5),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
                ),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      flex: 6,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            shopName,
                            style: pw.TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'Prop: $ownerName | Mo. $shopPhone',
                            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
                          ),
                          if (shopAddress.isNotEmpty)
                            pw.Text(
                              shopAddress,
                              style: const pw.TextStyle(fontSize: 9.5, color: PdfColors.grey700),
                            ),
                          if (isGst)
                            pw.Text(
                              'GSTIN: $gstNumber',
                              style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold, color: secondaryColor),
                            ),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 4,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: pw.BoxDecoration(
                              color: inv.isCancelled ? PdfColors.red100 : tableHeaderBg,
                              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                            ),
                            child: pw.Text(
                              inv.isCancelled ? 'CANCELLED / रद्द' : (isGst ? 'TAX INVOICE' : 'BILL / पावती'),
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                                color: inv.isCancelled ? PdfColors.red800 : primaryColor,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Invoice No: ${inv.invoiceNumber}',
                            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            'Date: $invoiceDateStr',
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.Text(
                            categoryLabel,
                            style: pw.TextStyle(fontSize: 9.5, color: secondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 12),

              // 2. Customer Info Box
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                  border: pw.Border.all(color: borderColor, width: 0.5),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          isDevanagariSupported ? 'ग्राहकाचे नाव (Customer Name):' : 'Customer Name:',
                          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
                        ),
                        pw.Text(
                          customerName,
                          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          isDevanagariSupported ? 'मोबाईल नंबर (Contact):' : 'Contact:',
                          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
                        ),
                        pw.Text(
                          customerMobile,
                          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                    if (customerVillage.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            isDevanagariSupported ? 'गाव / शहर (Village):' : 'Village / City:',
                            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
                          ),
                          pw.Text(
                            customerVillage,
                            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              pw.SizedBox(height: 12),

              // 3. Items Table
              pw.Table(
                border: pw.TableBorder.all(color: borderColor, width: 0.5),
                columnWidths: {
                  0: const pw.FlexColumnWidth(0.8), // Sr No
                  1: const pw.FlexColumnWidth(4.5), // Description
                  2: const pw.FlexColumnWidth(1.2), // Qty
                  3: const pw.FlexColumnWidth(1.6), // Rate
                  4: const pw.FlexColumnWidth(1.9), // Amount
                },
                children: [
                  // Table Header
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: tableHeaderBg),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('#', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          isDevanagariSupported ? 'तपशील / Description' : 'Item Description',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          isDevanagariSupported ? 'नग / Qty' : 'Qty',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          isDevanagariSupported ? 'दर / Rate (Rs.)' : 'Rate (Rs.)',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          isDevanagariSupported ? 'रक्कम / Amount (Rs.)' : 'Amount (Rs.)',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  // Table Rows
                  ...items.asMap().entries.map((entry) {
                    final idx = entry.key + 1;
                    final it = entry.value;
                    return pw.TableRow(
                      decoration: pw.BoxDecoration(
                        color: idx.isEven ? PdfColors.grey50 : PdfColors.white,
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                          child: pw.Text(idx.toString(), style: const pw.TextStyle(fontSize: 9.5), textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                          child: pw.Text(safeText(it.description), style: const pw.TextStyle(fontSize: 9.5)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                          child: pw.Text(
                            it.quantity % 1 == 0 ? it.quantity.toInt().toString() : it.quantity.toStringAsFixed(1),
                            style: const pw.TextStyle(fontSize: 9.5),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                          child: pw.Text(it.unitPrice.toStringAsFixed(2), style: const pw.TextStyle(fontSize: 9.5), textAlign: pw.TextAlign.right),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                          child: pw.Text(
                            it.amount.toStringAsFixed(2),
                            style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),

              pw.SizedBox(height: 12),

              // 4. Financial Calculations & Summary Row
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left side: Payment Mode & Notes
                  pw.Expanded(
                    flex: 5,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(8),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: borderColor, width: 0.5),
                            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                          ),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                isDevanagariSupported ? 'पेमेंट तपशील (Payment Status):' : 'Payment Status:',
                                style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold, color: primaryColor),
                              ),
                              pw.SizedBox(height: 3),
                              pw.Text(
                                'Mode: ${inv.paymentMode.toUpperCase()}',
                                style: const pw.TextStyle(fontSize: 9),
                              ),
                              if (payments.isNotEmpty) ...[
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  isDevanagariSupported ? 'जमा हप्ते (Installments):' : 'Installments:',
                                  style: pw.TextStyle(fontSize: 8.5, fontWeight: pw.FontWeight.bold),
                                ),
                                ...payments.map(
                                  (p) => pw.Text(
                                    '• Rs. ${p.amountReceived.toStringAsFixed(0)} on ${DateFormat('dd/MM/yy').format(p.paymentDate)} (${p.paymentMode.toUpperCase()})',
                                    style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey800),
                                  ),
                                ),
                              ],
                              if (inv.notes != null && inv.notes!.isNotEmpty) ...[
                                pw.SizedBox(height: 4),
                                pw.Text('Note: ${inv.notes}', style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey700)),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  pw.SizedBox(width: 16),

                  // Right side: Totals Box
                  pw.Expanded(
                    flex: 5,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: borderColor, width: 0.8),
                        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                        color: PdfColors.grey50,
                      ),
                      child: pw.Column(
                        children: [
                          _buildSummaryRow('Subtotal (सबटोटल):', 'Rs. ${inv.subtotal.toStringAsFixed(2)}'),
                          if (inv.discount > 0)
                            _buildSummaryRow(
                              'Discount (सवलत):',
                              '- Rs. ${inv.discount.toStringAsFixed(2)}',
                              valueColor: accentGreen,
                            ),
                          if (inv.taxAmount > 0)
                            _buildSummaryRow('GST / Tax:', '+ Rs. ${inv.taxAmount.toStringAsFixed(2)}'),
                          pw.Divider(color: borderColor, thickness: 0.8, height: 10),
                          _buildSummaryRow(
                            'Grand Total (अंतिम एकूण):',
                            'Rs. ${inv.grandTotal.toStringAsFixed(2)}',
                            isBold: true,
                            fontSize: 11.5,
                            labelColor: primaryColor,
                          ),
                          pw.SizedBox(height: 3),
                          _buildSummaryRow(
                            'Paid Amount (जमा रक्कम):',
                            'Rs. ${inv.paidAmount.toStringAsFixed(2)}',
                            valueColor: accentGreen,
                            isBold: true,
                          ),
                          pw.SizedBox(height: 3),
                          _buildSummaryRow(
                            'Pending Balance (उर्वरित बाकी):',
                            'Rs. ${inv.pendingAmount.toStringAsFixed(2)}',
                            isBold: true,
                            valueColor: inv.pendingAmount > 0 ? accentRed : accentGreen,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              pw.Spacer(),

              // 5. Terms & Signatures Footer
              pw.Divider(color: borderColor, thickness: 0.8),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 6,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          isDevanagariSupported ? 'नियम व अटी (Terms & Conditions):' : 'Terms & Conditions:',
                          style: pw.TextStyle(fontSize: 8.5, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          settings?.warrantyTerms ??
                              settings?.pdfFooter ??
                              (isDevanagariSupported
                                  ? '1. दुरुस्तीनंतर मोटरची 1 महिन्याची वॉरंटी राहील (जळालेली / ओव्हरलोड वगळता).\n2. विकलेले साहित्य बिल सादर केल्याशिवाय बदलून मिळणार नाही.\n3. धन्यवाद! पुन्हा भेट द्या.'
                                  : '1. Motor rewinding comes with 1 month limited warranty.\n2. Goods once sold cannot be returned without original bill.\n3. Thank you for your business!'),
                          style: const pw.TextStyle(fontSize: 7.5, color: PdfColors.grey700),
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'For $shopName',
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 32),
                        pw.Text(
                          isDevanagariSupported ? 'अधिकृत स्वाक्षरी (Authorized Signatory)' : 'Authorized Signatory',
                          style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  static pw.Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    double fontSize = 9.5,
    PdfColor? labelColor,
    PdfColor? valueColor,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: labelColor,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Directly sends document to system print spooler or opens print preview dialog
  static Future<void> printInvoice(
    InvoiceWithDetails details,
    BusinessSetting? settings,
  ) async {
    await Printing.layoutPdf(
      onLayout: (format) => generateInvoicePdf(details, settings, pageFormat: format),
      name: '${details.invoice.invoiceNumber}.pdf',
    );
  }

  /// Opens native Android share sheet to share PDF file via WhatsApp, Email, etc.
  static Future<void> shareInvoicePdf(
    InvoiceWithDetails details,
    BusinessSetting? settings,
  ) async {
    final pdfBytes = await generateInvoicePdf(details, settings);
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: '${details.invoice.invoiceNumber}.pdf',
    );
  }

  /// Generates a Business Report PDF for a specific date range
  static Future<Uint8List> generateReportPdf({
    required DateTime startDate,
    required DateTime endDate,
    required double grossIncome,
    required double totalExpenses,
    required double netProfit,
    required double totalPendingReceivables,
    required BusinessSetting? settings,
    PdfPageFormat pageFormat = PdfPageFormat.a4,
  }) async {
    pw.Font regularFont;
    pw.Font boldFont;

    try {
      regularFont = await PdfGoogleFonts.notoSansDevanagariRegular();
      boldFont = await PdfGoogleFonts.notoSansDevanagariBold();
    } catch (_) {
      regularFont = pw.Font.helvetica();
      boldFont = pw.Font.helveticaBold();
    }

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(
        base: regularFont,
        bold: boldFont,
      ),
    );

    final shopName = settings?.shopName ?? 'Pratap Electricals & Motor Rewinding';
    final ownerName = settings?.ownerName ?? 'Dinesh Jadhav';
    final shopPhone = settings?.mobileNumber ?? '9623314436';
    final dateRangeStr = '${DateFormat('dd/MM/yyyy').format(startDate)} to ${DateFormat('dd/MM/yyyy').format(endDate)}';
    final generatedOnStr = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());

    final primaryColor = PdfColor.fromHex('1A365D');
    final secondaryColor = PdfColor.fromHex('2B6CB0');
    final accentGreen = PdfColor.fromHex('22543D');
    final accentRed = PdfColor.fromHex('742A2A');

    doc.addPage(
      pw.Page(
        pageFormat: pageFormat,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: primaryColor,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          shopName,
                          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Prop: $ownerName | Mobile: $shopPhone',
                          style: const pw.TextStyle(fontSize: 11, color: PdfColors.white),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'BUSINESS REPORT',
                          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Period: $dateRangeStr',
                          style: const pw.TextStyle(fontSize: 10, color: PdfColors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),

              // Summary Cards
              pw.Text('FINANCIAL SUMMARY / हिशोब गोषवारा', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: primaryColor)),
              pw.Divider(thickness: 1, color: PdfColors.grey400),
              pw.SizedBox(height: 8),

              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300, width: 1),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Particulars / तपशील', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11))),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Amount / रक्कम (₹)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11), textAlign: pw.TextAlign.right)),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Total Billed Revenue (एकूण कमाई)')),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('₹ ${grossIncome.toStringAsFixed(0)}', textAlign: pw.TextAlign.right, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Total Shop Expenses (दुकान खर्च)')),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('- ₹ ${totalExpenses.toStringAsFixed(0)}', textAlign: pw.TextAlign.right, style: pw.TextStyle(color: accentRed, fontWeight: pw.FontWeight.bold))),
                    ],
                  ),
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('NET PROFIT / निव्वळ नफा', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          '₹ ${netProfit.toStringAsFixed(0)}',
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 13,
                            color: netProfit >= 0 ? accentGreen : accentRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Total Customer Pending Receivables (बाकी वसुली शिल्लक)')),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('₹ ${totalPendingReceivables.toStringAsFixed(0)}', textAlign: pw.TextAlign.right, style: pw.TextStyle(color: accentRed, fontWeight: pw.FontWeight.bold))),
                    ],
                  ),
                ],
              ),
              pw.Spacer(),

              // Footer
              pw.Divider(thickness: 1, color: PdfColors.grey300),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Report Generated: $generatedOnStr', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
                  pw.Text('MotorShop Manager • Pratap Electricals', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
                ],
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  /// Print or preview Business Report PDF
  static Future<void> printReportPdf({
    required DateTime startDate,
    required DateTime endDate,
    required double grossIncome,
    required double totalExpenses,
    required double netProfit,
    required double totalPendingReceivables,
    required BusinessSetting? settings,
  }) async {
    await Printing.layoutPdf(
      onLayout: (format) => generateReportPdf(
        startDate: startDate,
        endDate: endDate,
        grossIncome: grossIncome,
        totalExpenses: totalExpenses,
        netProfit: netProfit,
        totalPendingReceivables: totalPendingReceivables,
        settings: settings,
        pageFormat: format,
      ),
      name: 'Business_Report_${DateFormat('yyyyMMdd').format(startDate)}.pdf',
    );
  }

  /// Share Business Report PDF via WhatsApp, Email, etc.
  static Future<void> shareReportPdf({
    required DateTime startDate,
    required DateTime endDate,
    required double grossIncome,
    required double totalExpenses,
    required double netProfit,
    required double totalPendingReceivables,
    required BusinessSetting? settings,
  }) async {
    final pdfBytes = await generateReportPdf(
      startDate: startDate,
      endDate: endDate,
      grossIncome: grossIncome,
      totalExpenses: totalExpenses,
      netProfit: netProfit,
      totalPendingReceivables: totalPendingReceivables,
      settings: settings,
    );
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Business_Report_${DateFormat('yyyyMMdd').format(startDate)}.pdf',
    );
  }
}
