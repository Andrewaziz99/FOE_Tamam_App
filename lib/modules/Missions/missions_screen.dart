import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamam/shared/components/components.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';

import '../../shared/components/constants.dart';

class MissionsScreen extends StatelessWidget {

  TextEditingController funcController1 = TextEditingController();
  TextEditingController funcController2 = TextEditingController();

  MissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
        AppCubit()
          ..getSoldiersNotInVAC(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {
            var cubit = AppCubit.get(context);
            
            if (state is deleteMissionSuccessState) {
              cubit.getSoldiersNotInVAC();
              cubit.getMissions();
              cubit.missions.clear();
              cubit.missionsData.clear();
            }
            
            
            if (state is addMissionSuccessState) {
              funcController1.clear();
              funcController2.clear();
              CherryToast.success(
                textDirection: TextDirection.rtl,
                animationType: AnimationType.fromTop,
                enableIconAnimation: true,
                animationCurve: Curves.easeInOutQuint,
                displayIcon: true,
                toastDuration: const Duration(seconds: 5),
                displayCloseButton: true,
                autoDismiss: true,
                toastPosition: Position.center,
                title: const Text(setFunctionSucess),
              ).show(context);
            } else if (state is addMissionErrorState) {
              CherryToast.error(
                textDirection: TextDirection.rtl,
                animationType: AnimationType.fromTop,
                enableIconAnimation: true,
                animationCurve: Curves.easeInOutQuint,
                displayIcon: true,
                toastDuration: const Duration(seconds: 5),
                displayCloseButton: true,
                autoDismiss: true,
                toastPosition: Position.center,
                title: const Text(setFunctionError),
              ).show(context);
            }

            if (state is printMissionsSuccessState) {
              cubit.getMissions();
              cubit.missionsData.clear();
              cubit.missions.clear();
              CherryToast.success(
                textDirection: TextDirection.rtl,
                animationType: AnimationType.fromTop,
                enableIconAnimation: true,
                animationCurve: Curves.easeInOutQuint,
                displayIcon: true,
                toastDuration: const Duration(seconds: 5),
                displayCloseButton: true,
                autoDismiss: true,
                toastPosition: Position.center,
                title: const Text(printMissionSuccess),
              ).show(context);
            } else if (state is printMissionsErrorState) {
              CherryToast.error(
                textDirection: TextDirection.rtl,
                animationType: AnimationType.fromRight,
                enableIconAnimation: true,
                animationCurve: Curves.easeInOutQuint,
                displayIcon: true,
                toastDuration: const Duration(seconds: 5),
                displayCloseButton: true,
                autoDismiss: true,
                toastPosition: Position.center,
                title: const Text(printMissionError),
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
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      cubit.dropMissionTable();
                    },
                  ),
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
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => myDivider(),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: 20.0),
                              ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      cubit.soldierNotInVAC[index].soldierName!,
                                      style: const TextStyle(
                                          fontSize: 20.0, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    // if (cubit.missions.isNotEmpty) ...[
                                    //   Text(cubit.soldierMissions!.soldierFunction1!),
                                    //   const SizedBox(width: 20.0),
                                    //   Text(cubit.soldierMissions!.soldierFunction2!),
                                    // ] else
                                    //   const Text('No mission data', style: TextStyle(color: Colors.red)),
                                    // const Spacer(),
                                    SizedBox(
                                      width: 300.0,
                                      child: DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        style: const TextStyle(
                                          locale: Locale('ar'),
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        hint: const Text(
                                          function,
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.black),
                                          textAlign: TextAlign.right,
                                          locale: Locale('ar'),
                                        ),
                                        items: functions.map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              textAlign: TextAlign.right,
                                              locale: const Locale('ar'),
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please select a mission";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          funcController1.text = value!;
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.black),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData: const MenuItemStyleData(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      width: 300.0,
                                      child: DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        style: const TextStyle(
                                          locale: Locale('ar'),
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        hint: const Text(
                                          function,
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.black),
                                          textAlign: TextAlign.right,
                                          locale: Locale('ar'),
                                        ),
                                        items: functions.map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              textAlign: TextAlign.right,
                                              locale: const Locale('ar'),
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please select a mission";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          funcController2.text = value!;
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.black),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData: const MenuItemStyleData(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  cubit.soldierNotInVAC[index].soldierFunction!,
                                  style: const TextStyle(
                                      fontSize: 15.0, fontWeight: FontWeight.bold),
                                ),
                                trailing: defaultButton(
                                    width: 100.0,
                                    radius: 15.0,
                                    background: Colors.blue,
                                    tColor: Colors.white,
                                    fSize: 20.0,
                                    function: () async {
                                      cubit.addMissions(
                                          soldierId: cubit.soldierNotInVAC[index].soldierId,
                                          soldierName: cubit.soldierNotInVAC[index].soldierName,
                                          soldierFunction1: funcController1.text,
                                          soldierFunction2: funcController2.text,
                                      );
                                      await cubit.getMissionsById(soldierId: cubit.soldierNotInVAC[index].soldierId);
                                    },
                                    text: register),
                              ),


                            ],
                          );
                        },
                        itemCount: cubit.soldierNotInVAC.length,
                      ),
                    ),
                  ),


                  defaultButton(
                      width: double.infinity,
                      background: Colors.green,
                      tColor: Colors.white,
                      fSize: 20.0,
                      function: () {
                        cubit.createMissionDoc();
                      },
                      text: printMissions),
                ],
              ),
            );
          },
        ));
  }
}

