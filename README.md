# ⚡ RewindPro (रिवाइंड प्रो)

[![Flutter](https://img.shields.io/badge/Flutter-3.41.7-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.11.5-0175C2?logo=dart)](https://dart.dev)
[![SQLite & Drift](https://img.shields.io/badge/SQLite-Drift%20ORM-003B57?logo=sqlite)](https://drift.simonbinder.eu/)
[![State Management](https://img.shields.io/badge/Riverpod-2.6-blueviolet)](https://riverpod.dev)
[![Tests Passing](https://img.shields.io/badge/Tests-43%20Passing-success)](test/)
[![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android)](https://www.android.com)

**RewindPro (रिवाइंड प्रो)** is a complete, offline-first Android mobile application built specifically for motor rewinding, pump repair, and electrical engineering workshops. 

The application is fully tailored for **Pratap Electricals & Motor Rewinding (प्रताप इलेक्ट्रिकल्स & मोटर रिवाइंडिंग)**, owned and managed by **Dinesh Jadhav (दिनेश जाधव)**, Contact: **9623314436**.

Designed to operate 100% offline with zero cloud fees, zero recurring API expenses, and full support for mixed **Marathi - English (मराठी / इंग्लिश)** terminology that local shop owners effortlessly understand.

---

## 📌 प्रमुख वैशिष्ट्ये (Key Features)

### 1. 📊 आजचा हिशोब (Live Business Dashboard)
- **थेट डेटाबेस आकडेमोड (Real-time Financial Aggregates)**: चालू दिवसाची एकूण कमाई, जमा पेमेंट, बाकी रक्कम आणि चालू महिन्याचा हिशोब.
- **कामांची स्थिती ट्रॅकर (Live Job Status Cards)**: आजची नवीन कामे, चालू कामे (In Progress), काम पूर्ण (Completed), आणि ग्राहकाला दिलेली मोटारी (Delivered).
- **दुकान खर्च व कमी स्टॉक सूचना (Expenses & Low Stock Warning)**: आजचा एकूण दुकान खर्च आणि ज्या सुट्या मालाचा स्टॉक कमी झाला आहे त्यांची त्वरित यादी.
- **जलद पर्याय (Quick Actions)**: एका टॅपवर नवीन ग्राहक जोडणे, नवीन मोटर काम नोंदवणे, बिल तयार करणे, पेमेंट जमा करणे, दैनिक नोंदवही आणि दुकान खर्च नोंदवणे.

---

### 2. 👥 ग्राहक व्यवस्थापन व उधारी खाते (Customer Directory & Ledger)
- **संपूर्ण ग्राहक माहिती**: नाव, मोबाईल नंबर, पर्यायी नंबर, गाव/शहर, पत्ता आणि टीप.
- **खतावणी / खाते उतारा (Customer Ledger with Running Balance)**:
  - प्रत्येक ग्राहकाच्या प्रत्येक बिलाची (Debit - नावे) आणि जमा रकमेची (Credit - जमा) तारीखवार नोंद.
  - चालू बाकी शिल्लक (Running Balance) आपोआप अपडेट होते.
- **१-टॅप ग्राहक संवाद**:
  - 📞 **थेट फोन कॉल**: फोनच्या डायलरवरून त्वरित कॉल.
  - 💬 **WhatsApp खाते उतारा**: एका क्लिकवर ग्राहकाचा संपूर्ण तारीखवार हिशोब व एकूण बाकी रकमेचा मराठी मेसेज WhatsApp वर पाठवा.
  - 📩 **बाकी वसुली SMS**: प्री-फॉर्मेटेड एसएमएस मेसेज.

---

### 3. ⚙️ मोटर रिवाइंडिंग व दुरुस्ती कामे (Motor Repair Jobs & Lifecycle)
- **अनुक्रमिक जॉब नंबर (Sequential Job Numbers)**: वर्षानुसार अद्वितीय क्रमांक (उदा. `JOB-2026-0001`, `JOB-2026-0002`).
- **तपशीलवार तांत्रिक नोंदी**:
  - मोटर प्रकार (उदा. Submersible Pump, Openwell Pump, Induction Motor, Monoblock).
  - ब्रँड (CRI, Kirloskar, Texmo, Lubi, इत्यादी).
  - हॉर्सपॉवर (HP), फेज (Single Phase / Three Phase), व्होल्टेज आणि सिरीयल नंबर.
  - काय फॉल्ट आहे (Problem Description) आणि केलेले काम (Work Description).
- **६-टप्प्यांची कार्यस्थिती (Job Status Tracking)**:
  1. मोटर जमा (Received)
  2. तपासणी सुरू (Inspection)
  3. काम चालू (In Progress)
  4. पार्ट्सची वाट (Waiting for Parts)
  5. काम पूर्ण (Completed)
  6. ग्राहकाला दिले (Delivered)
- **कामाची स्थिती बदलल्यावर त्वरित ग्राहकाला मेसेज**: मोटर तयार झाल्यावर किंवा डिलिव्हरी झाल्यावर ॲप आपोआप ग्राहकाला WhatsApp/SMS पाठवण्याचा पर्याय समोर दाखवतो.
- **दुरुस्तीमध्ये वापरलेले साहित्य (Parts Used & Auto Stock Deduction)**: तांब्याची तार, बेअरिंग, कपॅसिटर, मेकॅनिकल सील जॉबमध्ये जोडताच इन्व्हेंटरी स्टॉकमधून तेवढे नग आपोआप वजा होतात आणि बिलात जोडले जातात.

---

### 4. 📝 दैनिक नोंदवही (Daily Work Register)
- दुकानात रोज होणाऱ्या लहान-मोठ्या कामांची नोंद (उदा. बेअरिंग बदलणे, कपॅसिटर चेक करणे, ऑइल सील बसवणे).
- तारीख फिल्टर्स: आज, काल, चालू आठवडा, चालू महिना आणि हवी ती तारीख (Custom Range).
- ग्राहकाचे नाव, जॉब संदर्भ, केलेले काम, खर्च व जमा रकमेचे संपूर्ण ऑडिट.

---

### 5. 🧾 बिलिंग, पावती व PDF इनव्हॉइस (Billing & Multi-Installment Payments)
- **अद्वितीय बिल क्रमांक (Sequential Invoices)**: कधीही डुप्लिकेट न होणारे बिल क्रमांक (उदा. `INV-2026-0001`).
- **सॉफ्ट कॅन्सलेशन (Soft Cancellation)**: चुकून झालेले बिल रद्द केल्यास बिल नंबर कधीही नष्ट होत नाही; इन्व्हेंटरीचा स्टॉक पुन्हा जमा होतो आणि लेजर पूर्ववत होते.
- **हप्त्याने पेमेंट (Multi-installment Payments)**: एका बिलाचे पैसे ग्राहक तुकड्या-तुकड्यात जमा करू शकतो (उदा. ₹३००० ॲडव्हान्स, नंतर ₹२०००, नंतर उरलेले).
- **पेमेंट प्रकार (Payment Modes)**: रोख (Cash), UPI (PhonePe, GPay, Paytm), बँक ट्रान्सफर (Bank Transfer).
- **व्यावसायिक A4 PDF बिल**:
  - दुकानाचे नाव (**Pratap Electricals & Motor Rewinding**), प्रोप्रायटर (**Dinesh Jadhav**), मोबाईल (**9623314436**).
  - मराठी देवनागरी फॉन्ट व ऑफलाइन सुरक्षित फॉलबॅक.
  - वॉरंटी अटी व नियम (Warranty Terms).
  - १-टॅप थेट प्रिंट किंवा WhatsApp वर PDF शेअर.

---

### 6. 💸 दुकान खर्च व्यवस्थापन (Shop Expenses & Consumables)
- मोटर रिवाइंडिंग व्यवसायासाठी लागणारे विशेष खर्च प्रकार:
  - तांब्याची तार (Copper Wire)
  - बेअरिंग (Bearings)
  - वॉर्निश (Varnish & Insulation Paper)
  - मेकॅनिकल सील व कपॅसिटर (Seals & Capacitors)
  - वीज बिल (Electricity Bill)
  - दुकान भाडे (Shop Rent)
  - चहा-नाश्ता (Tea & Refreshments)
  - वाहतूक खर्च (Transport & Freight)
  - इतर किरकोळ खर्च (Other Expenses)
- तारखेनुसार खर्च फिल्टर आणि एकूण खर्चाची आकडेमोड.

---

### 7. 📈 नफा-तोटा व व्यवसाय अहवाल (P&L Reports & Analytics)
- **कालावधी फिल्टर्स**: आज, चालू आठवडा, चालू महिना, चालू वर्ष, किंवा निवडलेली तारीख.
- **निव्वळ नफा (Net Profit Calculation)**:
  $$\text{निव्वळ नफा (Net Profit)} = \text{रिपेअरिंग कमाई} - \text{दुकान खर्च}$$
- **बाकी वसुली डॅशबोर्ड (Pending Receivables)**: बाजारात ग्राहकांकडे एकूण किती उधारी बाकी आहे याचा अचूक हिशोब.
- **अहवाल PDF एक्सपोर्ट**: एका क्लिकवर संपूर्ण महिन्याचा किंवा वर्षाचा ताळेबंद PDF स्वरूपात प्रिंट किंवा शेअर करा.

---

### 8. 💾 ऑफलाइन डेटा बॅकअप व रिस्टोर (Offline Backup & Restore)
- **स्थानिक सुरक्षित बॅकअप (SQLite WAL Checkpoint + Integrity Verification)**:
  - सर्व चालू नोंदी डिस्कवर लिहून `motorshop_backup_YYYYMMDD_HHMMSS.db` फाईल तयार केली जाते.
  - फाईलच्या पहिल्या १६ बाईट्सवरून `SQLite format 3` हेडरची पडताळणी केली जाते जेणेकरून भ्रष्ट (Corrupt) फाईल तयार होणार नाही.
- **१-टॅप बॅकअप शेअर**: बॅकअप फाईल थेट तुमच्या WhatsApp वर, Google Drive ॲपमध्ये किंवा मेमरी कार्डमध्ये जतन करा.
- **डेटा रिस्टोर (Restore from Backup)**: फोनमधील जुन्या बॅकअप फाईल्समधून एका क्लिकवर डेटा पूर्ववत करा (डेटा ओव्हरराइट होण्यापूर्वी स्पष्ट सूचना व संमती विचारली जाते).
- **गुगल ड्राईव्ह सिंक व क्लाऊड सुरक्षा**:
  > **टीप**: गुगल बॅकअपसाठी **पासवर्ड देण्याची अजिबात आवश्यकता नसते**. आधुनिक Android मधील अधिकृत Google OAuth 2.0 Client ID द्वारे फोनमधील "Sign in with Google" पॉपअपमधून सुरक्षितपणे खाजगी AppData फोल्डरमध्ये डेटा सेव्ह केला जातो.

---

## 🛠️ तंत्रज्ञान व आर्किटेक्चर (Technology Stack)

| घटक (Component) | तंत्रज्ञान (Technology) | वर्णन (Description) |
|---|---|---|
| **Framework** | Flutter 3.41+ (Dart 3.11+) | Google चे क्रॉस-प्लॅटफॉर्म मोबाईल ॲप फ्रेमवर्क |
| **Database** | SQLite + Drift ORM 2.24 | संपूर्ण स्थानिक, वेगवान आणि रिॲक्टिव्ह डेटाबेस |
| **State Management** | Flutter Riverpod 2.6 | आधुनिक, सुरक्षित आणि चाचणीयोग्य स्टेट मॅनेजमेंट |
| **Routing** | GoRouter 17.5 | डिक्लेरेटिव्ह राउटिंग आणि डीप लिंकिंग |
| **PDF Generation** | `pdf` & `printing` | उच्च दर्जाचे A4 बिल आणि बिझनेस रिपोर्ट जनरेशन |
| **Sharing** | `share_plus` & `url_launcher` | थेट WhatsApp, SMS, फोन डायलर व फाईल शेअरिंग |
| **Number Formatting** | `intl` (INR Currency) | भारतीय रुपया चिन्ह (₹) आणि अचूक दशांश हिशोब |

---

## 📁 प्रोजेक्ट फोल्डर रचना (Project Structure)

```
c:\Work\MotorShop Manager\
├── android/                   # Android नेटिव्ह कॉन्फिगरेशन व ग्रॅडल
├── assets/images/             # ॲप लोगो व व्हिज्युअल ब्रँडिंग
├── lib/
│   ├── main.dart              # मुख्य ॲप एंट्री पॉइंट आणि थीम सेटअप
│   ├── core/
│   │   ├── constants/         # ॲप स्ट्रिंग्स आणि बहुभाषिक लेबल्स (मराठी/इंग्लिश)
│   │   ├── database/          # Drift डेटाबेस, टेबल्स आणि DAO क्लासेस
│   │   │   ├── daos/          # Customer, Job, Invoice, Payment, Expense, Report, Settings
│   │   │   ├── app_database.dart
│   │   │   └── connection.dart
│   │   ├── providers/         # रिव्हरपॉड डेटाबेस व सर्व्हिस प्रोव्हाइडर्स
│   │   ├── router/            # GoRouter नेव्हिगेशन रूट्स
│   │   ├── services/          # PDF इनव्हॉइस व ऑफलाइन बॅकअप सर्व्हिस
│   │   ├── theme/             # प्रताप इलेक्ट्रिकल्स ब्रँड कलर्स व मटेरियल ३ थीम
│   │   └── utils/             # फॉरमॅटर्स आणि WhatsApp/SMS ॲक्शन हेल्पर्स
│   └── features/
│       ├── backup/            # डेटा बॅकअप व रिस्टोर स्क्रीन
│       ├── billing/           # बिल तयार करणे, बिल यादी आणि बिल तपशील
│       ├── customer/          # ग्राहक यादी, ग्राहक जोडणे/बदलणे आणि खतावणी
│       ├── daily_work/        # दैनिक काम नोंदवही (Work Register)
│       ├── dashboard/         # मुख्य डॅशबोर्ड आणि आकडेमोड कार्ड्स
│       ├── expenses/          # दुकान खर्च व्यवस्थापन स्क्रीन
│       ├── inventory/         # रिपेअरिंग साहित्य व स्पेअर पार्ट्स स्टॉक
│       ├── payment/           # बाकी वसुली (Pending Payments) स्क्रीन
│       ├── repair_job/        # मोटर कामे (Jobs), जॉब कार्ड आणि स्थिती अपडेट
│       ├── reports/           # नफा-तोटा व व्यावसायिक अहवाल स्क्रीन
│       └── settings/          # दुकान माहिती, वॉरंटी अटी व सेटिंग्ज
└── test/                      # सर्वसमावेशक चाचणी संच (४३/४३ पास)
    ├── milestone_1_database_test.dart
    ├── milestone_2_test.dart
    ├── milestone_3_test.dart
    ├── milestone_4_test.dart
    ├── milestone_6_7_8_test.dart
    └── widget_test.dart
```

---

## 🚀 ॲप कसे सुरू करावे आणि बिल्ड करावे (How to Run & Build)

### १. पूर्वतयारी (Prerequisites)
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (आवृत्ती 3.24 किंवा अधिक)
- Java JDK 17 किंवा 21
- Android Studio / Android SDK (API Level 21+)

### २. पॅकेजेस इन्स्टॉल करा (Install Dependencies)
```powershell
flutter pub get
```

### ३. चाचण्या चालवा (Run All Unit & Widget Tests)
सर्व ४३ चाचण्या चालवण्यासाठी:
```powershell
flutter test
```
*(अपेक्षित निकाल: `All tests passed!`)*

### ४. डिबग ॲप चालवा (Run Locally on Connected Phone)
USB द्वारे फोन संगणकाला जोडून:
```powershell
flutter run -d <device-id>
```

### ५. Android APK तयार करा (Build APK)
मोबाईलमध्ये थेट इन्स्टॉल करण्यासाठी APK फाईल तयार करा:
```powershell
flutter build apk --debug
```
किंवा अंतिम प्रकाशनासाठी:
```powershell
flutter build apk --release
```
तयार झालेली APK फाईल खालील ठिकाणी उपलब्ध होईल:
`build\app\outputs\flutter-apk\app-debug.apk` (किंवा `app-release.apk`)

---

## 🔒 डेटा सुरक्षा व बॅकअप मार्गदर्शक (Data Security & Backup Note)

1. **स्थानिक साठा (Local Storage)**: तुमचा सर्व व्यावसायिक डेटा फोनच्या अंतर्गत SQLite डेटाबेसमध्ये अत्यंत सुरक्षित असतो.
2. **इंटरनेटची गरज नाही (100% Offline)**: दुकानात इंटरनेट नसले तरी सर्व कामे, बिले आणि हिशोब सुरळीत चालतात.
3. **रोजचा बॅकअप**: दिवसाचे कामकाज संपल्यावर 'More -> डेटा बॅकअप' मध्ये जाऊन `बॅकअप घ्या व शेअर करा` बटनावर क्लिक करून फाईल स्वतःच्या WhatsApp वर किंवा Google Drive वर सुरक्षित ठेवून घ्या.

---

## 👨‍💼 व्यवसाय संपर्क (Business Information)

- **दुकान**: प्रताप इलेक्ट्रिकल्स & मोटर रिवाइंडिंग (Pratap Electricals & Motor Rewinding)
- **मालक**: दिनेश जाधव (Dinesh Jadhav)
- **मोबाईल**: 9623314436
- **पत्ता**: फाकटे, तालुका शिरूर, जिल्हा पुणे
