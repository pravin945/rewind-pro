import 'package:intl/intl.dart';

class Formatters {
  static final NumberFormat _inrFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final NumberFormat _inrWithDecimals = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static String currency(double amount, {bool showDecimals = false}) {
    if (showDecimals || amount % 1 != 0) {
      return _inrWithDecimals.format(amount);
    }
    return _inrFormat.format(amount);
  }

  static String date(DateTime? dt) {
    if (dt == null) return '-';
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  static String dateWithTime(DateTime? dt) {
    if (dt == null) return '-';
    return DateFormat('dd/MM/yyyy hh:mm a').format(dt);
  }

  static String dateTime(DateTime? dt) => dateWithTime(dt);

  static String dateReadable(DateTime? dt) {
    if (dt == null) return '-';
    return DateFormat('dd MMM yyyy').format(dt);
  }

  static String statusText(String status) {
    switch (status) {
      case 'received':
        return 'मोटर जमा (Received)';
      case 'inspection':
        return 'तपासणी सुरू (Inspection)';
      case 'inProgress':
        return 'काम चालू (In Progress)';
      case 'waitingForParts':
        return 'पार्ट्सची वाट (Waiting Parts)';
      case 'completed':
        return 'काम पूर्ण (Completed)';
      case 'delivered':
        return 'ग्राहकाला दिले (Delivered)';
      default:
        return status;
    }
  }
}

