import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../providers/database_providers.dart';

enum AppLanguage {
  marathiEnglish('mr_en', 'मराठी / English (मिश्रित)'),
  marathi('mr', 'मराठी (Marathi)'),
  english('en', 'English');

  final String code;
  final String displayName;
  const AppLanguage(this.code, this.displayName);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (e) => e.code == code,
      orElse: () => AppLanguage.marathiEnglish,
    );
  }
}

class AppLanguageNotifier extends StateNotifier<AppLanguage> {
  AppLanguageNotifier() : super(AppLanguage.marathiEnglish);

  void setLanguage(AppLanguage lang) {
    if (state != lang) {
      state = lang;
    }
  }
}

final appLanguageProvider = StateNotifierProvider<AppLanguageNotifier, AppLanguage>((ref) {
  final notifier = AppLanguageNotifier();
  ref.listen<AsyncValue<BusinessSetting>>(businessSettingsStreamProvider, (prev, next) {
    next.whenData((settings) {
      notifier.setLanguage(AppLanguage.fromCode(settings.defaultLanguage));
    });
  });
  return notifier;
});

class AppStrings {
  final AppLanguage lang;
  AppStrings(this.lang);

  // App Title
  String get appTitle => lang == AppLanguage.english
      ? 'MotorShop Manager'
      : 'मोटरशॉप मॅनेजर (MotorShop Manager)';

  // Bottom Nav
  String get navHome => lang == AppLanguage.english
      ? 'Home'
      : (lang == AppLanguage.marathi ? 'मुख्य' : 'Home / आजचा हिशोब');

  String get navCustomers => lang == AppLanguage.english
      ? 'Customers'
      : (lang == AppLanguage.marathi ? 'ग्राहक' : 'Customers / ग्राहक');

  String get navJobs => lang == AppLanguage.english
      ? 'Jobs'
      : (lang == AppLanguage.marathi ? 'कामे' : 'Jobs / रिपेअरिंग');

  String get navBilling => lang == AppLanguage.english
      ? 'Billing'
      : (lang == AppLanguage.marathi ? 'बिलिंग' : 'Billing / बिल');

  String get navMore => lang == AppLanguage.english
      ? 'More'
      : (lang == AppLanguage.marathi ? 'अधिक' : 'More / इतर');

  // Dashboard Cards
  String get todayTotalIncome => lang == AppLanguage.english
      ? "Today's Total Billed"
      : 'आजची एकूण कमाई';

  String get todayReceived => lang == AppLanguage.english
      ? "Today's Received Payment"
      : 'आजची जमा रक्कम';

  String get todayPending => lang == AppLanguage.english
      ? "Today's Pending Payment"
      : 'आजची बाकी रक्कम';

  String get todayNewJobs => lang == AppLanguage.english
      ? "Today's New Jobs"
      : 'आजची नवीन कामे';

  String get inProgressJobs => lang == AppLanguage.english
      ? 'In Progress Jobs'
      : 'चालू असलेली कामे';

  String get completedJobs => lang == AppLanguage.english
      ? 'Completed Jobs'
      : 'पूर्ण झालेली कामे';

  String get deliveredJobs => lang == AppLanguage.english
      ? 'Delivered Motors'
      : 'ग्राहकाला दिलेली कामे';

  String get totalPendingPayments => lang == AppLanguage.english
      ? 'Total Pending Customer Payments'
      : 'एकूण बाकी रक्कम (Pending)';

  String get todaySales => lang == AppLanguage.english
      ? "Today's Sales"
      : 'आजची विक्री (Sales)';

  String get lowStockAlert => lang == AppLanguage.english
      ? 'Low Stock Items'
      : 'कमी स्टॉक असलेले साहित्य';

  // Quick Actions
  String get quickActions => lang == AppLanguage.english ? 'Quick Actions' : 'जलद पर्याय (Quick Actions)';
  String get addCustomer => lang == AppLanguage.english ? 'Add Customer' : 'नवीन ग्राहक (Add Customer)';
  String get newRepairJob => lang == AppLanguage.english ? 'New Repair Job' : 'नवीन मोटर काम (New Job)';
  String get createBill => lang == AppLanguage.english ? 'Create Bill' : 'नवीन बिल (New Bill)';
  String get receivePayment => lang == AppLanguage.english ? 'Receive Payment' : 'जमा पेमेंट (Payment)';
  String get sellMotorPump => lang == AppLanguage.english ? 'Sell Motor/Pump' : 'मोटर पंप विक्री (Sell Motor)';
  String get sellSpareParts => lang == AppLanguage.english ? 'Sell Spare Parts' : 'पार्ट्स विक्री (Sell Parts)';

