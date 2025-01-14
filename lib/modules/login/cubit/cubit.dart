import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tamam/modules/login/cubit/states.dart';
import 'package:tamam/modules/login/password_hashing.dart';
import 'package:tamam/modules/mainMenu/mainmenu_screen.dart';
import 'package:tamam/shared/components/components.dart';
import 'package:tamam/shared/components/constants.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  Future<String> initializeDatabase() async {
    // Get the application document directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocDir.path}/app_database.db';

    // Check if the database already exists
    final dbFile = File(dbPath);
    if (!await dbFile.exists()) {
      // Load the database from assets
      final byteData = await rootBundle.load('assets/app_database.db');
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



  Future<String> getDBPath() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = '${dir.path}\\Tamam\\db\\app_database.db';
    return dbPath;
  }


  // String getDatabasePath() {
  //   final dbFolder = Directory('${Directory.current.path}/db');
  //   if (!dbFolder.existsSync()) {
  //     dbFolder.createSync();
  //   }
  //   return '${dbFolder.path}/app_database.db';
  // }

  Future<void> register(String username, String password)async {
    emit(RegisterLoadingState());


    final dbPath = await getAppDatabaseFile();
    final db =  sqlite3.open(dbPath);


    try{
    db.execute('''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL,
      is_admin BOOLEAN DEFAULT 0
    )
  ''');} catch (e) {
      print(e);
    }

    final _hashedPass = PasswordHasher.hashPassword(password);



    try {
      db.execute('''
    INSERT INTO users (username, password, is_admin)
    VALUES ('$username', '$_hashedPass', 0)
  ''');
      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
      print(e);
    } finally {
      db.dispose();
    }
  }


  Future<void> userLogin({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoadingState());


    // final dbPath = getDatabasePath();
    // final db = sqlite3.open(dbPath);

    final dbPath = await getAppDatabaseFile();
    final db =  sqlite3.open(dbPath);


    try {
      final result =
          db.select('SELECT * FROM users WHERE username = ?', [username]);

      if (result.isEmpty) {
        emit(LoginErrorState('User not found.'));
        return;
      }

      final user = result.first;

      final hashedPassword = PasswordHasher.hashPassword(password);

      final bool isAdmin = user['is_admin'] == 1;

     final isCorrect = user['password'] == hashedPassword;
      if (isCorrect) {
        emit(LoginSuccessState());
        navigateAndFinish(context, MainMenuScreen(isAdmin: isAdmin));
      } else {
        emit(LoginErrorState('Incorrect password.'));
      }
    } catch (e) {
      // Handle any database or other errors
      emit(LoginErrorState('An error occurred: ${e.toString()}'));
      print(e);
    } finally {
      // Always dispose of the database to free up resources
      db.dispose();
    }
  }
}
