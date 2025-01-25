import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context) {
      navigateAndFinish(context, LoginScreen());
}

void logOut(context) {
  navigateAndFinish(context, LoginScreen());
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

const userName = '';


const String appTitle = "تنظيم وأفراد مكتب السيد/ مدير الجهاز";
const String username = "اسم المستخدم";
const String password = "كلمة المرور";
const String login = "تسجيل الدخول";
const String logout = "تسجيل الخروج";
const String register = "تسجيل";
const String add = 'إضافة';
const String edit = 'تعديل';
const String delete = 'حذف';

const String welcome = "مرحباً";

const String loginError = "خطأ في اسم المستخدم أو كلمة المرور";
const String loginSuccess = "تم تسجيل الدخول بنجاح";

const String usernameError = "الرجاء إدخال اسم المستخدم";
const String passwordError = "الرجاء إدخال كلمة المرور";

const String usernameCheckError = "اسم المستخدم غير موجود";
const String passwordCheckError = "كلمة المرور غير صحيحة";

const String newUserBtn = 'إدخال وثيقة تعارف جديدة';
const String showUserBtn = 'إدخال وإظهار وثائق التعارف';
const String vacationBtn = 'تسجيل الاجازات';
const String vacation_datesBtn = 'تاريخ الاجازات';
const String movesBtn = 'التحركات';
const String enter_editBtn = 'إدخال / تعديل البيانات';
const String printBtn1 = 'طباعة تمام اليوم';
const String printBtn2 = 'طباعة تحركات اليوم';
const String printBtn3 = 'طباعة تصاريح الاجازات';

const String name = 'الاسم';
const String rank = 'الرتبة';
const String phone = 'رقم الهاتف';
const String add_phone = 'رقم الهاتف الاضافي';
const String homeAddress = 'عنوان المنزل';
const String homePhone = 'رقم الهاتف الارضي';
const String bDate = 'تاريخ الميلاد';
const String city = 'المحافظة';
const String nationalId = 'الرقم القومي';
const String soldierlId = 'الرقم العسكري';
const String job = 'الوظيفة داخل المكتب';
const String joinDate = 'تاريخ الالتحاق بالمكتب';
const String retireDate = 'تاريخ الرديف';
const String faculty = 'الجامعة / الكلية';
const String speciality = 'التخصص';
const String skills = 'المهارات';
const String fatherJob = 'وظيفة الاب';
const String motherJob = 'وظيفة الام';
const String fatherPhone = 'رقم هاتف الاب';
const String motherPhone = 'رقم هاتف الام';
const String grade = 'التقدير';
const String numOfSiblings = 'عدد الاخوة';
const String function = 'الوظيفة';

const String rankError = 'الرجاء إدخال الرتبة';
const String nameError = 'الرجاء إدخال الاسم';
const String phoneError = 'الرجاء إدخال رقم الهاتف';
const String add_phoneError = 'الرجاء إدخال الرقم الهاتف الاضافي';
const String homeAddressError = 'الرجاء إدخال عنوان المنزل';
const String homePhoneError = 'الرجاء إدخال رقم الهاتف الارضي';
const String bDateError = 'الرجاء إدخال تاريخ الميلاد';
const String cityError = 'الرجاء إدخال المدينة';
const String nationalIdError = 'الرجاء إدخال الرقم القومي';
const String soldierlIdError = 'الرجاء إدخال الرقم العسكري';
const String jobError = 'الرجاء إدخال الوظيفة داخل المكتب';
const String joinDateError = 'الرجاء إدخال تاريخ الالتحاق بالمكتب';
const String retireDateError = 'الرجاء إدخال تاريخ الرديف';
const String facultyError = 'الرجاء إدخال الجامعة / الكلية';
const String specialityError = 'الرجاء إدخال التخصص';
const String skillsError = 'الرجاء إدخال المهارات';
const String fatherJobError = 'الرجاء إدخال وظيفة الاب';
const String motherJobError = 'الرجاء إدخال وظيفة الام';
const String fatherPhoneError = 'الرجاء إدخال رقم هاتف الاب';
const String motherPhoneError = 'الرجاء إدخال رقم هاتف الام';
const String gradeError = 'الرجاء إدخال التقدير';
const String numOfSiblingsError = 'الرجاء إدخال عدد الاخوة';

const String imagePickSuccess = 'تم اختيار الصورة بنجاح';
const String imagePickError = 'حدث خطأ في اختيار صورة';

const String soldierAddSuccess = 'تم إضافة البيانات بنجاح';
const String soldierEditSuccess = 'تم تعديل البيانات بنجاح';
const String soldierDeleteSuccess = 'تم حذف البيانات بنجاح';

const String soldierAddError = 'حدث خطأ أثناء إضافة البيانات';
const String soldierEditError = 'حدث خطأ أثناء تعديل البيانات';

const String soldierAddLoading = 'جاري إضافة البيانات';

const String soldierEditLoading = 'جاري تعديل البيانات';

const String soldierDeleteLoading = 'جاري حذف البيانات';

const String soldiersListEmpty = 'لا توجد بيانات';

const String duration = 'المدة';

const String fromDate = 'من';
const String toDate = 'إلى';

const String vacationAddSuccess = 'تم تسجيل الاجازة بنجاح';
const String feedback = 'ملاحظات';
const String office = 'مكتب السيد/ مدير الجهاز';
const String DOC_TYP = 'تحركات';
const String DOC_EXT = 'امتداد';
const String DOC_VAC = 'اجازات';
const String DOC_TAMAM = 'تمام';

const String tamamSuccess = 'تم طباعة التمام بنجاح';
const String tamamError = 'حدث خطأ أثناء طباعة التمام';
const String updateImageSuccess = 'تم تحديث الصورة بنجاح';
const String missions = 'المهام اليومية للجنود';
const String missionsConstant = 'المهام اليومية للجنود';
const String printMissions = 'طباعة المهام اليومية للجنود';
const String printMissionSuccess = 'تم طباعة المهام اليومية للجنود بنجاح';
const String printMissionError = 'خطأ في طباعة المهام اليومية للجنود';

const String VIPReecption = ' VIP استقبال';
const String frontReception = 'الاستقبال الرئيسي ١';
const String backReception = 'الاستقبال الخلفي ٢';
const String sideReception = 'الاستقبال الجانبي ٣';
const String chef = 'المطبخ';
const String barista = 'البوفيه';
const String coffee_corner = 'الكوفي كورنر';
const String police = 'الشرطة العسكرية';
const String archive = 'مكتب الأرشيف والسكرتارية';
const String officeManager = 'مكتب السيد/ مدير الجهاز';
const String management = 'أعمال إدارية';
const String meeting_hole = 'قاعة المؤتمرات';
const String elevator = 'الأسانسير';
const String gym = 'الجيم';
const String adminstration = 'شئون إدارية المكتب';
const String development = 'تطوير';

const String currentFunction = 'الوظيفة الحالية:';
const String soldier = 'جندى';

const String setFunctionSucess = 'تم تعيين الوظيفة بنجاح';
const String setFunctionError = 'حدث خطأ أثناء تعيين الوظيفة';

const String genTableSuccessMsg = 'تم طباعة التحركات وتصريح الإجازات بنجاح';


const String extendBtn = 'مد';

const String vacationStopped = 'تم إيقاف الاجازة';

const String vacationExtended = 'تم مد الاجازة';

const String printExtend = 'طباعة الامتداد';
const String printExtendSuccess = 'تم طباعة الامتداد بنجاح';
const String printExtendError = 'حدث خطأ أثناء طباعة الامتداد';

const String vacation = 'اجازة';
const String allVacations = 'الكل';
const String extendedVacations = 'الممتد';
const String activeVacations = 'النشط';
const String noData = 'لا توجد بيانات';
const String stopVacation = 'إيقاف الاجازة';
const String deleteVacation = 'حذف الاجازة';
const String deleteAllVacation = 'حذف جميع الاجازات';
const String editVacation = 'تعديل الاجازة';
const String cancel = 'إلغاء';

const String confirmDeleteVacation = 'هل تريد حذف الاجازة؟';
const String confirmDeleteAllVacation = 'هل تريد حذف جميع الاجازات؟';

const String deleteVacationSuccess = 'تم حذف الاجازة بنجاح';

const String updateListSuccessMsg = 'تم التعديل بنجاح';
const String editVacationSuccess = 'تم تعديل الاجازة بنجاح';

const String save = 'حفظ';
const String makeVacationSuccessMsg = 'تم تسجيل الاجازة بنجاح';

const String durationFromLastVacation = 'المدة من آخر اجازة';



const String soldierIdImage = 'ارقام ملف تحقيق الشخصية العسكرية';
const String soldierNationalIdImage = 'ارقام ملف بطاقة الرقم القومي';

const String addNewSoldier = 'إضافة جندى جديد';

const String back = 'رجوع';

const String deleteSoldier = 'حذف الجندى';
const String deleteSoldierProgress = 'سيتم حذف الجندى نهائياً';
const String confirmDelete = 'تأكيد الحذف';
// const String deleteSoldierSuccess = 'تم حذف الجندى بنجاح';
const String selectImage = 'اختر صورة';



const String settings = 'الإعدادات';

const String changePass = 'تغيير كلمة المرور';

const String oldPass = 'كلمة المرور القديمة';
const String newPass = 'كلمة المرور الجديدة';
const String confirmNewPass = 'تأكيد كلمة المرور الجديدة';

const passwordsNotMatched = 'كلمة المرور غير متطابقة';
const String passwordChangedSuccess = 'تم تغيير كلمة المرور بنجاح';

const List<String> functions = [
  VIPReecption,
  frontReception,
  backReception,
  sideReception,
  chef,
  barista,
  police,
  archive,
  officeManager,
  management,
  meeting_hole,
  elevator,
  gym,
  coffee_corner,
  adminstration,
  development
];

const List<String> ranks = [
  'جندى',
  'عريف',
  'رقيب',
  'رقيب أول',
  'مساعد',
  'مساعد أول',
];

Map<String, String> arabicDigits = {
  '0': '٠',
  '1': '١',
  '2': '٢',
  '3': '٣',
  '4': '٤',
  '5': '٥',
  '6': '٦',
  '7': '٧',
  '8': '٨',
  '9': '٩',
};

Map<String, String> weekDays = {
  'saturday': 'السبت',
  'sunday': 'الأحد',
  'monday': 'الإثنين',
  'tuesday': 'الثلاثاء',
  'wednesday': 'الأربعاء',
  'thursday': 'الخمبس',
  'friday': 'الجمعة',
};

String getWeekDay(String day) {
  return weekDays[day]!;
}

String convertToArabic(String text) {
  return text.split('').map((char) {
    return arabicDigits[char] ?? char;
  }).join();
}

String convertArabicToEnglish(String text) {
  // Arabic digits
  const arabicDigits = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
  };

  // Convert Arabic digits to English
  return text.split('').map((char) {
    return arabicDigits[char] ??
        char; // Replace with English digit or keep original
  }).join();
}