  // Customer Management
  String get customerList => lang == AppLanguage.english ? 'Customers' : 'ग्राहक यादी (Customers)';
  String get customerName => lang == AppLanguage.english ? 'Customer Name' : 'ग्राहकाचे नाव';
  String get mobileNumber => lang == AppLanguage.english ? 'Mobile Number' : 'मोबाईल नंबर';
  String get altMobileNumber => lang == AppLanguage.english ? 'Alternate Mobile' : 'पर्यायी मोबाईल';
  String get address => lang == AppLanguage.english ? 'Address' : 'पत्ता';
  String get villageCity => lang == AppLanguage.english ? 'Village / City' : 'गाव / शहर';
  String get notes => lang == AppLanguage.english ? 'Notes' : 'टीप / इतर माहिती';
  String get searchCustomer => lang == AppLanguage.english ? 'Search by name or mobile...' : 'नाव किंवा मोबाईलने शोधा...';
  String get outstandingBalance => lang == AppLanguage.english ? 'Outstanding Balance' : 'बाकी रक्कम (Balance)';
  String get totalBilled => lang == AppLanguage.english ? 'Total Billed' : 'एकूण बिल रक्कम';
  String get totalPaid => lang == AppLanguage.english ? 'Total Paid' : 'एकूण जमा रक्कम';

  // Jobs
  String get jobNumber => lang == AppLanguage.english ? 'Job Number' : 'जॉब नंबर';
  String get motorType => lang == AppLanguage.english ? 'Motor Type' : 'मोटर प्रकार (Type)';
  String get motorBrand => lang == AppLanguage.english ? 'Motor Brand' : 'मोटर ब्रँड (Brand)';
  String get motorHp => lang == AppLanguage.english ? 'Motor HP' : 'मोटर एच.पी. (HP)';
  String get motorPhase => lang == AppLanguage.english ? 'Phase' : 'फेज (Phase)';
  String get singlePhase => lang == AppLanguage.english ? 'Single Phase' : 'सिंगल फेज (Single Phase)';
  String get threePhase => lang == AppLanguage.english ? 'Three Phase' : 'थ्री फेज (Three Phase)';
  String get motorSerialNo => lang == AppLanguage.english ? 'Serial Number (optional)' : 'मोटर सिरीयल नंबर';
  String get problemDesc => lang == AppLanguage.english ? 'Problem Description' : 'काय समस्या आहे (फॉल्ट)';
  String get labourCharges => lang == AppLanguage.english ? 'Labour Charges' : 'मजुरी आकार (Labour)';
  String get materialCharges => lang == AppLanguage.english ? 'Material Charges' : 'मटेरियल आकार (Material)';
  String get otherCharges => lang == AppLanguage.english ? 'Other Charges' : 'इतर आकार';
  String get discount => lang == AppLanguage.english ? 'Discount' : 'सवलत (Discount)';
  String get finalAmount => lang == AppLanguage.english ? 'Final Amount' : 'एकूण बिल रक्कम';
  String get advancePayment => lang == AppLanguage.english ? 'Advance Payment' : 'अॅडव्हान्स जमा';
  String get remainingAmount => lang == AppLanguage.english ? 'Remaining Amount' : 'बाकी रक्कम';
  String get expectedDelivery => lang == AppLanguage.english ? 'Expected Delivery' : 'अपेक्षित देण्याची तारीख';
  String get deliveryDate => lang == AppLanguage.english ? 'Delivery Date' : 'ग्राहकाला दिलेली तारीख';
  String get warrantyInfo => lang == AppLanguage.english ? 'Warranty Info' : 'गॅरंटी / वॉरंटी माहिती';

  // Job Statuses
  String get statusReceived => lang == AppLanguage.english ? 'Received' : 'मोटर जमा (Received)';
  String get statusInspection => lang == AppLanguage.english ? 'Inspection' : 'तपासणी सुरू (Inspection)';
  String get statusInProgress => lang == AppLanguage.english ? 'In Progress' : 'काम चालू (In Progress)';
  String get statusWaitingParts => lang == AppLanguage.english ? 'Waiting for Parts' : 'पार्ट्सची वाट पाहत आहे';
  String get statusCompleted => lang == AppLanguage.english ? 'Completed' : 'काम पूर्ण (Completed)';
  String get statusDelivered => lang == AppLanguage.english ? 'Delivered' : 'ग्राहकाला दिले (Delivered)';

  // Billing
  String get invoiceNumber => lang == AppLanguage.english ? 'Invoice No.' : 'बिल नंबर';
  String get invoiceDate => lang == AppLanguage.english ? 'Invoice Date' : 'बिल तारीख';
  String get subtotal => lang == AppLanguage.english ? 'Subtotal' : 'एकूण रक्कम';
  String get grandTotal => lang == AppLanguage.english ? 'Grand Total' : 'अंतिम एकूण रक्कम';
  String get paidAmount => lang == AppLanguage.english ? 'Paid Amount' : 'जमा रक्कम';
  String get pendingAmount => lang == AppLanguage.english ? 'Pending Amount' : 'बाकी रक्कम';
  String get paymentMode => lang == AppLanguage.english ? 'Payment Mode' : 'पेमेंट प्रकार';

  // Payment Modes
  String get modeCash => lang == AppLanguage.english ? 'Cash' : 'रोख (Cash)';
  String get modeUpi => lang == AppLanguage.english ? 'UPI / GPay / PhonePe' : 'UPI (PhonePe / GPay)';
  String get modeBank => lang == AppLanguage.english ? 'Bank Transfer' : 'बँक ट्रान्सफर (Bank)';
  String get modeOther => lang == AppLanguage.english ? 'Other' : 'इतर (Other)';

