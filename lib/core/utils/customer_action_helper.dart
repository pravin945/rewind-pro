import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/formatters.dart';

class CustomerActionHelper {
  /// Clean phone number to digits only (e.g. remove spaces, dashes)
  static String cleanPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'[^\d+]'), '');
  }

  /// Launch phone call directly with phone number string
  static Future<void> makePhoneCall(String rawPhone) async {
    final phone = cleanPhoneNumber(rawPhone);
    if (phone.isEmpty) return;
    final uri = Uri(scheme: 'tel', path: phone);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (_) {}
  }

  /// Share raw text to WhatsApp
  static Future<void> shareViaWhatsApp(String rawPhone, String message) async {
    var phone = cleanPhoneNumber(rawPhone);
    if (!phone.startsWith('+') && !phone.startsWith('91') && phone.length == 10) {
      phone = '91$phone';
    } else if (phone.startsWith('+')) {
      phone = phone.substring(1);
    }
    final uri = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  /// Launch native phone dialer
  static Future<void> callPhone(BuildContext context, String rawPhone) async {
    final phone = cleanPhoneNumber(rawPhone);
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('मोबाईल नंबर उपलब्ध नाही (Phone number is empty)')),
      );
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('कॉल करता आला नाही ($phone)')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error launching call: $e')),
        );
      }
    }
  }

  /// Prepare and open native SMS application with prefilled message
  static Future<void> openSmsComposer(
    BuildContext context, {
    required String rawPhone,
    required String customerName,
    required double billedAmount,
    required double paidAmount,
    required double pendingAmount,
    required String shopName,
  }) async {
    final phone = cleanPhoneNumber(rawPhone);
    final billedStr = Formatters.currency(billedAmount);
    final paidStr = Formatters.currency(paidAmount);
    final pendingStr = Formatters.currency(pendingAmount);

    final message = '''नमस्कार $customerName,

आपल्या मोटर रिपेअरिंग / खरेदीचे एकूण बिल $billedStr आहे.
आपण $paidStr जमा केले आहेत.
आपली बाकी रक्कम $pendingStr आहे.
कृपया बाकी रक्कम लवकर जमा करावी.

धन्यवाद!
$shopName''';

    final uri = Uri(
      scheme: 'sms',
      path: phone,
      queryParameters: {'body': message},
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // Fallback for some Android intent handlers
        final fallbackUri = Uri.parse('sms:$phone?body=${Uri.encodeComponent(message)}');
        await launchUrl(fallbackUri);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('SMS ॲप उघडता आले नाही: $e')),
        );
      }
    }
  }

  /// Prepare and open WhatsApp with prefilled message
  static Future<void> openWhatsApp(
    BuildContext context, {
    required String rawPhone,
    required String customerName,
    required double billedAmount,
    required double paidAmount,
    required double pendingAmount,
    required String shopName,
  }) async {
    var phone = cleanPhoneNumber(rawPhone);
    if (!phone.startsWith('+') && !phone.startsWith('91') && phone.length == 10) {
      phone = '91$phone';
    } else if (phone.startsWith('+')) {
      phone = phone.substring(1);
    }

    final billedStr = Formatters.currency(billedAmount);
    final paidStr = Formatters.currency(paidAmount);
    final pendingStr = Formatters.currency(pendingAmount);

    final message = '''नमस्कार $customerName 🙏

आपल्या मोटर रिपेअरिंग / खरेदीचा हिशोब:
एकूण बिल: $billedStr
जमा रक्कम: $paidStr
बाकी रक्कम: $pendingStr

काही शंका असल्यास संपर्क साधा.

धन्यवाद!
$shopName''';

    final uri = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('WhatsApp उघडता आले नाही')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('WhatsApp त्रुटी: $e')),
        );
      }
    }
  }

  /// Show Bottom Sheet with Notify options
  static void showNotifyOptions(
    BuildContext context, {
    required String rawPhone,
    required String customerName,
    required double billedAmount,
    required double paidAmount,
    required double pendingAmount,
    required String shopName,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.send_to_mobile, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text(
                      'ग्राहकाला मेसेज पाठवा (Notify $customerName)',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'बाकी रक्कम: ${Formatters.currency(pendingAmount)}',
                  style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.w600),
                ),
                const Divider(height: 24),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.message, color: Colors.white),
                  ),
                  title: const Text('SMS पाठवा (Send SMS)'),
                  subtitle: const Text('फोनच्या SMS ॲपमध्ये मेसेज उघडून पाठवा'),
                  onTap: () {
                    Navigator.pop(ctx);
                    openSmsComposer(
                      context,
                      rawPhone: rawPhone,
                      customerName: customerName,
                      billedAmount: billedAmount,
                      paidAmount: paidAmount,
                      pendingAmount: pendingAmount,
                      shopName: shopName,
                    );
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.chat, color: Colors.white),
                  ),
                  title: const Text('WhatsApp मेसेज पाठवा'),
                  subtitle: const Text('WhatsApp ॲपमध्ये मेसेज उघडून पाठवा'),
                  onTap: () {
                    Navigator.pop(ctx);
                    openWhatsApp(
                      context,
                      rawPhone: rawPhone,
                      customerName: customerName,
                      billedAmount: billedAmount,
                      paidAmount: paidAmount,
                      pendingAmount: pendingAmount,
                      shopName: shopName,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Prepare and open SMS for Job Status update
  static Future<void> openJobStatusSms(
    BuildContext context, {
    required String rawPhone,
    required String customerName,
    required String jobNumber,
    required String motorDetails,
    required String statusText,
    required double remainingAmount,
    required String shopName,
  }) async {
    final phone = cleanPhoneNumber(rawPhone);
    final remainingStr = Formatters.currency(remainingAmount);
    final message = '''नमस्कार $customerName,

आपल्या $motorDetails (जॉब नं: $jobNumber) कामाची स्थिती: $statusText आहे.
अंदाजे बाकी रक्कम: $remainingStr

धन्यवाद!
$shopName''';

    final uri = Uri(scheme: 'sms', path: phone, queryParameters: {'body': message});
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        final fallback = Uri.parse('sms:$phone?body=${Uri.encodeComponent(message)}');
        await launchUrl(fallback);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('SMS ॲप उघडता आले नाही: $e')),
        );
      }
    }
  }

  /// Prepare and open WhatsApp for Job Status update
  static Future<void> openJobStatusWhatsApp(
    BuildContext context, {
    required String rawPhone,
    required String customerName,
    required String jobNumber,
    required String motorDetails,
    required String statusText,
    required double remainingAmount,
    required String shopName,
  }) async {
    var phone = cleanPhoneNumber(rawPhone);
    if (!phone.startsWith('+') && !phone.startsWith('91') && phone.length == 10) {
      phone = '91$phone';
    } else if (phone.startsWith('+')) {
      phone = phone.substring(1);
    }
    final remainingStr = Formatters.currency(remainingAmount);
    final message = '''नमस्कार $customerName 🙏

आपल्या मोटर रिपेअर कामाचे अपडेट:
मोटर: $motorDetails
जॉब नं: $jobNumber
स्थिती: $statusText
अंदाजे बाकी रक्कम: $remainingStr

काही शंका असल्यास संपर्क साधा.

धन्यवाद!
$shopName''';

    final uri = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('WhatsApp उघडता आले नाही')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('WhatsApp त्रुटी: $e')),
        );
      }
    }
  }

  /// Show Bottom Sheet with Job Status Notify options
  static void showJobStatusNotifyOptions(
    BuildContext context, {
    required String rawPhone,
    required String customerName,
    required String jobNumber,
    required String motorDetails,
    required String statusText,
    required double remainingAmount,
    required String shopName,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.send_to_mobile, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'कामाची स्थिती कळवा ($jobNumber)',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'स्थिती: $statusText',
                  style: const TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w600),
                ),
                const Divider(height: 24),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.message, color: Colors.white),
                  ),
                  title: const Text('SMS पाठवा (Send SMS)'),
                  subtitle: const Text('फोनच्या SMS ॲपमध्ये मेसेज उघडून पाठवा'),
                  onTap: () {
                    Navigator.pop(ctx);
                    openJobStatusSms(
                      context,
                      rawPhone: rawPhone,
                      customerName: customerName,
                      jobNumber: jobNumber,
                      motorDetails: motorDetails,
                      statusText: statusText,
                      remainingAmount: remainingAmount,
                      shopName: shopName,
                    );
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.chat, color: Colors.white),
                  ),
                  title: const Text('WhatsApp मेसेज पाठवा'),
                  subtitle: const Text('WhatsApp ॲपमध्ये मेसेज उघडून पाठवा'),
                  onTap: () {
                    Navigator.pop(ctx);
                    openJobStatusWhatsApp(
                      context,
                      rawPhone: rawPhone,
                      customerName: customerName,
                      jobNumber: jobNumber,
                      motorDetails: motorDetails,
                      statusText: statusText,
                      remainingAmount: remainingAmount,
                      shopName: shopName,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Generate WhatsApp statement message for Customer Ledger
  static String generateLedgerStatementText({
    required String customerName,
    required String rawPhone,
    required List<dynamic> entries, // CustomerLedgerEntry list
    required double totalBilled,
    required double totalPaid,
    required double outstandingBalance,
    required String shopName,
    String? ownerName,
    String? ownerPhone,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('📋 *$shopName*');
    buffer.writeln('*ग्राहक खाते उतारा (Customer Statement)*');
    buffer.writeln('तारीख: ${Formatters.date(DateTime.now())}');
    buffer.writeln('--------------------------------');
    buffer.writeln('ग्राहक: *$customerName*');
    buffer.writeln('मोबाईल: $rawPhone');
    buffer.writeln('--------------------------------');
    buffer.writeln('*व्यवहार नोंद (Transactions):*');

    if (entries.isEmpty) {
      buffer.writeln('कोणतीही नोंद उपलब्ध नाही.');
    } else {
      for (final e in entries) {
        final dateStr = Formatters.date(e.date as DateTime?);
        final title = e.title.toString();
        final isDebit = e.type == 'debit';
        if (isDebit) {
          buffer.writeln('• $dateStr | $title');
          buffer.writeln('  नावे (Bill): ₹${Formatters.currency(e.debit as double).replaceAll('₹', '')} | शिल्लक: ₹${Formatters.currency(e.runningBalance as double).replaceAll('₹', '')}');
        } else {
          buffer.writeln('• $dateStr | $title');
          buffer.writeln('  जमा (Paid): ₹${Formatters.currency(e.credit as double).replaceAll('₹', '')} | शिल्लक: ₹${Formatters.currency(e.runningBalance as double).replaceAll('₹', '')}');
        }
      }
    }

    buffer.writeln('--------------------------------');
    buffer.writeln('एकूण बिल रक्कम: ${Formatters.currency(totalBilled)}');
    buffer.writeln('एकूण जमा रक्कम: ${Formatters.currency(totalPaid)}');
    buffer.writeln('*अंतिम बाकी रक्कम (Balance): ${Formatters.currency(outstandingBalance)}*');
    buffer.writeln('--------------------------------');
    if (outstandingBalance > 0) {
      buffer.writeln('कृपया बाकी रक्कम लवकरात लवकर जमा करावी.');
    }
    buffer.writeln('धन्यवाद!');
    if (ownerName != null && ownerName.isNotEmpty) {
      buffer.writeln('$ownerName');
    }
    if (ownerPhone != null && ownerPhone.isNotEmpty) {
      buffer.writeln('संपर्क: $ownerPhone');
    }
    return buffer.toString();
  }

  /// Open WhatsApp with complete Ledger statement
  static Future<void> shareCustomerLedgerWhatsApp({
    required String rawPhone,
    required String customerName,
    required List<dynamic> entries,
    required double totalBilled,
    required double totalPaid,
    required double outstandingBalance,
    required String shopName,
    String? ownerName,
    String? ownerPhone,
  }) async {
    final text = generateLedgerStatementText(
      customerName: customerName,
      rawPhone: rawPhone,
      entries: entries,
      totalBilled: totalBilled,
      totalPaid: totalPaid,
      outstandingBalance: outstandingBalance,
      shopName: shopName,
      ownerName: ownerName,
      ownerPhone: ownerPhone,
    );
    await shareViaWhatsApp(rawPhone, text);
  }
}

