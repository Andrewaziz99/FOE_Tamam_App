import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamam/modules/Soldiers/new_soldier_screen.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';
import 'package:tamam/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../Soldiers/view_soldiers_screen.dart';
import '../Vacation/vacation_screen.dart';

class MainMenuScreen extends StatelessWidget {

  final isAdmin;

  const MainMenuScreen({super.key, isAdmin}) : this.isAdmin = isAdmin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getSoldiers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is pickImageSuccess) {
            print('Pick Image Success');
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
              title: const Text(tamamError),
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
                            defaultButton(
                              fSize: 20.0,
                              radius: 20.0,
                              width: 250.0,
                              text: newUserBtn,
                              function: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        // color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SizedBox(height: 20),
                                                ConditionalBuilder(
                                                  condition: state
                                                      is! enterNewSoldierLoading,
                                                  builder:
                                                      (BuildContext context) =>
                                                          addSoldier(cubit,
                                                              context, add),
                                                  fallback: (BuildContext
                                                          context) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                            const SizedBox(width: 30),
                            defaultButton(
                              fSize: 20.0,
                              radius: 20.0,
                              width: 250.0,
                              text: showUserBtn,
                              function: () {
                                navigateTo(context, ViewSoldiersScreen());
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
                                final ALL =
                                await CacheHelper.getData(key: 'ALL');
                                final VAC =
                                await CacheHelper.getData(key: 'VAC');

                                print(ALL);
                                print(VAC);

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
                                  final ALL =
                                  await CacheHelper.getData(key: 'ALL');
                                  final VAC =
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