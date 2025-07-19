import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tamam/models/Missions/mission_model.dart';
import 'package:tamam/models/Soldiers/soldier_model.dart';
import 'package:tamam/models/Vacations/vacation_model.dart';
import 'package:tamam/modules/Soldiers/new_soldier_screen.dart';
import 'package:tamam/shared/cubit/states.dart';
import 'package:tamam/shared/network/local/cache_helper.dart';
import '../components/constants.dart';
import 'package:docx_template/docx_template.dart';

//updateInVAC ==>  0 ----> Not in Vacation,  1 ----> In Vacation

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var currentDate =
      convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));

  String? selectedValue;

  void changeSelectedValue(String value) {
    selectedValue = value;
    emit(changeSoldierData());
    getVacations();
  }

  // List<bool> isChecked = [];
  List<Map<String, dynamic>> isChecked = [];

  void updateCheckedList() {
    isChecked = List.generate(
      soldiers.length,
      (index) => {
        'id': index,
        'isChecked': false,
      },
    );
    emit(UpdateCheckedListState());
  }

  void triggerCheckBox(val, index) {
    isChecked[index]['isChecked'] = val;
    emit(triggerCheckBoxState());
  }

  void removeSoldierFromList(int index) {
    soldiers.removeAt(index);
    emit(deleteFromListSuccess());
  }

  Future<void> createMissionDoc() async {
    emit(printMissionsLoadingState());

    getTodayMissions(date: currentDate);

    try {
      // Locate and read the test template
      final appDir = await getTemplatesFolder();
      final missionsFile = File('$appDir\\Missions.docx');

      if (!await missionsFile.exists()) {
        throw Exception("Missions file not found: ${missionsFile.path}");
      }

      final missionsBytes = await missionsFile.readAsBytes();
      final missionDoc = await DocxTemplate.fromBytes(missionsBytes);

      // Create a list of rows for the table content
      List<RowContent> allRows = [];

      final logoFileContent =
          await File('$appDir\\images\\logo.png').readAsBytes();
      final dayDate =
          convertToArabic(DateFormat('yyyy-MM-dd').format(DateTime.now()));

      final currentDate =
          convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));

      final today = DateTime.now();
      final weekday =
          getWeekDay(DateFormat('EEEE').format(today).toLowerCase());

      for (int i = 0; i < missions.length; i++) {
        final data = missions[i];

        final row = RowContent()
          ..add(TextContent("name", data['soldierName']))
          ..add(TextContent("level", soldier))
          ..add(
              TextContent("job1", convertAllToArabic(data['soldierFunction1'])))
          ..add(
              TextContent("job2", convertAllToArabic(data['soldierFunction2'])))
          ..add(TextContent("num", convertToArabic((i + 1).toString())));

        allRows.add(row);
      }

      // Populate placeholders
      Content content = Content();
      content
        ..add(ImageContent("logo", logoFileContent))
        ..add(TextContent("dept_Name", office))
        ..add(TextContent("currentDate", currentDate))
        ..add(TextContent("day", weekday))
        ..add(TextContent("date", currentDate))
        ..add(TextContent("space", '\n'))
        ..add(TableContent('table', allRows));

      // Generate the document for the current item
      final generatedDoc = await missionDoc.generate(content);

      if (generatedDoc != null) {
        final mission =
            File('$appDir\\output\\$missionsConstant $dayDate.docx');
        await mission.writeAsBytes(generatedDoc, flush: true);

        print("Document generated successfully at: ${mission.path}");

        emit(printMissionsSuccessState());

        final result = await OpenFilex.open(mission.path);
        print('Open file result: ${result.type}');
      } else {
        emit(printMissionsErrorState());
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      emit(printMissionsErrorState());
      print("Error: $e");
    }
  }

  List<Map<dynamic, dynamic>> soldiers = [];

  void AddToList(index, soldierID, name, fromDate, toDate, feedBack, rank,
      location, lastVac, isSaved) {
    soldiers.add({
      'soldierID': soldierID,
      'name': name,
      'rank': rank,
      'location': location,
      'fromDate': fromDate,
      'toDate': toDate,
      'lastVac': lastVac,
      'feedback': feedBack,
      'num': index,
      'isSaved': isSaved,
    });
    emit(addToListSuccess());
  }

  void updateList(index, soldierID, name, fromDate, toDate, feedBack, rank,
      location, lastVac) {
    emit(updateListLoading());
    soldiers[index] = {
      'soldierID': soldierID,
      'name': name,
      'rank': rank,
      'fromDate': fromDate,
      'toDate': toDate,
      'feedback': feedBack,
      'num': index,
      'location': location,
      'lastVac': lastVac,
    };
    emit(updateListSuccess());
  }

  Future<void> createMOVDocFromList(
      List<Map<dynamic, dynamic>> dataList) async {
    try {
      // Locate and read the test template
      final appDir = await getTemplatesFolder();
      final movementFile = File('$appDir\\movements.docx');

      if (!await movementFile.exists()) {
        throw Exception("Movements file not found: ${movementFile.path}");
      }

      final movementBytes = await movementFile.readAsBytes();
      final moveDoc = await DocxTemplate.fromBytes(movementBytes);

      // Create a list of rows for the table content
      List<RowContent> allRows = [];

      var id = await CacheHelper.getData(key: 'id') ?? 1;

      final currentYear =
          convertToArabic(DateFormat('yyyy').format(DateTime.now()));

      final logoFileContent =
          await File('$appDir\\images\\logo.png').readAsBytes();

      final signatureFileContent =
          await File('$appDir\\images\\signature1.png').readAsBytes();

      final dayDate =
          convertToArabic(DateFormat('yyyy-MM-dd').format(DateTime.now()));

      var currentDate =
          convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));

      final tomorrow = DateTime.now().add(const Duration(days: 1));
      var weekday =
          getWeekDay(DateFormat('EEEE').format(tomorrow).toLowerCase());

      var date = convertToArabic(DateFormat('yyyy/MM/dd')
          .format(DateTime.now().add(const Duration(days: 1))));

      for (int i = 0; i < dataList.length; i++) {
        final data = dataList[i];

        //set the weekday to be the fromDate
        if (data['fromDate'] != null) {
          final fromDate = DateFormat('yyyy/MM/dd')
              .parse(convertArabicToEnglish(data['fromDate']));
          currentDate = convertToArabic(DateFormat('yyyy/MM/dd')
              .format(fromDate.subtract(const Duration(days: 1))));
          weekday =
              getWeekDay(DateFormat('EEEE').format(fromDate).toLowerCase());
          date = convertToArabic(DateFormat('yyyy/MM/dd').format(fromDate));
        }

        // Create a row for the current data
        final row = RowContent()
          ..add(TextContent("name", data['name']))
          ..add(TextContent("fromDate", data['fromDate']))
          ..add(TextContent("toDate", data['toDate']))
          ..add(TextContent("level", data['rank']))
          ..add(TextContent("location", data['location']))
          ..add(TextContent("lastVac", data['lastVac']))
          ..add(TextContent("feedback", data['feedback']))
          ..add(TextContent("num", convertToArabic((i + 1).toString())));

        // Add the row to our collection
        allRows.add(row);
      }
      // Populate placeholders
      Content content = Content();
      content
        ..add(ImageContent("logo", logoFileContent))
        ..add(ImageContent("signature", signatureFileContent))
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
      final generatedDoc = await moveDoc.generate(content);

      if (generatedDoc != null) {
        final movements = File('$appDir\\output\\$DOC_TYP $dayDate.docx');
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

  // Future<void> createExtendDoc(List<VacationModel> dataList) async {
  //   try {
  //     // Locate and read the test template
  //     final appDir = await getTemplatesFolder();
  //     final extendsFile = File('$appDir\\extends.docx');
  //
  //     if (!await extendsFile.exists()) {
  //       throw Exception("extends file not found: ${extendsFile.path}");
  //     }
  //
  //     final extendsBytes = await extendsFile.readAsBytes();
  //     final extendsDoc = await DocxTemplate.fromBytes(extendsBytes);
  //
  //     // Create a list of rows for the table content
  //     List<RowContent> allRows = [];
  //
  //     var id = await CacheHelper.getData(key: 'id') ?? 1;
  //
  //     final currentYear =
  //         convertToArabic(DateFormat('yyyy').format(DateTime.now()));
  //
  //     final logoFileContent =
  //         await File('$appDir\\images\\logo.png').readAsBytes();
  //     final dayDate =
  //         convertToArabic(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  //
  //     final currentDate =
  //         convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));
  //
  //     final today = DateTime.now();
  //     final weekday =
  //         getWeekDay(DateFormat('EEEE').format(today).toLowerCase());
  //
  //     for (int i = 0; i < dataList.length; i++) {
  //       extendVacation(
  //           soldierID: dataList[i].soldierId,
  //           fromDate: dataList[i].fromDate,
  //           toDate: dataList[i].toDate,
  //           extend: 1);
  //
  //       final data = dataList[i];
  //
  //       // Create a row for the current data
  //       final row = RowContent()
  //         ..add(TextContent("name", data.name))
  //         ..add(TextContent("fromDate", data.fromDate))
  //         ..add(TextContent("toDate", data.toDate))
  //         ..add(TextContent("level", data.rank))
  //         ..add(TextContent("feedback", data.feedback))
  //         ..add(TextContent("num", convertToArabic((i + 1).toString())));
  //
  //       // Add the row to our collection
  //       allRows.add(row);
  //     }
  //     // Populate placeholders
  //     Content content = Content();
  //     content
  //       ..add(ImageContent("logo", logoFileContent))
  //       ..add(TextContent("id", convertToArabic(id.toString())))
  //       ..add(TextContent("year", currentYear))
  //       ..add(TextContent("dept_Name", office))
  //       ..add(TextContent("currentDate", currentDate))
  //       ..add(TextContent("doc_Typ", DOC_EXT))
  //       ..add(TextContent("day", weekday))
  //       ..add(TextContent("date", currentDate))
  //       ..add(TextContent("space", '\n'))
  //       ..add(TableContent('table', allRows));
  //
  //     // Generate the document for the current item
  //     final generatedDoc = await extendsDoc.generate(content);
  //
  //     if (generatedDoc != null) {
  //       final extendsDoc = File('$appDir\\output\\$DOC_EXT $dayDate.docx');
  //       await extendsDoc.writeAsBytes(generatedDoc, flush: true);
  //
  //       print("Document generated successfully at: ${extendsDoc.path}");
  //
  //       await CacheHelper.saveData(key: 'id', value: id + 1);
  //
  //       emit(genTableSuccess());
  //
  //       final result = await OpenFilex.open(extendsDoc.path);
  //       print('Open file result: ${result.type}');
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
      final appDir = await getTemplatesFolder();
      final vacationPassesFile = File('$appDir\\VacationPasses.docx');

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
        final vacationPasses = File('$appDir\\output\\$DOC_VAC $dayDate.docx');
        await vacationPasses.writeAsBytes(generatedVacationPassesDoc);

        final result = await OpenFilex.open(vacationPasses.path);
        print('Open file result: ${result.type}');
        print("Document generated successfully at: ${vacationPasses.path}");
        emit(genTableSuccess());
      } else {
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  var error = '';

  Future<void> createTamamDoc() async {
    getAllSoldiers();
    getActiveVacations();

    if (activeVacationData.isEmpty) {
      CacheHelper.saveData(key: 'soldiersInVacation', value: 0);
      CacheHelper.saveData(key: 'capSoldiersInVacation', value: 0);
    }

    emit(TamamLoading());

    final tId = await CacheHelper.getData(key: 'T_id') ?? 1;

    List<RowContent> allRows = [];

    for (int i = 0; i < VacData.length; i++) {
      final vacationData = VacData[i];

      RowContent row = RowContent();
      row
        ..add(TextContent("name", vacationData.name))
        ..add(TextContent("fromDate", vacationData.fromDate))
        ..add(TextContent("toDate", vacationData.toDate))
        ..add(TextContent("level", vacationData.rank))
        ..add(TextContent("status", vacation))
        ..add(TextContent("num", convertToArabic((i + 1).toString())));

      allRows.add(row);
    }

    try {
      // Locate and read the test template
      final appDir = await getTemplatesFolder();
      final tamamFile = File('$appDir\\tamam1.docx');

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

      final currentYear =
          convertToArabic(DateFormat('yyyy').format(DateTime.now()));

      final logoFileContent =
          await File('$appDir\\images\\logo.png').readAsBytes();
      final signatureFileContent =
          await File('$appDir\\images\\signature1.png').readAsBytes();

      final allSoldiers =
          convertToArabic(CacheHelper.getData(key: 'ALL').toString());

      final inVacation = convertToArabic(
          (CacheHelper.getData(key: 'soldiersInVacation') +
                  CacheHelper.getData(key: 'capSoldiersInVacation'))
              .toString());

      final present = convertToArabic((CacheHelper.getData(key: 'ALL') -
              CacheHelper.getData(key: 'soldiersInVacation') -
              CacheHelper.getData(key: 'capSoldiersInVacation'))
          .toString());

      final out = convertToArabic('0');

      var soldiersInVacation = convertToArabic(
          CacheHelper.getData(key: 'soldiersInVacation').toString());

      final soldiersNumber = convertToArabic(
          CacheHelper.getData(key: 'soldiersNumber').toString());

      final capSoldiersNumber = convertToArabic(
          CacheHelper.getData(key: 'capSoldiersNumber').toString());

      final presentSoldiersNumber = convertToArabic(
          (CacheHelper.getData(key: 'soldiersNumber') -
                  CacheHelper.getData(key: 'soldiersInVacation'))
              .toString());

      final presentCapSoldiersNumber = convertToArabic(
          (CacheHelper.getData(key: 'capSoldiersNumber') -
                  CacheHelper.getData(key: 'capSoldiersInVacation'))
              .toString());

      var capSoldiersInVacation = convertToArabic(
          CacheHelper.getData(key: 'capSoldiersInVacation').toString());

      if (inVacation == convertToArabic('0')) {
        soldiersInVacation = convertToArabic('0');
        capSoldiersInVacation = convertToArabic('0');
      }

      // Populate placeholders
      Content content = Content();
      content
        ..add(ImageContent("logo", logoFileContent))
        ..add(ImageContent("signature", signatureFileContent))
        ..add(TextContent("dept_Name", office))
        ..add(TextContent("T_id", convertToArabic(tId.toString())))
        ..add(TextContent("year", currentYear))
        ..add(TextContent("currentDate", currentDate))
        ..add(TextContent("day", weekday))
        ..add(TextContent("ALL", allSoldiers))
        ..add(TextContent("PRESENT", present))
        ..add(TextContent("VAC", inVacation))
        ..add(TextContent("OUT", out))
        ..add(TextContent("SOLDIERS_NUM", soldiersNumber))
        ..add(TextContent("PRES_SOL_NUM", presentSoldiersNumber))
        ..add(TextContent("OUT_SOL_NUM", soldiersInVacation))
        ..add(TextContent("NUM_CAPS", capSoldiersNumber))
        ..add(TextContent("PRES_CAPS", presentCapSoldiersNumber))
        ..add(TextContent("OUT_CAPS", capSoldiersInVacation))
        ..add(TableContent('table', allRows))
        ..add(TextContent("space", '\n'));

      // Generate the document for the current item
      final generatedDoc = await tamamDoc.generate(content);

      if (generatedDoc != null) {
        final tamam = File('$appDir\\output\\$DOC_TAMAM $dayDate.docx');
        await tamam.writeAsBytes(generatedDoc);

        print("Document generated successfully at: ${tamam.path}");

        final result = await OpenFilex.open(tamam.path);
        print(result);

        emit(TamamSuccess());

        await CacheHelper.saveData(key: 'T_id', value: tId + 1);
      } else {
        emit(TamamError());
        error = 'Failed to generate document';
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      error = e.toString();
      emit(TamamError());
      print("Error: $e");
    }
  }

  Future<String> saveImage(File imageFile, String name) async {
    try {
      final ImagesPath = await getImagesFolder();
      // final timestamp = DateTime.now().millisecondsSinceEpoch;
      // final fileName = 'image_$timestamp.jpg';

      final imagesDir = Directory(ImagesPath);
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      final savedImage = await imageFile.copy('${imagesDir.path}/$name');
      return savedImage.path;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  var image;
  var savedImagePath;
  String imageFileName = '';

  Future<void> pickImage() async {
    emit(pickImageLoading());
    FilePicker.platform
        .pickFiles(
      type: FileType.image,
      allowMultiple: false,
    )
        .then((value) async {
      if (value != null) {
        image = value.files.first.path;
        imageFileName = value.files.first.name;
        savedImagePath = await saveImage(File(image), imageFileName);
        imageController.text = imageFileName;
        emit(pickImageSuccess());
      } else {
        emit(pickImageError());
      }
    }).catchError((error) {
      emit(pickImageError());
      print(error);
    });
  }

  Future<void> enterNewSoldier({
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
    soldierIdImage,
    soldierNationalIdImage,
  }) async {
    emit(enterNewSoldierLoading());

    final dbPath = await getSoldiersDatabaseFile();
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
        isOUT BOOL NOT NULL,
        soldierIdImage TEXT,
        soldierNationalIdImage TEXT
      )''');
    } catch (e) {
      print(e);
    }

    try {
      db.execute(''' INSERT INTO soldiers (
        soldierName, soldierRank, soldierPhone, soldierAddPhone, soldierHomeAddress, soldierBDate, soldierCity, soldierImage, soldierNationalId, soldierId, soldierRetireDate, soldierFaculty, soldierSpeciality, soldierGrade, soldierHomePhone, soldierFatherJob, soldierMotherJob, soldierFatherPhone, soldierMotherPhone, soldierNumOfSiblings, soldierSkills, soldierFunction, soldierJoinDate, inVAC, isOUT, soldierIdImage, soldierNationalIdImage
      ) VALUES (
        "$name", "$rank", "$phone", "$addPhone", "$homeAddress", "$birthDate", "$city", "$image", "$nationalID", "$soldierID", "$retiringDate", "$faculty", "$spec", "$grade", "$home_num", "$father_job", "$mother_job", "$father_phone", "$mother_phone", "$num_of_siblings", "$skills", "$function", "$joinDate", false, false, "$soldierIdImage", "$soldierNationalIdImage"
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

  Future<void> getAllSoldiers() async {
    emit(getAllSoldiersLoading());
    soldiersName.clear();

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers
      ''');
      soldiersList = soldiers.map((e) => SoldierModel.fromJson(e)).toList();

      if (soldiersList.isEmpty) {
        CacheHelper.saveData(key: 'ALL', value: 0);
        CacheHelper.saveData(key: 'soldiersNumber', value: 0);
        CacheHelper.saveData(key: 'capSoldiersNumber', value: 0);
        CacheHelper.saveData(key: 'soldiersInVacation', value: 0);
        CacheHelper.saveData(key: 'capSoldiersInVacation', value: 0);
      }

      int soldiersNum = 0;
      int capSoldiersNum = 0;

      for (var value in soldiersList) {
        soldiersName.add(value.soldierName!);
        soldiersName.sort();

        if (value.soldierRank == 'جندى') {
          soldiersNum++;
        } else {
          capSoldiersNum++;
        }
        CacheHelper.saveData(key: 'soldiersNumber', value: soldiersNum);
        CacheHelper.saveData(key: 'capSoldiersNumber', value: capSoldiersNum);
      }
      CacheHelper.saveData(key: 'ALL', value: soldiersList.length);

      emit(getAllSoldiersSuccess());
    } catch (e) {
      emit(getAllSoldiersError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  SoldierModel? soldierModel;

  Future<void> getSoldierById(soldierID) async {
    emit(getSoldierByIdLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers WHERE soldierId = "$soldierID"
      ''');
      soldierModel = SoldierModel.fromJson(soldiers.first);
      emit(getSoldierByIdSuccess());
    } catch (e) {
      emit(getSoldierByIdError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  List<SoldierModel> soldiers_data = [];

  Future<void> getSoldiersWhere(condition) async {
    emit(getAllSoldiersLoading());
    soldiers_data.clear();

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers WHERE $condition
      ''');
      soldiers_data = soldiers.map((e) => SoldierModel.fromJson(e)).toList();
      emit(getAllSoldiersSuccess());
    } catch (e) {
      emit(getAllSoldiersError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  List<SoldierModel> soldierNotInVAC = [];

  Future<void> getSoldiersNotInVAC() async {
    emit(getSoldierByIdLoading());

    soldiersName.clear();

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers WHERE inVAC = 0 AND soldierRank = "جندى"
      ''');
      soldierNotInVAC = soldiers.map((e) => SoldierModel.fromJson(e)).toList();

      for (var value in soldierNotInVAC) {
        soldiersName.add(value.soldierName!);
        soldiersName.sort();
      }

      db.dispose();
      emit(getSoldierByIdSuccess());
    } catch (e) {
      emit(getSoldierByIdError());
      print(e);
    }
  }

  Future<void> getAllNotInVAC() async {
    emit(getSoldierByIdLoading());

    soldiersName.clear();

    final dbPath = await getSoldiersDatabaseFile();
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
      emit(getSoldierByIdSuccess());
    } catch (e) {
      emit(getSoldierByIdError());
      print(e);
    }
  }

  List<SoldierModel> soldierInVAC = [];

  Future<void> getInVAC() async {
    emit(getSoldierByIdLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final soldiers = db.select('''
        SELECT * FROM soldiers WHERE inVAC = 1
      ''');
      soldierNotInVAC = soldiers.map((e) => SoldierModel.fromJson(e)).toList();

      db.dispose();
      emit(getSoldierByIdSuccess());
    } catch (e) {
      emit(getSoldierByIdError());
      print(e);
    }
  }

  Future<void> updateInVAC(soldierID, value) async {
    emit(updateSoldierLoading());

    final dbPath = await getSoldiersDatabaseFile();
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

  Future<void> updateIsExtended(soldierID, value) async {
    emit(updateIsExtendedLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        UPDATE vacations
        SET isExtended = $value
        WHERE soldierId = "$soldierID"
      ''');
      // db.dispose();
      emit(updateIsExtendedSuccess());
    } catch (e) {
      emit(updateIsExtendedError());
      print(e);
    }
  }

  Future<void> updateIsOUT(soldierID) async {
    emit(updateSoldierLoading());

    final dbPath = await getSoldiersDatabaseFile();
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

  Future<void> makeVacation(
      {required soldierID,
      required fromDate,
      required toDate,
      required city,
      required lastVac,
      required feedback,
      required rank,
      required name}) async {
    emit(makeVacationLoading());

    final dbPath = await getSoldiersDatabaseFile();
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
          city TEXT,
          lastVac TEXT,
          feedback TEXT NOT NULL,
          isExtended INTEGER NOT NULL,
          isActive INTEGER NOT NULL    
        )
      ''');
      // db.dispose();
    } catch (e) {
      print(e);
    }
    final DateTime today = DateTime.now();

    final fromDateDateTime =
        DateFormat('yyyy/MM/dd').parse(convertArabicToEnglish(fromDate));
    final toDateDateTime =
        DateFormat('yyyy/MM/dd').parse(convertArabicToEnglish(toDate));

    bool isActive = true;

    if (fromDateDateTime.isAfter(today) && toDateDateTime.isAfter(today)) {
      isActive = false;
    }

    try {
      db.execute(
          ''' INSERT INTO vacations (soldierId, name, rank, fromDate, toDate, feedback, isExtended, isActive, city, lastVac) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ''',
          [
            soldierID,
            name,
            rank,
            fromDate,
            toDate,
            feedback,
            0,
            isActive,
            city,
            lastVac
          ]);

      emit(makeVacationSuccess());
      updateInVAC(soldierID, 1);
    } catch (e) {
      emit(makeVacationError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  List<VacationModel> VacData = [];

  Future<void> getVacations() async {
    emit(getVacationsLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final vacations = db.select('''
        SELECT * FROM vacations
      ''');
      VacData = vacations.map((e) => VacationModel.fromJson(e)).toList();

      final DateTime today = DateTime.now();
      for (var vacation in VacData) {
        final fromDateDateTime = DateFormat('yyyy/MM/dd')
            .parse(convertArabicToEnglish(vacation.fromDate!));
        if (fromDateDateTime.compareTo(today) == 0) {
          updateActiveVacationFor(soldierId: vacation.soldierId, isActive: 1);
          updateInVAC(vacation.soldierId, 1);
        }
      }

      emit(getVacationsSuccess());
    } catch (e) {
      emit(getVacationsError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> updateVacation({
    required soldierID,
    required oldFromDate,
    required oldToDate,
    required oldFeedback,
    required newFromDate,
    required newToDate,
    required newFeedback,
  }) async {
    emit(updateVacationLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        UPDATE vacations
        SET fromDate = ?, toDate = ?, feedback = ?
        WHERE soldierId = ? AND fromDate = ? AND toDate = ? AND feedBack = ? AND isActive = 1
      ''', [
        newFromDate,
        newToDate,
        newFeedback,
        soldierID,
        oldFromDate,
        oldToDate,
        oldFeedback
      ]);
      emit(updateVacationSuccessState());
      getVacations();
    } catch (e) {
      emit(updateVacationErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> updateActiveVacation({required isActive}) async {
    emit(updateActiveVacationLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        UPDATE vacations
        SET isActive = ?
      ''', [isActive]);
      emit(updateActiveVacationSuccessState());
    } catch (e) {
      emit(updateActiveVacationErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> updateActiveVacationFor(
      {required soldierId, required isActive}) async {
    emit(updateActiveVacationForLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        UPDATE vacations
        SET isActive = ?
        WHERE soldierId = '$soldierId'
      ''', [isActive]);
      emit(updateActiveVacationForSuccessState());
    } catch (e) {
      emit(updateActiveVacationForErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  // Future<void> getExtendedVacations() async {
  //   emit(getExtendedVacationLoadingState());
  //
  //   final dbPath = await getSoldiersDatabaseFile();
  //   final db = sqlite3.open(dbPath);
  //
  //   try {
  //     final vacations = db.select('''
  //       SELECT * FROM vacations WHERE isExtended = 1
  //     ''');
  //     VacData = vacations.map((e) => VacationModel.fromJson(e)).toList();
  //
  //     emit(getExtendedVacationSuccessState());
  //   } catch (e) {
  //     emit(getExtendedVacationErrorState());
  //     print(e);
  //   } finally {
  //     db.dispose();
  //   }
  // }

  List<VacationModel> activeVacationData = [];

  Future<void> getActiveVacations() async {
    emit(getActiveVacationsLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);
    db.createFunction(
      functionName: 'convertArabicToEnglish',
      argumentCount: const AllowedArgumentCount(1),
      deterministic: true,
      function: (args) {
        final text = args[0] as String;
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
        return text.split('').map((char) => arabicDigits[char] ?? char).join();
      },
    );

    final DateTime today = DateTime.now();
    final todayYMD = DateFormat('yyyy/MM/dd').format(today);

    try {
      final vacations = db.select(
        '''
  SELECT *
  FROM vacations
  WHERE isActive = 1
     OR convertArabicToEnglish(fromDate) >= ?
  ''',
        [todayYMD],
      );
      activeVacationData =
          vacations.map((e) => VacationModel.fromJson(e)).toList();
      VacData = vacations.map((e) => VacationModel.fromJson(e)).toList();

      int soldiersInVacation = 0;
      int capSoldiersInVacation = 0;

      for (var vacation in activeVacationData) {
        if (vacation.rank == 'جندى') {
          soldiersInVacation++;
        } else {
          capSoldiersInVacation++;
        }

        CacheHelper.saveData(
            key: 'soldiersInVacation', value: soldiersInVacation);
        CacheHelper.saveData(
            key: 'capSoldiersInVacation', value: capSoldiersInVacation);

        DateTime vacationDate = DateFormat('yyyy/MM/dd')
            .parse(convertArabicToEnglish(vacation.toDate!));

        // check if vacation is before now
        if (today.isAfter(vacationDate)) {
          updateActiveVacationFor(soldierId: vacation.soldierId, isActive: 0);
          updateInVAC(vacation.soldierId, 0);
          updateIsExtended(vacation.soldierId, 0);
        }
      }
      emit(getActiveVacationsSuccessState());
    } catch (e) {
      emit(getActiveVacationsErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> getVacationsByName(SoldierName) async {
    emit(getVacationsLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final vacations = db.select('''
        SELECT * FROM vacations WHERE name = ?
      ''', [SoldierName]);
      VacData = vacations.map((e) => VacationModel.fromJson(e)).toList();

      final currentDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

      // for (var vacation in VacData) {
      //   if (convertArabicToEnglish(vacation.toDate!) == currentDate) {
      //     updateInVAC(vacation.soldierId, 0);
      //   }
      // }

      emit(getVacationsSuccess());
    } catch (e) {
      emit(getVacationsError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  // Future<void> extendVacation({
  //   required soldierID,
  //   required fromDate,
  //   required toDate,
  //   required extend,
  // }) async {
  //   emit(extendVacationLoadingState());
  //
  //   final dbPath = await getSoldiersDatabaseFile();
  //   final db = sqlite3.open(dbPath);
  //
  //   toDate = convertArabicToEnglish(toDate);
  //   extend = convertArabicToEnglish(extend);
  //
  //   DateFormat toDateFormat = DateFormat("yyyy/MM/dd");
  //   DateTime toDateDT = toDateFormat.parse(toDate);
  //
  //   final extendedDate = toDateDT.add(Duration(days: int.parse(extend)));
  //
  //   final extendedDateArabic =
  //       convertToArabic(DateFormat("yyyy/MM/dd").format(extendedDate));
  //
  //   try {
  //     final arabicToDate = convertToArabic(toDate);
  //
  //     db.execute('''
  //       UPDATE vacations
  //       SET toDate = '$extendedDateArabic', isExtended = 1
  //       WHERE soldierId = '$soldierID' AND toDate = '$arabicToDate' AND isActive = 1
  //     ''');
  //
  //     db.dispose();
  //
  //     emit(extendVacationSuccessState());
  //   } catch (e) {
  //     emit(extendVacationErrorState());
  //     print('Error extending vacation: $e');
  //   }
  // }

  // Future<void> stopVacation(
  //     {required soldierID, required fromDate, required toDate}) async {
  //   emit(StopVacationLoadingState());
  //
  //   final dbPath = await getSoldiersDatabaseFile();
  //   final db = sqlite3.open(dbPath);
  //
  //   final currentDate =
  //       convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));
  //   updateActiveVacationFor(soldierId: soldierID, isActive: 0);
  //   updateInVAC(soldierID, 0);
  //
  //   try {
  //     db.execute('''
  //       UPDATE vacations
  //       SET toDate = ?, isExtended = 0
  //       WHERE soldierId = '$soldierID' AND isActive = 1 AND fromDate = '$fromDate' AND toDate = '$toDate'
  //     ''', [currentDate]);
  //
  //     emit(StopVacationSuccessState());
  //
  //     getAllSoldiers();
  //     getActiveVacations();
  //     getVacations();
  //   } catch (e) {
  //     emit(StopVacationErrorState());
  //     print(e);
  //   } finally {
  //     db.dispose();
  //   }
  // }

  Future<void> updateSoldier(
      {id,
      name,
      rank,
      phone,
      addPhone,
      birthDate,
      city,
      image,
      required soldierID,
      nationalID,
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
      soldierIdImage,
      soldierNationalIdImage}) async {
    emit(updateSoldierLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
  UPDATE soldiers
  SET
    soldierName = "$name",
    soldierRank = "$rank",
    soldierPhone = "$phone",
    soldierAddPhone = "$addPhone",
    soldierId = "$soldierID",
    soldierNationalId = "$nationalID",
    soldierHomeAddress = "$homeAddress",
    soldierBDate = "$birthDate",
    soldierCity = "$city",
    soldierImage = "$image",
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
    soldierIdImage = "$soldierIdImage",
    soldierNationalIdImage = "$soldierNationalIdImage"
  WHERE id = "$id"
''');
      db.dispose();
      emit(updateSoldierSuccess());
      getAllSoldiers();
    } catch (e) {
      emit(updateSoldierError());
      print(e);
    }
  }

  Future<void> deleteSoldier(soldierId) async {
    emit(deleteSoldierLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      // Start a transaction to ensure both deletes succeed or both fail
      db.execute('BEGIN TRANSACTION');

      // Delete from first table
      db.execute('''
      DELETE FROM soldiers WHERE soldierId = ?
    ''', [soldierId]);

      // Delete from second table
      db.execute('''
      DELETE FROM vacations WHERE soldierId = ?
    ''', [soldierId]);

      // Commit the transaction
      db.execute('COMMIT');

      db.dispose();
      emit(deleteSoldierSuccess());
      getAllSoldiers();
    } catch (e) {
      // Rollback on error
      db.execute('ROLLBACK');
      emit(deleteSoldierError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  // Future<void> deleteVacation(soldierId, fromDate, toDate) async {
  //   emit(deleteVacationLoadingState());
  //
  //   final dbPath = await getSoldiersDatabaseFile();
  //   final db = sqlite3.open(dbPath);
  //
  //   try {
  //     db.execute('''
  //     DELETE FROM vacations WHERE soldierId = ? AND fromDate = ? AND toDate = ?
  //   ''', [soldierId, fromDate, toDate]);
  //     emit(deleteVacationSuccessState());
  //     updateInVAC(soldierId, 0);
  //     getVacations();
  //   } catch (e) {
  //     emit(deleteVacationErrorState());
  //     print(e);
  //   } finally {
  //     db.dispose();
  //   }
  // }

  List<Map<dynamic, dynamic>> missionsData = [];

  void setMissions(soldierId, soldierName, soldierFunction1, soldierFunction2) {
    missionsData.add({
      'soldierId': soldierId,
      'soldierName': soldierName,
      'soldierFunction1': soldierFunction1,
      'soldierFunction2': soldierFunction2,
    });
    print(missionsData);
    emit(setMissionSuccess());
  }

  int difference = 0;

  void calculateDifference({required soldierId, required toDate}) {
    emit(calculateDifferenceLoadingState());

    try {
      DateFormat format = DateFormat("yyyy/MM/dd");

      DateTime toDateDT = format.parse(convertArabicToEnglish(toDate));

      DateTime currentDateDT =
          format.parse(convertArabicToEnglish(currentDate));

      difference = currentDateDT.difference(toDateDT).inDays;

      emit(calculateDifferenceSuccessState());
    } catch (error) {
      emit(calculateDifferenceErrorState());
      print(error);
    }
  }

  VacationModel? lastVacation;

  Future<void> getLastVacationFor({required soldierName}) async {
    emit(getLastVacationForLoadingState());
    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final vacations = db.select('''
        SELECT * FROM vacations WHERE name = ?
      ''', [soldierName]);

      lastVacation =
          vacations.map((e) => VacationModel.fromJson(e)).toList().last;

      emit(getLastVacationForSuccessState());
    } catch (error) {
      emit(getLastVacationForErrorState());
      print(error);
    }
  }

  var soldierIdImage;
  var soldierIdImageName;
  var savedSoldierIdImagePath;

  Future<void> pickSoldierIdImage() async {
    emit(pickSoldierIdImageLoading());
    FilePicker.platform
        .pickFiles(
      type: FileType.image,
      allowMultiple: false,
    )
        .then((value) async {
      if (value != null) {
        soldierIdImage = value.files.first.path;
        soldierIdImageName = value.files.first.name;
        savedSoldierIdImagePath =
            await saveImage(File(soldierIdImage), soldierIdImageName);
        soldierIdImageController.text = soldierIdImageName;
        emit(pickSoldierIdImageSuccess());
      } else {
        emit(pickSoldierIdImageError());
      }
    }).catchError((error) {
      emit(pickSoldierIdImageError());
      print(error);
    });
  }

  var soldierNationalIdImage;
  var soldierNationalIdImageName;
  var savedSoldierNationalIdImagePath;

  Future<void> pickSoldierNationalIdImage() async {
    emit(pickSoldierNationalIdImageLoading());
    FilePicker.platform
        .pickFiles(
      type: FileType.image,
      allowMultiple: false,
    )
        .then((value) async {
      if (value != null) {
        soldierNationalIdImage = value.files.first.path;
        soldierNationalIdImageName = value.files.first.name;
        savedSoldierNationalIdImagePath = await saveImage(
            File(soldierNationalIdImage), soldierNationalIdImageName);
        soldierNationalIdImageController.text = soldierNationalIdImageName;
        emit(pickSoldierNationalIdImageSuccess());
      } else {
        emit(pickSoldierNationalIdImageError());
      }
    }).catchError((error) {
      emit(pickSoldierNationalIdImageError());
      print(error);
    });
  }

  Future<void> updateSoldierImage(
      {required soldierId, required imagePath}) async {
    emit(updateSoldierImageLoading());
    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
  UPDATE soldiers
  SET
    soldierImage = "$imagePath"
  WHERE soldierId = "$soldierId"
''');
      db.dispose();
      emit(updateSoldierImageSuccess());
      getAllSoldiers();
    } catch (e) {
      emit(updateSoldierImageError());
      print(e);
    }
  }

  Future<void> addMissions(
      {required soldierId,
      required soldierName,
      required soldierFunction1,
      required soldierFunction2}) async {
    emit(addMissionLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        CREATE TABLE IF NOT EXISTS missions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          soldierId TEXT NOT NULL,
          soldierName TEXT NOT NULL,
          soldierFunction1 TEXT NOT NULL,
          soldierFunction2 TEXT NOT NULL,
          date TEXT NOT NULL
        )
      ''');
    } catch (e) {
      emit(addMissionErrorState());
      print(e);
    }

    try {
      db.execute('''
        INSERT INTO missions (soldierId, soldierName, soldierFunction1, soldierFunction2, date)
        VALUES (?, ?, ?, ?, ?)
      ''', [
        soldierId,
        soldierName,
        soldierFunction1,
        soldierFunction2,
        currentDate
      ]);
      emit(addMissionSuccessState());
    } catch (e) {
      emit(addMissionErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  List<Map<dynamic, dynamic>> missions = [];

  Future<void> getMissions() async {
    emit(getMissionsLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final mission = db.select('''
        SELECT * FROM missions
      ''');
      missions = mission.map((e) => e).toList();
      emit(getMissionsSuccessState());
    } catch (e) {
      emit(getMissionsErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  MissionModel? soldierMissions;

  Future<void> getMissionsById({required soldierId}) async {
    emit(getMissionsByIdLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final mission = db.select('''
        SELECT * FROM missions WHERE soldierId = ? AND date = ?
      ''', [soldierId, currentDate]);
      soldierMissions = MissionModel.fromJson(mission.first);
      emit(getMissionsByIdSuccessState());
    } catch (e) {
      emit(getMissionsByIdErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> getTodayMissions({required date}) async {
    emit(getTodayMissionsLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final mission = db.select('''
        SELECT * FROM missions WHERE date = ?
      ''', [date]);
      missions = mission.map((e) => e).toList();
      emit(getTodayMissionsSuccessState());
    } catch (e) {
      emit(getTodayMissionsErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> dropMissionTable() async {
    emit(deleteMissionLoadingState());
    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        DROP TABLE missions
      ''');
      print('Table dropped');
      emit(deleteMissionSuccessState());
    } catch (e) {
      print(e);
      emit(deleteMissionErrorState());
    } finally {
      db.dispose();
    }
  }
}
