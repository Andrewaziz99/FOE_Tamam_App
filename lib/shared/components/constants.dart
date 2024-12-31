
import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/services.dart';

import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });

  CacheHelper.removeAllData();

}

void logOut(context) {
  CacheHelper.removeAllData();

  navigateAndFinish(context, LoginScreen());

}


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


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
const String showUserBtn = 'إظهار كل وثائق التعارف';
const String vacationBtn = 'تسجيل الاجازات';
const String vacation_datesBtn = 'تاريخ الاجازات';
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
const String city = 'المدينة';
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
const String imagePickError = 'الرجاء اختيار صورة';

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
const String DOC_VAC = 'اجازات';
const String DOC_TAMAM = 'تمام';

const String tamamSuccess = 'تم طباعة التمام بنجاح';
const String tamamError = 'حدث خطأ أثناء طباعة التمام';

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
    return arabicDigits[char] ?? char; // Replace with English digit or keep original
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
      return arabicDigits[char] ?? char; // Use Arabic digit or the same character if it's not a digit
    }).join();

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}


final salt = BCrypt.gensalt();

String getDatabasePath() {
  final dbFolder = Directory('${Directory.current.path}/db');
  if (!dbFolder.existsSync()) {
    dbFolder.createSync();
  }
  return '${dbFolder.path}/Soldiers.db';
}