class ArabicNumbersInputFormatter extends TextInputFormatter {
  // Map to convert English digits (0-9) to Arabic-Indic digits (٠-٩)
  final Map<String, String> arabicDigits = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Replace digits with their Arabic-Indic equivalents
    String newText = newValue.text.split('').map((char) {
      return arabicDigits[char] ??
          char; // Use Arabic digit or the same character if it's not a digit
    }).join();

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

final Map<String, String> _bracketsMap = {
  '(': ')', // Regular parentheses
  ')': '(',
  '[': ']', // Square brackets
  ']': '[',
  '{': '}', // Curly braces
  '}': '{',
  '<': '>', // Angle brackets
  '>': '<',
};

/// Converts brackets in text to Arabic format
String convertAllToArabic(String text) {
  if (text.isEmpty) return text;

  StringBuffer result = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    String char = text[i];
    result.write(_bracketsMap[char] ?? char);
  }
  return result.toString();
}

class ArabicBracketsConverter {
  static final Map<String, String> _bracketsMap = {
    '(': ')', // Regular parentheses
    ')': '(',
    '[': ']', // Square brackets
    ']': '[',
    '{': '}', // Curly braces
    '}': '{',
    '<': '>', // Angle brackets
    '>': '<',
  };

  /// Converts brackets in text to Arabic format
  static String convertAllToArabic(String text) {
    if (text.isEmpty) return text;

    StringBuffer result = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      result.write(_bracketsMap[char] ?? char);
    }
    return result.toString();
  }

  /// Converts specific types of brackets only
  static String convertSpecificBrackets(
    String text, {
    bool convertParentheses = true,
    bool convertSquare = true,
    bool convertCurly = true,
    bool convertAngle = true,
  }) {
    if (text.isEmpty) return text;

    Map<String, String> activeMap = {};

    if (convertParentheses) {
      activeMap.addAll({'(': ')', ')': '('});
    }
    if (convertSquare) {
      activeMap.addAll({'[': ']', ']': '['});
    }
    if (convertCurly) {
      activeMap.addAll({'{': '}', '}': '{'});
    }
    if (convertAngle) {
      activeMap.addAll({'<': '>', '>': '<'});
    }

    StringBuffer result = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      result.write(activeMap[char] ?? char);
    }
    return result.toString();
  }
}

