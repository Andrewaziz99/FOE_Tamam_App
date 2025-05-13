import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tamam/modules/Vacation/cubit/state.dart';

import '../../../models/Soldiers/soldier_model.dart';
import '../../../models/Vacations/vacation_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';

class VacationCubit extends Cubit<VacationState> {
  VacationCubit() : super(VacationInitial());

  static VacationCubit get(context) => BlocProvider.of(context);

  var currentDate =
  convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));

  Future<void> updateInVacation(soldierID, value) async {
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


  List<VacationModel> Vacations = [];
  Future<void> getAllVacations() async {
    emit(getAllVacationsLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final vacations = db.select('''
        SELECT * FROM vacations
      ''');
      Vacations = vacations.map((e) => VacationModel.fromJson(e)).toList();
      emit(getAllVacationsSuccess());
    } catch (e) {
      emit(getAllVacationsError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> getActiveVacations() async {
    emit(getActiveVacationsLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final vacations = db.select('''
        SELECT * FROM vacations WHERE isActive = 1
      ''');
      Vacations = vacations.map((e) => VacationModel.fromJson(e)).toList();
      emit(getActiveVacationsSuccess());
    } catch (e) {
      emit(getActiveVacationsError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> getExtendedVacations() async {
    emit(getExtendedVacationsLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final vacations = db.select('''
        SELECT * FROM vacations WHERE isExtended = 1
      ''');
      Vacations = vacations.map((e) => VacationModel.fromJson(e)).toList();
      emit(getExtendedVacationsSuccess());
    } catch (e) {
      emit(getExtendedVacationsError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> extendVacation(String id, String fromDate, String toDate, int days) async {
    emit(extendVacationLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    toDate = convertArabicToEnglish(toDate);
    days = int.parse(convertArabicToEnglish(days.toString()));



    DateFormat toDateFormat = DateFormat("yyyy/MM/dd");
    DateTime toDateDT = toDateFormat.parse(toDate);

    final extendedDate = toDateDT.add(Duration(days: days));

    final extendedDateArabic =
    convertToArabic(DateFormat("yyyy/MM/dd").format(extendedDate));

    final arabicToDate = convertToArabic(toDate);

    try {
      db.execute('''
        UPDATE vacations SET fromDate = '$arabicToDate', toDate = '$extendedDateArabic', isExtended = 1 WHERE soldierId = '$id' AND fromDate = '$fromDate' AND toDate = '$arabicToDate' AND isActive = 1
      ''');
      emit(extendVacationSuccess());
    } catch (e) {
      emit(extendVacationError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> deleteVacation(String id, String fromDate, String toDate) async {
    emit(deleteVacationLoadingState());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      db.execute('''
        DELETE FROM vacations WHERE soldierId = '$id' AND fromDate = '$fromDate' AND toDate = '$toDate'
      ''');
      emit(deleteVacationSuccessState());
      updateInVacation(id, 0);
    } catch (e) {
      emit(deleteVacationErrorState());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> stopVacation(String id, String fromDate, String toDate) async {
    emit(stopVacationLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);


    try {
      db.execute('''
        UPDATE vacations SET  toDate = '$currentDate', isActive = 0, isExtended = 0 WHERE soldierId = '$id' AND fromDate = '$fromDate' AND toDate = '$toDate'
      ''');
      emit(stopVacationSuccess());
      updateInVacation(id, 0);
    } catch (e) {
      emit(stopVacationError());
      print(e);
    } finally {
      db.dispose();
    }
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

  List<VacationModel> extendedVacations = [];
  Future<void> getExtendedVacation() async {
    emit(getExtendedVacationLoading());

    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      final vacations = db.select('''
        SELECT * FROM vacations WHERE isExtended = 1
      ''');
      extendedVacations = vacations.map((e) => VacationModel.fromJson(e)).toList();
      emit(getExtendedVacationSuccess());
    } catch (e) {
      emit(getExtendedVacationError());
      print(e);
    } finally {
      db.dispose();
    }
  }

  Future<void> createExtendDoc() async {
    try {
      // Locate and read the test template
      final appDir = await getTemplatesFolder();
      final extendsFile = File('$appDir\\extends.docx');

      if (!await extendsFile.exists()) {
        throw Exception("extends file not found: ${extendsFile.path}");
      }

      final extendsBytes = await extendsFile.readAsBytes();
      final extendsDoc = await DocxTemplate.fromBytes(extendsBytes);

      // Create a list of rows for the table content
      List<RowContent> allRows = [];

      var id = await CacheHelper.getData(key: 'id') ?? 1;

      final currentYear =
      convertToArabic(DateFormat('yyyy').format(DateTime.now()));

      final logoFileContent =
      await File('$appDir\\images\\logo.png').readAsBytes();
      final dayDate =
      convertToArabic(DateFormat('yyyy-MM-dd').format(DateTime.now()));

      final currentDate =
      convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));

      final today = DateTime.now();
      final weekday =
      getWeekDay(DateFormat('EEEE').format(today).toLowerCase());

      getExtendedVacation();
      for (int i = 0; i < extendedVacations.length; i++) {


        final data = extendedVacations[i];

        // Create a row for the current data
        final row = RowContent()
          ..add(TextContent("name", data.name))
          ..add(TextContent("fromDate", data.fromDate))
          ..add(TextContent("toDate", data.toDate))
          ..add(TextContent("level", data.rank))
          ..add(TextContent("feedback", data.feedback))
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
        ..add(TextContent("doc_Typ", DOC_EXT))
        ..add(TextContent("day", weekday))
        ..add(TextContent("date", currentDate))
        ..add(TextContent("space", '\n'))
        ..add(TableContent('table', allRows));

      // Generate the document for the current item
      final generatedDoc = await extendsDoc.generate(content);

      if (generatedDoc != null) {
        final extendsDoc = File('$appDir\\output\\$DOC_EXT $dayDate.docx');
        await extendsDoc.writeAsBytes(generatedDoc, flush: true);

        print("Document generated successfully at: ${extendsDoc.path}");

        await CacheHelper.saveData(key: 'id', value: id + 1);

        emit(genTableSuccessState());

        final result = await OpenFilex.open(extendsDoc.path);
        print('Open file result: ${result.type}');
      } else {
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


}