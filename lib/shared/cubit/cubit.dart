import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tamam/models/Soldiers/soldier_model.dart';
import 'package:tamam/models/Vacations/vacation_model.dart';
import 'package:tamam/shared/cubit/states.dart';
import 'package:tamam/shared/network/local/cache_helper.dart';
import '../components/constants.dart';
import 'package:docx_template/docx_template.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  String? selectedValue;

  void changeSelectedValue(String value) {
    selectedValue = value;
    emit(changeSoldierData());
  }

  List<Map<dynamic, dynamic>> soldiers = [];

  void AddToList(index, soldierID, name, fromDate, toDate, feedBack, rank) {
    soldiers.add({
      'soldierID': soldierID,
      'name': name,
      'rank': rank,
      'fromDate': fromDate,
      'toDate': toDate,
      'feedback': feedBack,
      'num': index,
    });
    emit(addToListSuccess());
  }

  Future<void> createMOVDocFromList(
      List<Map<dynamic, dynamic>> dataList) async {
    try {
      // Locate and read the test template
      // final appDir = await getApplicationDocumentsDirectory();
      final movementFile = File('templates/movements.docx');

      if (!await movementFile.exists()) {
        throw Exception("Movements file not found: ${movementFile.path}");
      }

      final VAC = await CacheHelper.getData(key: 'VAC') ?? 0;

      final movementBytes = await movementFile.readAsBytes();
      final MoveDoc = await DocxTemplate.fromBytes(movementBytes);

      // Create a list of rows for the table content
      List<RowContent> allRows = [];

      var id = await CacheHelper.getData(key: 'id') ?? 1;

      final currentYear =
          convertToArabic(DateFormat('yyyy').format(DateTime.now()));

      final logoFileContent =
          await File('assets/images/logo.png').readAsBytes();
      final dayDate =
          convertToArabic(DateFormat('yyyy-MM-dd').format(DateTime.now()));

      final currentDate =
          convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));

      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final weekday =
          getWeekDay(DateFormat('EEEE').format(tomorrow).toLowerCase());

      final date = convertToArabic(DateFormat('yyyy/MM/dd')
          .format(DateTime.now().add(const Duration(days: 1))));

      for (int i = 0; i < dataList.length; i++) {
        makeVacation(soldierID: dataList[i]['soldierID'], fromDate: dataList[i]['fromDate'], toDate: dataList[i]['toDate'], feedback: dataList[i]['feedback'], rank: dataList[i]['rank'], name: dataList[i]['name']);


        final data = dataList[i];

        // Create a row for the current data
        final row = RowContent()
          ..add(TextContent("name", data['name']))
          ..add(TextContent("fromDate", data['fromDate']))
          ..add(TextContent("toDate", data['toDate']))
          ..add(TextContent("level", data['rank']))
          ..add(TextContent("feedback", data['feedback']))
          ..add(TextContent("num", convertToArabic((i + 1).toString())));

        // Add the row to our collection
        allRows.add(row);
      }
      // Populate placeholders
      Content content = Content();
      content
        ..add(ImageContent("logo", logoFileContent))
        ..add(TextContent("id", convertToArabic(id.toString())))
        ..add(TextContent("year", currentYear))
        ..add(TextContent("dept_Name", office))
        ..add(TextContent("currentDate", currentDate))
        ..add(TextContent("doc_Typ", DOC_TYP))
        ..add(TextContent("day", weekday))
        ..add(TextContent("date", date))
        ..add(TextContent("space", '\n'))
        ..add(TableContent('table', allRows));

      // Generate the document for the current item
      final generatedDoc = await MoveDoc.generate(content);

      if (generatedDoc != null) {
        final movements = File('templates/$DOC_TYP $dayDate.docx');
        await movements.writeAsBytes(generatedDoc, flush: true);

        print("Document generated successfully at: ${movements.path}");

        await CacheHelper.saveData(key: 'id', value: id + 1);

        emit(genTableSuccess());

        final result = await OpenFilex.open(movements.path);
        print('Open file result: ${result.type}');
      } else {
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Future<void> createVACDocFromList(List<Map<String, dynamic>> dataList) async {
  //   try {
  //     // final appDir = await getApplicationDocumentsDirectory();
  //
  //     final vacationPassesFile = File('templates/test.docx');
  //
  //     if (!await vacationPassesFile.exists()) {
  //       throw Exception("Vacation Passes file not found: ${vacationPassesFile.path}");
  //     }
  //
  //
  //     final vacationPassesBytes = await vacationPassesFile.readAsBytes();
  //     final VacDoc = await DocxTemplate.fromBytes(vacationPassesBytes);
  //
  //     final dayDate = convertToArabic(
  //         DateFormat('yyyy-MM-dd').format(DateTime.now()));
  //
  //     final FH = convertToArabic('900');
  //     final TH = convertToArabic('1000');
  //
  //
  //     // Create a list of rows for the table content
  //     List<RowContent> allRows = [];
  //
  //
  //     for (int i = 0; i < dataList.length; i++) {
  //       final data = dataList[i];
  //
  //
  //
  //       // Create a row for the current data
  //       final row = RowContent()
  //         ..add(TextContent("name", data['name']))
  //         ..add(TextContent("fromDate", data['fromDate']))
  //         ..add(TextContent("toDate", data['toDate']))
  //         ..add(TextContent("level", data['rank']))
  //         ..add(TextContent("FH", FH))
  //         ..add(TextContent("TH", TH)
  //         );
  //
  //       // Add the row to our collection
  //       allRows.add(row);
  //     }
  //     // Populate placeholders
  //     Content content = Content();
  //     content
  //       .add(TableContent('table', allRows)
  //       );
  //     print(content.key);
  //
  //     // Generate the document for the current item
  //     final generatedVacationPassesDoc = await VacDoc.generate(content);
  //
  //
  //     if (generatedVacationPassesDoc != null) {
  //
  //       final vacationPasses = File('templates/$DOC_VAC $dayDate.docx');
  //       await vacationPasses.writeAsBytes(generatedVacationPassesDoc);
  //
  //
  //       print("Document generated successfully at: ${vacationPasses.path}");
  //
  //       // final result = await OpenFile.open(outputFile.path, type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
  //       // print("OpenFile result: Type - ${result.type}, Message - ${result.message}");
  //
  //       emit(genTableSuccess());
  //     } else {
  //       throw Exception("Failed to generate document");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  Future<void> createVACDocFromList(
      List<Map<dynamic, dynamic>> dataList) async {
    try {
      // Load the Word template
      final vacationPassesFile = File('templates/test1.docx');

      if (!await vacationPassesFile.exists()) {
        throw Exception(
            "Vacation Passes file not found: ${vacationPassesFile.path}");
      }

      final vacationPassesBytes = await vacationPassesFile.readAsBytes();
      final VacDoc = await DocxTemplate.fromBytes(vacationPassesBytes);

      // Create a dynamic list of rows
      List<RowContent> allRows = [];

      for (var data in dataList) {
        // Create a row with dynamic data
        final row = RowContent()
          ..add(TextContent("name", data['name']))
          ..add(TextContent("fromDate", data['fromDate']))
          ..add(TextContent("toDate", data['toDate']))
          ..add(TextContent("level", data['rank']))
          ..add(TextContent("FH", convertToArabic('900')))
          ..add(TextContent("TH", convertToArabic('1000')));

        // Add the row to the list of rows
        allRows.add(row);
      }

      // Define the table content in the template
      Content content = Content()
        ..add(TableContent('table',
            allRows)); // The placeholder in the template should be 'table'

      // Generate the document with dynamic data
      final generatedVacationPassesDoc = await VacDoc.generate(content);

      if (generatedVacationPassesDoc != null) {
        final dayDate =
            convertToArabic(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        final vacationPasses = File('templates/$DOC_VAC $dayDate.docx');
        await vacationPasses.writeAsBytes(generatedVacationPassesDoc);

        print("Document generated successfully at: ${vacationPasses.path}");
        emit(genTableSuccess());
      } else {
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Future<void> createVACDocFromList(List<Map<String, dynamic>> dataList) async {
  //   try {
  //     final vacationPassesFile = File('templates/test1.docx');
  //
  //     if (!await vacationPassesFile.exists()) {
  //       throw Exception("Vacation Passes file not found: ${vacationPassesFile.path}");
  //     }
  //
  //     final vacationPassesBytes = await vacationPassesFile.readAsBytes();
  //     final templateDoc = await DocxTemplate.fromBytes(vacationPassesFile.readAsBytesSync());
  //
  //     final dayDate = convertToArabic(
  //         DateFormat('yyyy-MM-dd').format(DateTime.now()));
  //
  //     final FH = convertToArabic('900');
  //     final TH = convertToArabic('1000');
  //
  //     // Constants for layout
  //     const permitsPerRow = 3;
  //
  //     // Calculate number of rows needed
  //     final int totalRows = (dataList.length / permitsPerRow).ceil();
  //
  //     // Create a list to hold all permit rows
  //     List<RowContent> allRows = [];
  //
  //     // Process data in groups of 3 (permits per row)
  //     for (int i = 0; i < totalRows; i++) {
  //       final startIdx = i * permitsPerRow;
  //       final endIdx = min(startIdx + permitsPerRow, dataList.length);
  //
  //       // Create content for one row (up to 3 permits)
  //       final rowContent = RowContent();
  //
  //       // Add permits for this row
  //       for (int j = startIdx; j < endIdx; j++) {
  //         final data = dataList[j];
  //
  //         rowContent
  //           ..add(TextContent("level", data['rank']))
  //           ..add(TextContent("name", data['name']))
  //           ..add(TextContent("fromDate", data['fromDate']))
  //           ..add(TextContent("toDate", data['toDate']))
  //           ..add(TextContent("FH", FH))
  //           ..add(TextContent("TH", TH));
  //       }
  //
  //       allRows.add(rowContent);
  //     }
  //
  //     // Create the final content with all rows
  //     Content content = Content()
  //       ..add(TableContent("table", allRows));
  //
  //     // Generate the document
  //     final generatedDoc = await templateDoc.generate(content);
  //
  //     if (generatedDoc != null) {
  //       final outputFile = File('templates/$DOC_VAC $dayDate.docx');
  //       await outputFile.writeAsBytes(generatedDoc);
  //       print("Document generated successfully at: ${outputFile.path}");
  //       emit(genTableSuccess());
  //     } else {
  //       throw Exception("Failed to generate document");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //     emit(genTableError());
  //   }
  // }

  Future<void> createTamamDoc() async {

    emit(TamamLoading());

    final T_id = await CacheHelper.getData(key: 'T_id') ?? 1;

    getVacations();
    RowContent row = RowContent();
    List <RowContent> allRows = [];

    int num = 0;

    int VAC = 0;
    int CAP_VAC = 0;
    VacData.forEach((element) {
      if (element.rank == 'جندى') {
        VAC++;
      }
      else {
        CAP_VAC++;
      }
      row
        ..add(TextContent("name", element.name))
        ..add(TextContent("fromDate", element.fromDate))
        ..add(TextContent("toDate", element.toDate))
        ..add(TextContent("level", element.rank))
        ..add(TextContent("status", ''))
        ..add(TextContent("num", convertToArabic('${num++}')));


      allRows.add(row);

    });

    try {
      // Locate and read the test template
      // final appDir = await getApplicationDocumentsDirectory();
      final tamamFile = File('templates/tamam1.docx');

      if (!await tamamFile.exists()) {
        throw Exception("Tamam file not found: ${tamamFile.path}");
      }

      final tamamBytes = await tamamFile.readAsBytes();
      final tamamDoc = await DocxTemplate.fromBytes(tamamBytes);

      final dayDate =
          convertToArabic(DateFormat('yyyy-MM-dd').format(DateTime.now()));

      final currentDate =
          convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));

      final today = DateTime.now();
      final weekday =
          getWeekDay(DateFormat('EEEE').format(today).toLowerCase());

      final logoFileContent =
          await File('assets/images/logo.png').readAsBytes();
      final signatureFileContent =
          await File('assets/images/signature1.png').readAsBytes();

      getSoldiersWhere('soldierRank = \'جندى\'');
      await CacheHelper.saveData(key: 'Sol_NUM', value: soldiers_data.length);
      //
      getSoldiersWhere('soldierRank != \'جندى\'');
      await CacheHelper.saveData(key: 'CAPS_NUM', value: soldiers_data.length);

      //
      // getSoldiersWhere('soldierRank != \'جندى\' AND inVAC = 1');
      // await CacheHelper.saveData(key: 'CAPS_OUT', value: soldiers_data.length);
      //
      // getSoldiersWhere('soldierRank = \'جندى\' AND inVAC = 1');
      // await CacheHelper.saveData(key: 'VAC', value: soldiers_data.length);
      //
      // getSoldiersWhere('soldierRank = \'جندى\' AND isOUT = 1');
      // await CacheHelper.saveData(
      //     key: 'OUT_SOL_NUM', value: soldiers_data.length);
      //
      // getSoldiersWhere('isOUT = 1');
      // await CacheHelper.saveData(key: 'OUT', value: soldiers_data.length);
      //
      final ALL =
          await convertToArabic(CacheHelper.getData(key: 'ALL').toString());
      //
      // final VAC =
      //     await convertToArabic(CacheHelper.getData(key: 'VAC').toString());
      //
      // final CAPS_OUT = await convertToArabic(
      //     CacheHelper.getData(key: 'CAPS_OUT').toString());
      //
      // final OUT =
      //     await convertToArabic(CacheHelper.getData(key: 'OUT').toString());
      //
      final PRES_SOL_NUM = await convertToArabic(
          (CacheHelper.getData(key: 'Sol_NUM') -
                  VAC)
              .toString());
      //
      // final OUT_SOL_NUM = await convertToArabic(
      //     CacheHelper.getData(key: 'OUT_SOL_NUM').toString());
      //
      // final PRESENT = await convertToArabic(
      //     (CacheHelper.getData(key: 'ALL') - CacheHelper.getData(key: 'VAC'))
      //         .toString());
      //
      final SOLDIERS_NUM =
          await convertToArabic(CacheHelper.getData(key: 'Sol_NUM').toString());

      final CAPS_NUM = await convertToArabic(
          CacheHelper.getData(key: 'CAPS_NUM').toString());
      //
      final PRES_CAPS = await convertToArabic(
          (CacheHelper.getData(key: 'CAPS_NUM') -
                  CAP_VAC)
              .toString());



      final PRESENT = convertToArabic((CacheHelper.getData(key: 'ALL') - VAC).toString());

      final OUT = convertToArabic('0');
      final OUT_SOL_NUM = convertToArabic('0');




      final currentYear =
      convertToArabic(DateFormat('yyyy').format(DateTime.now()));


      // Populate placeholders
      Content content = Content();
      content
        ..add(ImageContent("logo", logoFileContent))
        ..add(ImageContent("signature", signatureFileContent))
        ..add(TextContent("dept_Name", office))
        ..add(TextContent("T_id", convertToArabic(T_id.toString())))
        ..add(TextContent("year", currentYear))
        ..add(TextContent("currentDate", currentDate))
        ..add(TextContent("day", weekday))
        ..add(TextContent("ALL", ALL))
        ..add(TextContent("PRESENT", PRESENT))
        ..add(TextContent("VAC", convertToArabic(VAC.toString())))
        ..add(TextContent("OUT", OUT))
        ..add(TextContent("SOLDIERS_NUM", SOLDIERS_NUM))
        ..add(TextContent("PRES_SOL_NUM", PRES_SOL_NUM))
        ..add(TextContent("OUT_SOL_NUM", OUT_SOL_NUM))
        ..add(TextContent("NUM_CAPS", CAPS_NUM))
        ..add(TextContent("PRES_CAPS", PRES_CAPS))
        ..add(TextContent("OUT_CAPS", convertToArabic(CAP_VAC.toString())))
        ..add(TableContent('table', allRows))
        ..add(TextContent("space", '\n'));

      // Generate the document for the current item
      final generatedDoc = await tamamDoc.generate(content);

      if (generatedDoc != null) {
        final tamam = File('templates/tamam $dayDate.docx');
        await tamam.writeAsBytes(generatedDoc);

        print("Document generated successfully at: ${tamam.path}");

        emit(TamamSuccess());

        await CacheHelper.saveData(key: 'T_id', value: T_id + 1);

        final result = await OpenFilex.open(tamam.path);
        print('Open file result: ${result.type}');
      } else {
        emit(TamamError());
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      emit(TamamError());
      print("Error: $e");
    }
  }



  var image;

  void pickImage() {
    emit(pickImageLoading());
    FilePicker.platform
        .pickFiles(
      type: FileType.image,
      allowMultiple: false,
    )
        .then((value) {
      if (value != null) {
        image = value.files.first.path;
        print(image);
        emit(pickImageSuccess());
      } else {
        emit(pickImageError());
      }
    }).catchError((error) {
      emit(pickImageError());
    });
  }

  void enterNewSoldier({
    required name,
    required rank,
    required phone,
    addPhone,
    required birthDate,
    required city,
    required image,
    required nationalID,
    required soldierID,
    required retiringDate,
    required faculty,
    required spec,
    required grade,
    required homeAddress,
    required home_num,
    required father_job,
    required mother_job,
    father_phone,
    mother_phone,
    required num_of_siblings,
    required skills,
    required function,
    required joinDate,
    inVAC,
    isOUT,
  }) {
    emit(enterNewSoldierLoading());

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      db.execute(''' CREATE TABLE IF NOT EXISTS soldiers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        soldierName TEXT NOT NULL,
        soldierRank TEXT NOT NULL,
        soldierPhone TEXT NOT NULL,
        soldierAddPhone TEXT,
        soldierHomeAddress TEXT NOT NULL,
        soldierBDate TEXT NOT NULL,
        soldierCity TEXT NOT NULL,
        soldierImage TEXT NOT NULL,
        soldierNationalId TEXT NOT NULL UNIQUE,
        soldierId TEXT NOT NULL UNIQUE,
        soldierRetireDate TEXT NOT NULL,
        soldierFaculty TEXT NOT NULL,
        soldierSpeciality TEXT NOT NULL,
        soldierGrade TEXT NOT NULL,
        soldierHomePhone TEXT NOT NULL,
        soldierFatherJob TEXT NOT NULL,
        soldierMotherJob TEXT NOT NULL,
        soldierFatherPhone TEXT,
        soldierMotherPhone TEXT,
        soldierNumOfSiblings TEXT NOT NULL,
        soldierSkills TEXT NOT NULL,
        soldierFunction TEXT NOT NULL,
        soldierJoinDate TEXT NOT NULL,
        inVAC BOOL NOT NULL,
        isOUT BOOL NOT NULL
      )''');
    } catch (e) {
      print(e);
    }

    try {
      db.execute(''' INSERT INTO soldiers (
        soldierName, soldierRank, soldierPhone, soldierAddPhone, soldierHomeAddress, soldierBDate, soldierCity, soldierImage, soldierNationalId, soldierId, soldierRetireDate, soldierFaculty, soldierSpeciality, soldierGrade, soldierHomePhone, soldierFatherJob, soldierMotherJob, soldierFatherPhone, soldierMotherPhone, soldierNumOfSiblings, soldierSkills, soldierFunction, soldierJoinDate, inVAC, isOUT
      ) VALUES (
        "$name", "$rank", "$phone", "$addPhone", "$homeAddress", "$birthDate", "$city", "$image", "$nationalID", "$soldierID", "$retiringDate", "$faculty", "$spec", "$grade", "$home_num", "$father_job", "$mother_job", "$father_phone", "$mother_phone", "$num_of_siblings", "$skills", "$function", "$joinDate", false, false
      )''');
      print("Soldier inserted");
      db.dispose();
      emit(enterNewSoldierSuccess());
    } catch (e) {
      emit(enterNewSoldierError());
      print(e);
    }
  }

  List<SoldierModel> soldiersList = [];

  List<String> soldiersName = [];

  void getSoldiers() {
    emit(getSoldiersLoading());
    soldiersName.clear();

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers
      ''');
      soldiersList = soldiers.map((e) => SoldierModel.fromJson(e)).toList();

      for (var value in soldiersList) {
        soldiersName.add(value.soldierName!);
        soldiersName.sort();
      }
      CacheHelper.saveData(key: 'ALL', value: soldiersList.length);

      db.dispose();
      emit(getSoldiersSuccess());
    } catch (e) {
      emit(getSoldiersError());
      print(e);
    }
  }

  SoldierModel? soldierModel;
  void getSoldierById(soldierID) {
    emit(getSoldierLoading());

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers WHERE soldierId = "$soldierID"
      ''');
      soldierModel = SoldierModel.fromJson(soldiers.first);
      db.dispose();
      emit(getSoldierSuccess());
    } catch (e) {
      emit(getSoldierError());
    }
  }

  List<SoldierModel> soldiers_data = [];

  void getSoldiersWhere(condition) {
    emit(getSoldiersLoading());
    soldiers_data.clear();

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers WHERE $condition
      ''');
      soldiers_data = soldiers.map((e) => SoldierModel.fromJson(e)).toList();
      db.dispose();
      emit(getSoldiersSuccess());
    } catch (e) {
      emit(getSoldiersError());
      print(e);
    }
  }

  List<SoldierModel> soldierNotInVAC = [];

  void getNotInVAC() {
    emit(getSoldierLoading());

    soldiersName.clear();

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers WHERE inVAC = 0
      ''');
      soldierNotInVAC = soldiers.map((e) => SoldierModel.fromJson(e)).toList();

      for (var value in soldierNotInVAC) {
        soldiersName.add(value.soldierName!);
        soldiersName.sort();
      }

      db.dispose();
      emit(getSoldierSuccess());
    } catch (e) {
      emit(getSoldierError());
      print(e);
    }
  }

  List<SoldierModel> soldierInVAC = [];

  void getInVAC() {
    emit(getSoldierLoading());

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers WHERE inVAC = 1
      ''');
      soldierNotInVAC = soldiers.map((e) => SoldierModel.fromJson(e)).toList();
      db.dispose();
      emit(getSoldierSuccess());
    } catch (e) {
      emit(getSoldierError());
      print(e);
    }
  }

  void updateInVAC(soldierID, value) {
    emit(updateSoldierLoading());

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        UPDATE soldiers
        SET inVAC = $value
        WHERE soldierId = "$soldierID"
      ''');
      // db.dispose();
      emit(updateSoldierSuccess());
    } catch (e) {
      emit(updateSoldierError());
      print(e);
    }
  }

  void updateIsOUT(soldierID) {
    emit(updateSoldierLoading());

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        UPDATE soldiers
        SET isOUT = 1
        WHERE soldierId = "$soldierID"
      ''');
      db.dispose();
      emit(updateSoldierSuccess());
    } catch (e) {
      emit(updateSoldierError());
      print(e);
    }
  }

  void makeVacation(
      {required soldierID,
      required fromDate,
      required toDate,
      required feedback,
      required rank,
      required name}) {
    emit(makeVacationLoading());

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        CREATE TABLE IF NOT EXISTS vacations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          soldierId TEXT NOT NULL,
          name TEXT NOT NULL,
          rank TEXT NOT NULL,
          fromDate TEXT NOT NULL,
          toDate TEXT NOT NULL,
          feedback TEXT NOT NULL
        )
      ''');
      // db.dispose();
    } catch (e) {
      print(e);
    }
    try {
      db.execute('''
        INSERT INTO vacations (
          soldierId, name, rank, fromDate, toDate, feedback
        ) VALUES (
          "$soldierID", "$name", "$rank", "$fromDate", "$toDate", "$feedback"
        )
      ''');

      updateInVAC(soldierID, 1);

      emit(makeVacationSuccess());
    } catch (e) {
      emit(makeVacationError());
      print(e);
    }finally{
      db.dispose();
    }
  }

  List<VacationModel> VacData = [];
  VacationModel? vacationModel;

  void getVacations() {
    emit(getVacationsLoading());
    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      final vacations = db.select('''
        SELECT * FROM vacations
      ''');
      VacData = vacations.map((e) => VacationModel.fromJson(e)).toList();
      db.dispose();

      final currentDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

      for (var vacation in VacData) {
        if (convertArabicToEnglish(vacation.toDate!) == currentDate) {
          updateInVAC(vacation.soldierId, 0);
        }
      }
      CacheHelper.saveData(key: 'VAC', value: VacData.length);
      emit(getVacationsSuccess());
    } catch (e) {
      emit(getVacationsError());
      print(e);
    }
  }

  void updateSoldier(
      {name,
      rank,
      phone,
      addPhone,
      birthDate,
      city,
      image,
      nationalID,
      required soldierID,
      retiringDate,
      faculty,
      spec,
      grade,
      homeAddress,
      home_num,
      father_job,
      mother_job,
      father_phone,
      mother_phone,
      num_of_siblings,
      skills,
      function,
      joinDate,
      inVAC,
      isOUT}) {
    emit(updateSoldierLoading());

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
  UPDATE soldiers
  SET
    soldierName = "$name",
    soldierRank = "$rank",
    soldierPhone = "$phone",
    soldierAddPhone = "$addPhone",
    soldierHomeAddress = "$homeAddress",
    soldierBDate = "$birthDate",
    soldierCity = "$city",
    soldierImage = "$image",
    soldierNationalId = "$nationalID",
    soldierRetireDate = "$retiringDate",
    soldierFaculty = "$faculty",
    soldierSpeciality = "$spec",
    soldierGrade = "$grade",
    soldierHomePhone = "$home_num",
    soldierFatherJob = "$father_job",
    soldierMotherJob = "$mother_job",
    soldierFatherPhone = "$father_phone",
    soldierMotherPhone = "$mother_phone",
    soldierNumOfSiblings = "$num_of_siblings",
    soldierSkills = "$skills",
    soldierFunction = "$function",
    soldierJoinDate = "$joinDate",
    inVAC = $inVAC,
    isOUT = $isOUT
  WHERE soldierId = "$soldierID"
''');
      print("Soldier updated");
      db.dispose();
      emit(updateSoldierSuccess());
    } catch (e) {
      emit(updateSoldierError());
      print(e);
    }
  }

  void deleteSoldier(soldierId) {
    emit(deleteSoldierLoading());

    final dbPath = getDatabasePath();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        DELETE FROM soldiers WHERE soldierId = "$soldierId"
      ''');
      db.dispose();
      emit(deleteSoldierSuccess());
      getSoldiers();
    } catch (e) {
      emit(deleteSoldierError());
      print(e);
    }
  }
}
