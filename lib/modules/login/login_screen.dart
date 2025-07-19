import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamam/shared/components/components.dart';
import 'package:tamam/shared/components/constants.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final  TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {

        if (state is LoginErrorState || state is RegisterErrorState) {
          CherryToast.error(
            textDirection: TextDirection.rtl,
            title: const Text(loginError),
            enableIconAnimation: true,
            animationDuration: const Duration(milliseconds: 500),
            autoDismiss: true,
            animationType: AnimationType.fromTop,
            toastPosition: Position.top,
            toastDuration: const Duration(seconds: 5),
          ).show(context);
        }

        if (state is LoginSuccessState || state is RegisterSuccessState) {
          CherryToast.success(
            textDirection: TextDirection.rtl,
            title: const Text(loginSuccess),
            enableIconAnimation: true,
            animationDuration: const Duration(milliseconds: 500),
            autoDismiss: true,
            animationType: AnimationType.fromTop,
            toastPosition: Position.top,
            toastDuration: const Duration(seconds: 5),
          ).show(context);
        }

      },
      builder: (BuildContext context, Object? state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(appTitle,
                style: TextStyle(fontSize: 25.0, color: Colors.white)),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  pickAppDatabaseFile();
                },
                icon: const Icon(Icons.file_open_rounded),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/background1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 500.0),
                    child: Center(
                      child: ConditionalBuilder(
                          condition: state is! LoginLoadingState || state is! RegisterLoadingState,
                          builder: (BuildContext context) => SizedBox(
                            width: 400.0,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(msg),
                                  defaultFormField(
                                      radius: BorderRadius.circular(15.0),
                                      controller: userNameController,
                                      type: TextInputType.text,
                                      label: username,
                                      textDirection: TextDirection.rtl,
                                      textColor: Colors.white,
                                      labelColor: Colors.white,
                                      labelSize: 20.0,
                                      textSize: 20.0,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return usernameError;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 20),
                                  defaultFormField(
                                      radius: BorderRadius.circular(15.0),
                                      controller: passwordController,
                                      type: TextInputType.text,
                                      label: password,
                                      textDirection: TextDirection.rtl,
                                      textColor: Colors.white,
                                      labelColor: Colors.white,
                                      labelSize: 20.0,
                                      textSize: 20.0,
                                      isPassword: true,
                                      onSubmit: (value) {
                                        if (value.isEmpty) {
                                          return passwordError;
                                        }

                                        if (_formKey.currentState!.validate()) {
                                          cubit.userLogin(context: context,
                                              username: userNameController.text,
                                              password: convertArabicToEnglish(passwordController.text));

                                        }

                                      },
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return passwordError;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 20),
                                  defaultButton(
                                    function: () {

                                      if (_formKey.currentState!.validate()) {
                                        cubit.userLogin(context: context,
                                            username: userNameController.text,
                                            password: convertArabicToEnglish(passwordController.text));
                                      }

                                    },
                                    text: login,
                                    fSize: 20.0,
                                    radius: 15.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          fallback: (BuildContext context) => const Center(
                                child: CircularProgressIndicator(),
                              )),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