final salt = BCrypt.gensalt();

Future<String> initializeDatabase() async {
  // Get the application document directory
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = '${appDir.path}/Tamam/db/Soldiers.db';

  // Check if the database already exists
  final dbFile = File(dbPath);
  if (!await dbFile.exists()) {
    // Load the database from assets
    final byteData = await rootBundle.load('assets/db/Soldiers.db');
    final buffer = byteData.buffer;

    // Write the database to the app document directory
    await dbFile.writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    print('Database copied to: $dbPath');
  } else {
    print('Database already exists at: $dbPath');
  }

  return dbPath; // Return the database path
}

Future<void> pickAppDatabaseFile() async {
  try {
    // Use FilePicker to pick the file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db'], // Only allow files with the .db extension
    );

    if (result != null) {
      // Get the file path
      String? filePath = result.files.single.path;

      if (filePath != null) {
        print("Selected database file: $filePath");

        // Save the database file to CacheHelper
        await CacheHelper.saveData(key: 'app_db_path', value: filePath);
      }
    } else {
      // User canceled the picker
      print("File selection canceled.");
    }
  } catch (e) {
    print("Error picking file: $e");
  }
}

Future<void> pickSoldiersDatabaseFile() async {
  try {
    // Use FilePicker to pick the file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db'], // Only allow files with the .db extension
    );

    if (result != null) {
      // Get the file path
      String? filePath = result.files.single.path;

      if (filePath != null) {
        print("Selected database file: $filePath");

        // Save the database file to CacheHelper
        await CacheHelper.saveData(key: 'soldiers_db_path', value: filePath);
      }
    } else {
      // User canceled the picker
      print("File selection canceled.");
    }
  } catch (e) {
    print("Error picking file: $e");
  }
}