  // Inventory
  String get inventory => lang == AppLanguage.english ? 'Inventory' : 'स्टॉक / इन्व्हेंटरी (Inventory)';
  String get productName => lang == AppLanguage.english ? 'Product Name' : 'मालाचे / पार्टचे नाव';
  String get category => lang == AppLanguage.english ? 'Category' : 'प्रकार (Category)';
  String get purchasePrice => lang == AppLanguage.english ? 'Purchase Price' : 'खरेदी किंमत';
  String get sellingPrice => lang == AppLanguage.english ? 'Selling Price' : 'विक्री किंमत';
  String get currentStock => lang == AppLanguage.english ? 'Current Stock' : 'सध्याचा स्टॉक';
  String get minStockLevel => lang == AppLanguage.english ? 'Min Stock Level' : 'किमान स्टॉक मर्यादा';
  String get unit => lang == AppLanguage.english ? 'Unit' : 'युनिट (उदा. नग, किलो, मीटर)';

  // Settings & Backup
  String get settings => lang == AppLanguage.english ? 'Settings' : 'सेटिंग्ज (Settings)';
  String get shopDetails => lang == AppLanguage.english ? 'Shop Details' : 'दुकान माहिती';
  String get shopName => lang == AppLanguage.english ? 'Shop Name' : 'दुकानाचे नाव';
  String get ownerName => lang == AppLanguage.english ? 'Owner Name' : 'मालकाचे नाव';
  String get gstin => lang == AppLanguage.english ? 'GSTIN (Optional)' : 'जीएसटी नंबर (ऐच्छिक)';
  String get backupAndRestore => lang == AppLanguage.english ? 'Backup & Restore' : 'डेटा बॅकअप व रिस्टोर (Backup)';
  String get googleDriveBackup => lang == AppLanguage.english ? 'Google Drive Backup' : 'गुगल ड्राईव्ह बॅकअप';
  String get backupNow => lang == AppLanguage.english ? 'Backup Now' : 'आता बॅकअप घ्या (Backup Now)';
  String get restoreData => lang == AppLanguage.english ? 'Restore Data' : 'डेटा रिस्टोर करा (Restore)';
  String get lastBackup => lang == AppLanguage.english ? 'Last Backup' : 'शेवटचा बॅकअप';

  // Reports
  String get reports => lang == AppLanguage.english ? 'Reports' : 'हिशोब अहवाल (Reports)';
  String get dailyRegister => lang == AppLanguage.english ? 'Daily Work Register' : 'आजचे काम नोंद वही (Daily Register)';
  String get dailyWork => lang == AppLanguage.english ? 'Daily Work' : 'दैनिक काम (Daily Work)';

  // Common Buttons
  String get save => lang == AppLanguage.english ? 'Save' : 'जतन करा (Save)';
  String get cancel => lang == AppLanguage.english ? 'Cancel' : 'रद्द करा (Cancel)';
  String get delete => lang == AppLanguage.english ? 'Delete' : 'हटवा (Delete)';
  String get edit => lang == AppLanguage.english ? 'Edit' : 'बदल करा (Edit)';
  String get share => lang == AppLanguage.english ? 'Share' : 'शेअर करा (Share)';
  String get printPdf => lang == AppLanguage.english ? 'Print / PDF' : 'बिल PDF / प्रिंट';
  String get notifyCustomer => lang == AppLanguage.english ? 'Notify Customer' : 'ग्राहकाला मेसेज पाठवा';
  String get confirm => lang == AppLanguage.english ? 'Confirm' : 'खात्री करा';
  String get filter => lang == AppLanguage.english ? 'Filter' : 'फिल्टर';

  // Customer Ledger & Communication
  String get ledger => lang == AppLanguage.english ? 'Ledger' : 'खतावणी (Ledger)';
  String get debit => lang == AppLanguage.english ? 'Debit (Bill)' : 'नावे / बिल (Debit)';
  String get credit => lang == AppLanguage.english ? 'Credit (Payment)' : 'जमा (Credit)';
  String get runningBalance => lang == AppLanguage.english ? 'Balance' : 'बाकी शिल्लक (Balance)';
  String get callCustomer => lang == AppLanguage.english ? 'Call' : 'कॉल करा (Call)';
  String get smsNotification => lang == AppLanguage.english ? 'SMS' : 'SMS पाठवा';
  String get whatsappNotification => lang == AppLanguage.english ? 'WhatsApp' : 'WhatsApp पाठवा';
  String get noBackupYet => lang == AppLanguage.english ? 'No Backup Yet' : 'अद्याप बॅकअप नाही';
  String get customDateRange => lang == AppLanguage.english ? 'Custom Range' : 'तारीख निवडा (Custom Range)';
}

final stringsProvider = Provider<AppStrings>((ref) {
  final lang = ref.watch(appLanguageProvider);
  return AppStrings(lang);
});

