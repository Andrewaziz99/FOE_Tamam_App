import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamam/modules/Missions/missions_screen.dart';
import 'package:tamam/modules/Soldiers/new_soldier_screen.dart';
import 'package:tamam/modules/Soldiers/view_screen.dart';
import 'package:tamam/modules/Vacation/moves_screen.dart';
import 'package:tamam/modules/login/cubit/cubit.dart';
import 'package:tamam/modules/login/cubit/states.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';
import 'package:tamam/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../Vacation/vacation_screen.dart';

class MainMenuScreen extends StatelessWidget {
  final isAdmin;
  final userName;

  MainMenuScreen({super.key, userName, isAdmin})
      : isAdmin = isAdmin,
        userName = userName;

  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmNewPassController =
      TextEditingController();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController isAdminController = TextEditingController(text: '0');

  final _formKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getAllSoldiers()
        ..getVacations(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          var cubit = AppCubit.get(context);
          var loginCubit = LoginCubit.get(context);
          if (loginCubit.state is changePasswordErrorState) {
            oldPassController.clear();
            newPassController.clear();
            confirmNewPassController.clear();
            CherryToast.error(
              textDirection: TextDirection.rtl,
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: const Text(passwordCheckError),
            ).show(context);
          }

          if (loginCubit.state is changePasswordSuccessState) {
            oldPassController.clear();
            newPassController.clear();
            confirmNewPassController.clear();
            CherryToast.success(
              textDirection: TextDirection.rtl,
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: const Text(passwordChangedSuccess),
            ).show(context);
          }

          if (state is pickImageSuccess) {
            imageController.text = cubit.savedImagePath;
            CherryToast.success(
              textDirection: TextDirection.rtl,
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: const Text(imagePickSuccess),
            ).show(context);
          }

          if (state is enterNewSoldierError) {
            CherryToast.error(
              textDirection: TextDirection.rtl,
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: const Text(soldierAddError),
            ).show(context);
          }

          if (state is enterNewSoldierSuccess) {
            imageController.clear();
            nameController.clear();
            rankController.clear();
            phoneController.clear();
            addPhoneController.clear();
            birthDateController.clear();
            cityController.clear();
            nationalIDController.clear();
            soldierIDController.clear();
            retiringDateController.clear();
            facultyController.clear();
            specController.clear();
            gradeController.clear();
            homeAddressController.clear();
            home_numController.clear();
            father_jobController.clear();
            mother_jobController.clear();
            father_phoneController.clear();
            mother_phoneController.clear();
            num_of_siblingsController.clear();
            skillsController.clear();
            functionController.clear();
            joinDateController.clear();
            Navigator.pop(context);

            CherryToast.success(
              textDirection: TextDirection.rtl,
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: const Text(soldierAddSuccess),
            ).show(context);
          }

          if (state is TamamSuccess) {
            CherryToast.success(
              textDirection: TextDirection.rtl,
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: const Text(tamamSuccess),
            ).show(context);
          }

          if (state is TamamError) {
            CherryToast.error(
              textDirection: TextDirection.rtl,
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: Text(cubit.error),
            ).show(context);
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.5,
              title: const Text(appTitle,
                  style: TextStyle(fontSize: 25.0, color: Colors.white)),
              centerTitle: true,
              actions: [
                IconButton(
                  tooltip: 'Set DB Path',
                  onPressed: () {
                    pickSoldiersDatabaseFile();
                  },
                  icon: const Icon(Icons.file_open_rounded),
                ),
                IconButton(
                  tooltip: 'Set Templates Path',
                  onPressed: () {
                    pickTemplatesFolder();
                  },
                  icon: const Icon(Icons.document_scanner_rounded),
                ),
                IconButton(
                  tooltip: 'Set Images Path',
                  onPressed: () {
                    pickImagesFolder();
                  },
                  icon: const Icon(Icons.folder_open_rounded),
                ),
                IconButton(
                    tooltip: settings,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(
                                Icons.password,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white70,
                              content: Form(
                                key: _formKey,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(changePass),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        defaultFormField(
                                            isPassword: true,
                                            radius: BorderRadius.circular(20.0),
                                            textDirection: TextDirection.rtl,
                                            controller: oldPassController,
                                            type: TextInputType.text,
                                            label: oldPass,
                                            labelColor: Colors.black,
                                            textColor: Colors.black,
                                            validate: (val) {
                                              if (val!.isEmpty) {
                                                return passwordError;
                                              } else {
                                                return null;
                                              }
                                            }),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        defaultFormField(
                                            isPassword: true,
                                            radius: BorderRadius.circular(20.0),
                                            textDirection: TextDirection.rtl,
                                            controller: newPassController,
                                            type: TextInputType.text,
                                            label: newPass,
                                            labelColor: Colors.black,
                                            textColor: Colors.black,
                                            validate: (val) {
                                              if (val!.isEmpty) {
                                                return passwordError;
                                              } else {
                                                return null;
                                              }
                                            }),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        defaultFormField(
                                            onSubmit: (val) {
                                              var loginCubit =
                                                  LoginCubit.get(context);
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                loginCubit.changePassword(
                                                    context: context,
                                                    username: userName,
                                                    oldPassword:
                                                        oldPassController.text,
                                                    newPassword:
                                                        newPassController.text);
                                                Navigator.pop(context);
                                              }
                                            },
                                            isPassword: true,
                                            radius: BorderRadius.circular(20.0),
                                            textDirection: TextDirection.rtl,
                                            controller:
                                                confirmNewPassController,
                                            type: TextInputType.text,
                                            label: confirmNewPass,
                                            labelColor: Colors.black,
                                            textColor: Colors.black,
                                            validate: (val) {
                                              if (val !=
                                                  newPassController.text) {
                                                return passwordsNotMatched;
                                              } else if (val!.isEmpty) {
                                                return passwordError;
                                              } else {
                                                return null;
                                              }
                                            }),
                                        const SizedBox(
                                          height: 50.0,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Form(
                                                  key: _registerFormKey,
                                                  child: AlertDialog(
                                                    backgroundColor:
                                                        Colors.white70,
                                                    title:
                                                        const Text(createAccount),
                                                    content: Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          defaultFormField(
                                                              radius: BorderRadius
                                                                  .circular(20.0),
                                                              prefix:
                                                                  Icons.person,
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              labelColor:
                                                                  Colors.black,
                                                              textColor:
                                                                  Colors.black,
                                                              controller:
                                                                  userNameController,
                                                              type: TextInputType
                                                                  .text,
                                                              label: username,
                                                              validate: (val) {
                                                                if (val!
                                                                    .isEmpty) {
                                                                  return usernameError;
                                                                } else {
                                                                  return null;
                                                                }
                                                              }),
                                                          const SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          defaultFormField(
                                                              isPassword: true,
                                                              radius: BorderRadius
                                                                  .circular(20.0),
                                                              prefix: Icons
                                                                  .password_rounded,
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              labelColor:
                                                                  Colors.black,
                                                              textColor:
                                                                  Colors.black,
                                                              controller:
                                                                  passwordController,
                                                              type: TextInputType
                                                                  .text,
                                                              label: password,
                                                              validate: (val) {
                                                                if (val!
                                                                    .isEmpty) {
                                                                  return passwordError;
                                                                } else {
                                                                  return null;
                                                                }
                                                              }),
                                                          const SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          defaultFormField(
                                                              radius: BorderRadius
                                                                  .circular(20.0),
                                                              prefix: Icons
                                                                  .add_moderator_rounded,
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              labelColor:
                                                                  Colors.black,
                                                              textColor:
                                                                  Colors.redAccent,
                                                              controller:
                                                                  isAdminController,
                                                              type: TextInputType
                                                                  .text,
                                                              label: admin,
                                                              validate: (val) {
                                                                if (val!
                                                                    .isEmpty) {
                                                                  return adminError;
                                                                } else {
                                                                  return null;
                                                                }
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      defaultButton(
                                                          function: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          text: back,
                                                          radius: 25.0,
                                                          width: 450.0,
                                                          fSize: 25.0,
                                                          tColor: Colors.white,
                                                          background:
                                                              Colors.black),
                                                      const SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      defaultButton(
                                                          function: () {
                                                            var loginCubit =
                                                                LoginCubit.get(
                                                                    context);

                                                              if (_registerFormKey.currentState!.validate()) {
                                                                loginCubit.register(
                                                                    username:
                                                                        userNameController
                                                                            .text,
                                                                    password:
                                                                        passwordController
                                                                            .text,
                                                                    isAdmin: int.parse(
                                                                        isAdminController
                                                                            .text));
                                                              }
                                                          },
                                                          text: register,
                                                          radius: 25.0,
                                                          width: 450.0,
                                                          fSize: 25.0,
                                                          tColor: Colors.white,
                                                          background:
                                                              Colors.green),
                                                    ],
                                                    actionsAlignment:
                                                        MainAxisAlignment.center,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            createAccount,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                defaultButton(
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                    text: back,
                                    radius: 25.0,
                                    width: 450.0,
                                    fSize: 25.0,
                                    tColor: Colors.white,
                                    background: Colors.black),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                defaultButton(
                                    function: () {
                                      var loginCubit = LoginCubit.get(context);
                                      if (_formKey.currentState!.validate()) {
                                        loginCubit.changePassword(
                                            context: context,
                                            username: userName,
                                            oldPassword: oldPassController.text,
                                            newPassword:
                                                newPassController.text);
                                        Navigator.pop(context);
                                      }
                                    },
                                    text: save,
                                    radius: 25.0,
                                    width: 450.0,
                                    fSize: 25.0,
                                    tColor: Colors.white,
                                    background: Colors.green),
                              ],
                              actionsAlignment: MainAxisAlignment.center,
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Colors.black,
                    )),
                IconButton(
                  tooltip: logout,
                  icon: const Icon(Icons.logout, color: Colors.red),
                  onPressed: () {
                    logOut(context);
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isAdmin == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // defaultButton(
                              //   fSize: 20.0,
                              //   radius: 20.0,
                              //   width: 250.0,
                              //   text: newUserBtn,
                              //   function: () {
                              //     showModalBottomSheet(
                              //         context: context,
                              //         builder: (context) {
                              //           return Container(
                              //             width: double.infinity,
                              //             decoration: const BoxDecoration(
                              //               color: Colors.white,
                              //               borderRadius: BorderRadius.only(
                              //                 topLeft: Radius.circular(20.0),
                              //                 topRight: Radius.circular(20.0),
                              //               ),
                              //             ),
                              //             // color: Colors.white,
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(20.0),
                              //               child: SingleChildScrollView(
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.end,
                              //                   children: [
                              //                     const SizedBox(height: 20),
                              //                     ConditionalBuilder(
                              //                       condition: state
                              //                           is! enterNewSoldierLoading,
                              //                       builder:
                              //                           (BuildContext context) =>
                              //                               addSoldier(cubit,
                              //                                   context, add),
                              //                       fallback: (BuildContext
                              //                               context) =>
                              //                           const Center(
                              //                               child:
                              //                                   CircularProgressIndicator()),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //         });
                              //   },
                              // ),
                              // const SizedBox(width: 30),
                              defaultButton(
                                fSize: 18.0,
                                radius: 20.0,
                                width: 250.0,
                                text: showUserBtn,
                                function: () {
                                  // navigateTo(context, ViewSoldiersScreen());
                                  navigateTo(context, ViewScreen());
                                },
                              ),
                              const SizedBox(width: 30),
                              defaultButton(
                                fSize: 20.0,
                                radius: 20.0,
                                width: 250.0,
                                text: vacationBtn,
                                function: () {
                                  navigateTo(context, VacationScreen());
                                },
                              ),
                              const SizedBox(width: 30),
                              defaultButton(
                                fSize: 20.0,
                                radius: 20.0,
                                width: 250.0,
                                text: printBtn1,
                                function: () async {
                                  await CacheHelper.getData(key: 'ALL');
                                  await CacheHelper.getData(key: 'VAC');

                                  cubit.createTamamDoc();
                                },
                              ),
                              // const SizedBox(width: 30),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultButton(
                                fSize: 20.0,
                                radius: 20.0,
                                width: 250.0,
                                text: missions,
                                function: () {
                                  navigateTo(context, MissionsScreen());
                                },
                              ),
                              const SizedBox(width: 30.0),
                              defaultButton(
                                fSize: 20.0,
                                radius: 20.0,
                                width: 250.0,
                                text: movesBtn,
                                function: () {
                                  navigateTo(context, MovesScreen());
                                },
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     // defaultButton(
                          //     //   fSize: 20.0,
                          //     //   radius: 20.0,
                          //     //   width: 250.0,
                          //     //   text: vacation_datesBtn,
                          //     //   function: () {},
                          //     // ),
                          //     // const SizedBox(width: 20),
                          //     // defaultButton(
                          //     //   fSize: 20.0,
                          //     //   radius: 20.0,
                          //     //   width: 250.0,
                          //     //   text: printBtn1,
                          //     //   function: () async {
                          //     //     final ALL =
                          //     //         await CacheHelper.getData(key: 'ALL');
                          //     //     final VAC =
                          //     //         await CacheHelper.getData(key: 'VAC');
                          //     //
                          //     //     print('MainMenu All: $ALL');
                          //     //     print('MainMenu VAC: $VAC');
                          //     //     cubit.createTamamDoc();
                          //     //   },
                          //     // ),
                          //     // const SizedBox(width: 30),
                          //     // defaultButton(
                          //     //   fSize: 20.0,
                          //     //   radius: 20.0,
                          //     //   width: 250.0,
                          //     //   text: printBtn3,
                          //     //   function: () {},
                          //     // ),
                          //   ],
                          // ),
                        ],
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                if (isAdmin == false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 30),
                              defaultButton(
                                fSize: 20.0,
                                radius: 20.0,
                                width: 250.0,
                                text: printBtn1,
                                function: () async {
                                  await CacheHelper.getData(key: 'ALL');
                                  await CacheHelper.getData(key: 'VAC');

                                  cubit.createTamamDoc();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     // defaultButton(
                          //     //   fSize: 20.0,
                          //     //   radius: 20.0,
                          //     //   width: 250.0,
                          //     //   text: vacation_datesBtn,
                          //     //   function: () {},
                          //     // ),
                          //     // const SizedBox(width: 20),
                          //     // defaultButton(
                          //     //   fSize: 20.0,
                          //     //   radius: 20.0,
                          //     //   width: 250.0,
                          //     //   text: printBtn1,
                          //     //   function: () async {
                          //     //     final ALL =
                          //     //         await CacheHelper.getData(key: 'ALL');
                          //     //     final VAC =
                          //     //         await CacheHelper.getData(key: 'VAC');
                          //     //
                          //     //     print('MainMenu All: $ALL');
                          //     //     print('MainMenu VAC: $VAC');
                          //     //     cubit.createTamamDoc();
                          //     //   },
                          //     // ),
                          //     // const SizedBox(width: 30),
                          //     // defaultButton(
                          //     //   fSize: 20.0,
                          //     //   radius: 20.0,
                          //     //   width: 250.0,
                          //     //   text: printBtn3,
                          //     //   function: () {},
                          //     // ),
                          //   ],
                          // ),
                        ],
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