Future<String> getAppDatabaseFile() async {
  final appDbPath = await CacheHelper.getData(key: 'app_db_path');
  return appDbPath;
}

Future<String> getSoldiersDatabaseFile() async {
  final soldiersDbPath = await CacheHelper.getData(key: 'soldiers_db_path');
  return soldiersDbPath;
}

Future<void> pickImagesFolder() async {
  try {
    // Allow the user to pick a folder
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      print("Selected folder: $selectedDirectory");
      CacheHelper.saveData(key: 'images_folder', value: selectedDirectory);
    } else {
      print("Folder selection canceled.");
    }
  } catch (e) {
    print("An error occurred while picking images: $e");
  }
}

Future<String> getImagesFolder() async {
  final imagesFolder = await CacheHelper.getData(key: 'images_folder');
  return imagesFolder;
}

Future<void> pickTemplatesFolder() async {
  try {
    // Allow the user to pick a folder
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      print("Selected folder: $selectedDirectory");
      CacheHelper.saveData(key: 'templates_folder', value: selectedDirectory);
    } else {
      print("Folder selection canceled.");
    }
  } catch (e) {
    print("An error occurred while picking images: $e");
  }
}

Future<String> getTemplatesFolder() async {
  final imagesFolder = await CacheHelper.getData(key: 'templates_folder');
  return imagesFolder;
}