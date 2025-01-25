import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite3/open.dart';
import 'package:tamam/modules/login/login_screen.dart';
import 'package:tamam/shared/bloc_observer.dart';
import 'package:tamam/modules/login/cubit/cubit.dart';
import 'package:tamam/shared/network/local/cache_helper.dart';

import 'shared/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  open.overrideFor(OperatingSystem.windows, () {
    return DynamicLibrary.open('lib/sqlite3.dll');
    });
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context) => LoginCubit(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        theme: lightTheme,
        home: LoginScreen(),
    ),
  );
}

}