//
// Padding(
// padding: const EdgeInsets.all(20.0),
// child: Column(
// children: [
// const SizedBox(height: 50.0),
// Row(
// children: [
// Expanded(
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// '$name: ${cubit.soldierNotInVAC[index].soldierName}',
// style: const TextStyle(
// fontSize: 20.0,
// fontWeight: FontWeight.bold,
// ),
// ),
// const SizedBox(height: 10.0),
// Text(
// '$function: ${cubit.soldierNotInVAC[index].soldierFunction}',
// style: const TextStyle(
// fontSize: 20.0,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// ),
// const SizedBox(width: 10),
// SizedBox(
// width: 300.0,
// child: DropdownButtonFormField2<String>(
// isExpanded: true,
// // alignment: Alignment.centerRight,
// style: const TextStyle(
// locale: Locale('ar'),
// color: Colors.black,
// fontSize: 18,
// ),
// decoration: InputDecoration(
// contentPadding:
// const EdgeInsets.symmetric(vertical: 16),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
// ),
// hint: const Text(
// function,
// style: TextStyle(fontSize: 18, color: Colors.black),
// textAlign: TextAlign.right,
// locale: Locale('ar'),
// ),
// items: functions.map((item) {
// return DropdownMenuItem<String>(
// value: item,
// child: Text(
// item,
// textAlign: TextAlign.right,
// locale: const Locale('ar'),
// style: const TextStyle(fontSize: 18),
// ),
// );
// }).toList(),
// validator: (value) {
// if (value == null) {
// return "Please select a mission";
// }
// return null;
// },
// onChanged: (value) {
// funcController1.text = value!;
// },
// buttonStyleData: const ButtonStyleData(
// padding: EdgeInsets.only(right: 8),
// ),
// iconStyleData: const IconStyleData(
// icon:
// Icon(Icons.arrow_drop_down, color: Colors.black),
// iconSize: 24,
// ),
// dropdownStyleData: DropdownStyleData(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// ),
// ),
// menuItemStyleData: const MenuItemStyleData(
// padding: EdgeInsets.symmetric(horizontal: 16),
// ),
// ),
// ),
// const SizedBox(width: 10),
// SizedBox(
// width: 300.0,
// child: DropdownButtonFormField2<String>(
// isExpanded: true,
// // alignment: Alignment.centerRight,
// style: const TextStyle(
// locale: Locale('ar'),
// color: Colors.black,
// fontSize: 18,
// ),
// decoration: InputDecoration(
// contentPadding:
// const EdgeInsets.symmetric(vertical: 16),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
// ),
// hint: const Text(
// function,
// style: TextStyle(fontSize: 18, color: Colors.black),
// textAlign: TextAlign.right,
// locale: Locale('ar'),
// ),
// items: functions.map((item) {
// return DropdownMenuItem<String>(
// value: item,
// child: Text(
// item,
// textAlign: TextAlign.right,
// locale: const Locale('ar'),
// style: const TextStyle(fontSize: 18),
// ),
// );
// }).toList(),
// validator: (value) {
// if (value == null) {
// return "Please select a mission";
// }
// return null;
// },
// onChanged: (value) {
// funcController2.text = value!;
// },
// buttonStyleData: const ButtonStyleData(
// padding: EdgeInsets.only(right: 8),
// ),
// iconStyleData: const IconStyleData(
// icon:
// Icon(Icons.arrow_drop_down, color: Colors.black),
// iconSize: 24,
// ),
// dropdownStyleData: DropdownStyleData(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// ),
// ),
// menuItemStyleData: const MenuItemStyleData(
// padding: EdgeInsets.symmetric(horizontal: 16),
// ),
// ),
// ),
// const SizedBox(width: 10),
// defaultButton(
// function: () {
// cubit.changeBackground();
// cubit.addMissions(
// soldierId: cubit.soldierNotInVAC[index].soldierId,
// soldierName: cubit.soldierNotInVAC[index].soldierName,
// soldierFunction1: funcController1.text,
// soldierFunction2: funcController2.text
// );
// },
// text: register,
// width: 100.0,
// fSize: 20.0,
// radius: 15.0,
// background: Colors.blue,
// tColor: Colors.white,
// ),
// ],
// ),
// const Divider(),
// ],
// ),
// )