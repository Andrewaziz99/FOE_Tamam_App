import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tamam/models/Officers/officers_model.dart';
import 'package:tamam/modules/Officers/cubit/states.dart';

import '../../../shared/components/constants.dart';

class OfficersCubit extends Cubit<officersStates> {
  OfficersCubit() : super(officersInitialState());

  static OfficersCubit get(context) => BlocProvider.of(context);

  List<OfficersModel> officersList = [];

  Future<void> getOfficers() async {
    emit(getOfficersLoadingState());
    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    //Create Table 'Officers' if not exists
    try {
      db.execute('''
        CREATE TABLE IF NOT EXISTS Officers (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          rank TEXT NOT NULL,
          city TEXT NOT NULL,
          job TEXT NOT NULL
        )
      ''');
    } catch (e) {
      emit(getOfficersErrorState());
      print(e);
    }

    //Select all data from 'Officers' table
    try {
      final result = db.select('SELECT * FROM Officers');
      officersList.clear();
      for (var row in result) {
        officersList.add(OfficersModel.fromJson(row));
      }
      emit(getOfficersSuccessState());
      getLastVacationDate(officersList[0].officerName!);
    } catch (e) {
      emit(getOfficersErrorState());
    } finally {
      db.dispose();
    }
  }

  Future<void> registerOfficerVacation(
      List<Map<String, dynamic>> data, String startDate, String endDate) async {
    emit(registerOfficerVacationLoadingState());
    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);

    try {
      // Create Table 'OfficersVacations' if not exists
      db.execute('''
      CREATE TABLE IF NOT EXISTS OfficersVacations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        rank TEXT NOT NULL,
        city TEXT NOT NULL,
        job TEXT NOT NULL,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL,
        lastVacationDate TEXT NOT NULL
      )
    ''');
      // Get the last vacation date
      final lastVacation = db.select('''
        SELECT * FROM OfficersVacations
        WHERE name = ? AND startDate = ? AND endDate = ?
      ''', [data[0]['name'], endDate, startDate]);
      String lastVacationDate = '';
      if (lastVacation.isNotEmpty) {
        lastVacationDate = lastVacation[0]['lastVacationDate'];
      } else {
        lastVacationDate = convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));
      }

      // Use transaction for batch inserts
      db.execute('BEGIN TRANSACTION');
      try {
        for (var item in data) {
          db.execute('''
          INSERT INTO OfficersVacations (name, rank, city, job, startDate, endDate, lastVacationDate)
          VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', [
            item['name'],
            item['rank'],
            item['location'], // Make sure this matches your data
            item['job'],
            startDate,
            endDate,
            lastVacationDate
          ]);
        }
        db.execute('COMMIT');
        emit(registerOfficerVacationSuccessState());
      } catch (e) {
        db.execute('ROLLBACK');
        rethrow;
      }
    } catch (e) {
      emit(registerOfficerVacationErrorState());
      print('Error registering officer vacation: $e');
    } finally {
      db.dispose();
    }
  }

  String lastVacationDate = '';

  Future<void> getLastVacationDate(String name) async {
    final dbPath = await getSoldiersDatabaseFile();
    final db = sqlite3.open(dbPath);


    try {
      final lastVacation = db.select('''
        SELECT * FROM OfficersVacations
        WHERE name = ?
      ''', [name]);
      if (lastVacation.isNotEmpty) {
        lastVacationDate = lastVacation.last['lastVacationDate'];
        print(lastVacationDate);
      } else {
        lastVacationDate = convertToArabic(DateFormat('yyyy/MM/dd').format(DateTime.now()));
      }
    }catch (e) {}
  }

  Future<void> printMovements(
      List<Map<dynamic, dynamic>> dataList) async {
    emit(generateVacationReportLoadingState());
    try {
      // Locate and read the test template
      final appDir = await getTemplatesFolder();
      final movementFile = File('$appDir\\Officersmovements.docx');

      if (!await movementFile.exists()) {
        throw Exception("Movements file not found: ${movementFile.path}");
      }

      final movementBytes = await movementFile.readAsBytes();
      final moveDoc = await DocxTemplate.fromBytes(movementBytes);

      // Create a list of rows for the table content
      List<RowContent> allRows = [];

      final currentYear =
      convertToArabic(DateFormat('yyyy').format(DateTime.now()));

      final logoFileContent =
      await File('$appDir\\images\\logo.png').readAsBytes();

      final signatureFileContent =
      await File('$appDir\\images\\signature1.png').readAsBytes();

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
        final data = dataList[i];

        // Create a row for the current data
        final row = RowContent()
          ..add(TextContent("name", data['name']))
          ..add(TextContent("fromDate", data['startDate']))
          ..add(TextContent("toDate", data['endDate']))
          ..add(TextContent("level", data['rank']))
          ..add(TextContent("location", data['location']))
          ..add(TextContent("lastVac", lastVacationDate))
          ..add(TextContent("feedback", data['job']))
          ..add(TextContent("num", convertToArabic((i + 1).toString())));

        // Add the row to our collection
        allRows.add(row);
      }
      // Populate placeholders
      Content content = Content();
      content
        ..add(ImageContent("logo", logoFileContent))
        ..add(ImageContent("signature", signatureFileContent))
        ..add(TextContent("year", currentYear))
        ..add(TextContent("currentDate", currentDate))
        ..add(TextContent("doc_Typ", DOC_TYP))
        ..add(TextContent("day", weekday))
        ..add(TextContent("date", date))
        ..add(TextContent("space", '\n'))
        ..add(TableContent('table', allRows));

      // Generate the document for the current item
      final generatedDoc = await moveDoc.generate(content);

      if (generatedDoc != null) {
        final movements = File('$appDir\\output\\$OFFICERS_DOC_TYP $dayDate.docx');
        await movements.writeAsBytes(generatedDoc, flush: true);

        print("Document generated successfully at: ${movements.path}");

        emit(generateVacationReportSuccessState());

        final result = await OpenFilex.open(movements.path);
        print('Open file result: ${result.type}');
      } else {
        emit(generateVacationReportErrorState());
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      emit(generateVacationReportErrorState());
      print("Error: $e");
    }
  }


  Future<void> printVacationPasses(
      List<Map<dynamic, dynamic>> dataList) async {
    emit(generateVacationPassesLoadingState());
    try {
      // Load the Word template
      final appDir = await getTemplatesFolder();
      final vacationPassesFile = File('$appDir\\OfficersVacationPasses.docx');

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
          ..add(TextContent("fromDate", data['startDate']))
          ..add(TextContent("toDate", data['endDate']))
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
        final vacationPasses = File('$appDir\\output\\$OFFICER_DOC_VAC $dayDate.docx');
        await vacationPasses.writeAsBytes(generatedVacationPassesDoc);

        final result = await OpenFilex.open(vacationPasses.path);
        print('Open file result: ${result.type}');
        print("Document generated successfully at: ${vacationPasses.path}");
        emit(generateVacationPassesSuccessState());
      } else {
        emit(generateVacationPassesErrorState());
        throw Exception("Failed to generate document");
      }
    } catch (e) {
      emit(generateVacationPassesErrorState());
      print("Error: $e");
    }
  }


}