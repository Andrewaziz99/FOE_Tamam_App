import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tamam/models/Vacations/vacation_model.dart';
import 'package:tamam/modules/Vacation/cubit/cubit.dart';
import 'package:tamam/shared/components/components.dart';
import 'package:tamam/shared/components/constants.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';

import 'cubit/state.dart';

class MovesScreen extends StatelessWidget {
  VacationModel? soldierData;

  TextEditingController dayController = TextEditingController(text: '0');
  TextEditingController extendController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController feedBackController = TextEditingController();

  MovesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => VacationCubit()
          ..getAllSoldiers()
          ..getAllVacations()
          ..getExtendedVacation(),
        child: BlocConsumer<VacationCubit, VacationState>(
          listener: (BuildContext context, state) {
            var cubit = VacationCubit.get(context);

            if (state is deleteVacationSuccessState) {
              CherryToast.success(
                title: const Text(deleteVacationSuccess),
                enableIconAnimation: true,
                animationDuration: const Duration(milliseconds: 500),
                autoDismiss: true,
                animationType: AnimationType.fromTop,
                toastPosition: Position.top,
                toastDuration: const Duration(seconds: 5),
              ).show(context);
              cubit.getAllVacations();
            }

            if (state is stopVacationSuccess) {
              cubit.getAllVacations();
              CherryToast.success(
                title: const Text(vacationStopped),
                enableIconAnimation: true,
                animationDuration: const Duration(milliseconds: 500),
                autoDismiss: true,
                animationType: AnimationType.fromTop,
                toastPosition: Position.top,
                toastDuration: const Duration(seconds: 5),
              ).show(context);
            }
            if (state is updateVacationSuccessState) {
              Navigator.pop(context);
              CherryToast.success(
                title: const Text(editVacationSuccess),
                enableIconAnimation: true,
                animationDuration: const Duration(milliseconds: 500),
                autoDismiss: true,
                animationType: AnimationType.fromTop,
                toastPosition: Position.top,
                toastDuration: const Duration(seconds: 5),
              ).show(context);
            }

            if (state is extendVacationSuccess) {
              Navigator.pop(context);
              cubit.getAllSoldiers();
              cubit.getAllVacations();
              cubit.getActiveVacations();
              cubit.getExtendedVacation();
              CherryToast.success(
                title: const Text(extendVacationSuccessMsg),
                enableIconAnimation: true,
                animationDuration: const Duration(milliseconds: 500),
                autoDismiss: true,
                animationType: AnimationType.fromTop,
                toastPosition: Position.top,
                toastDuration: const Duration(seconds: 5),
              ).show(context);
            }

            if (state is genTableSuccessState) {
              CherryToast.success(
                title: const Text(printExtendSuccess),
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
            var cubit = VacationCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0.5,
                title: const Text(appTitle,
                    style: TextStyle(fontSize: 25.0, color: Colors.white)),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: DropdownButtonFormField2<String>(
                        alignment: Alignment.centerRight,
                        isExpanded: true,
                        style: const TextStyle(
                          locale: Locale('ar'),
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text(
                          name,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.right,
                          locale: Locale('ar'),
                        ),
                        items: cubit.soldiersName.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              textAlign: TextAlign.right,
                              locale: const Locale('ar'),
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return "Please select a soldier";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          // cubit.getVacationsByName(value);
                          // soldierData = cubit.VacData.firstWhere(
                          //     (element) => element.name == value);
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //Filter Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(
                          width: 200.0,
                          radius: 15.0,
                          fSize: 20.0,
                          background: Colors.green,
                          tColor: Colors.white,
                          function: () {
                            cubit.getAllVacations();
                          },
                          text: allVacations,
                        ),
                        const SizedBox(width: 20),
                        defaultButton(
                          width: 200.0,
                          radius: 15.0,
                          fSize: 20.0,
                          background: Colors.green,
                          tColor: Colors.white,
                          function: () {
                            cubit.getExtendedVacations();
                          },
                          text: extendedVacations,
                        ),
                        const SizedBox(width: 20),
                        defaultButton(
                          width: 200.0,
                          radius: 15.0,
                          fSize: 20.0,
                          background: Colors.green,
                          tColor: Colors.white,
                          function: () {
                            cubit.getActiveVacations();
                          },
                          text: activeVacations,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // List Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(feedback,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(toDate,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(fromDate,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),

                    //List of soldiers
                    const SizedBox(height: 20),
                    ConditionalBuilder(
                      condition: state is! getVacationsLoading ||
                          cubit.Vacations.isEmpty,
                      builder: (BuildContext context) => Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.Vacations.length,
                            itemBuilder: (context, index) {
                              final vacation = cubit.Vacations[index];
                              // cubit.calculateDifference(
                              //     soldierId: vacation.soldierId,
                              //     toDate: vacation.toDate);
                              final dateFormat = DateFormat('yyyy/MM/dd');
                              final vacationDate = dateFormat.parse(convertArabicToEnglish(vacation.toDate!));
                              final now = DateTime.now();
                              final yestrday = DateTime(now.year, now.month, now.day - 1);
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withAlpha(100),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if(vacationDate.isAfter(yestrday))
                                      //Extend button
                                      defaultButton(
                                          background: Colors.green,
                                          radius: 15.0,
                                          width: 50.0,
                                          fSize: 20.0,
                                          function: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    width: double.infinity,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                20.0),
                                                        topRight:
                                                            Radius.circular(
                                                                20.0),
                                                      ),
                                                    ),
                                                    // color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            newFormField(
                                                                controller:
                                                                    dayController,
                                                                type:
                                                                    TextInputType
                                                                        .text,
                                                                label: duration,
                                                                validate:
                                                                    (val) {
                                                                  if (val!
                                                                      .isEmpty) {
                                                                    return 'Please enter the number of days';
                                                                  }
                                                                  return null;
                                                                }),
                                                            const SizedBox(
                                                              height: 20.0,
                                                            ),
                                                            newFormField(
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              controller:
                                                                  extendController,
                                                              type:
                                                                  TextInputType
                                                                      .datetime,
                                                              suffix: Icons
                                                                  .calendar_today,
                                                              prefix: Icons
                                                                  .date_range,
                                                              prefixColor:
                                                                  Colors.blue,
                                                              prefixPressed:
                                                                  () {
                                                                showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate: DateTime.now().add(Duration(
                                                                      days: int.parse(convertArabicToEnglish(
                                                                          dayController.text)))),
                                                                  firstDate:
                                                                      DateTime
                                                                          .now(),
                                                                  lastDate: DateTime
                                                                      .parse(
                                                                          '2050-12-30'),
                                                                ).then((value) {
                                                                  extendController.text = convertToArabic(
                                                                      DateFormat('yyyy/MM/dd').format(value!));
                                                                });
                                                              },
                                                              label: toDate,
                                                              validate:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return "Please enter a valid date";
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                height: 30),
                                                            defaultButton(
                                                                background:
                                                                    Colors
                                                                        .green,
                                                                radius: 15.0,
                                                                width: 150.0,
                                                                fSize: 20.0,
                                                                function: () {
                                                                  var day = DateFormat('yyyy/MM/dd').parse(convertArabicToEnglish(extendController.text)).day - DateFormat('yyyy/MM/dd').parse(convertArabicToEnglish(vacation.toDate!)).day;
                                                                  cubit.extendVacation(
                                                                      vacation
                                                                          .soldierId!,
                                                                      vacation
                                                                          .fromDate!,
                                                                      vacation
                                                                          .toDate!,
                                                                      day);
                                                                },
                                                                text:
                                                                    extendBtn),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          text: extendBtn),
                                    if (cubit.difference < 0)
                                      //Edit Button
                                      // IconButton(
                                      //     onPressed: () {
                                      //       fromDateController.text =
                                      //           vacation.fromDate!;
                                      //       toDateController.text =
                                      //           vacation.toDate!;
                                      //       feedBackController.text =
                                      //           vacation.feedback!;
                                      //       showModalBottomSheet(
                                      //           context: context,
                                      //           builder: (context) {
                                      //             return Container(
                                      //               width: double.infinity,
                                      //               decoration:
                                      //                   const BoxDecoration(
                                      //                 color: Colors.white,
                                      //                 borderRadius:
                                      //                     BorderRadius.only(
                                      //                   topLeft:
                                      //                       Radius.circular(
                                      //                           20.0),
                                      //                   topRight:
                                      //                       Radius.circular(
                                      //                           20.0),
                                      //                 ),
                                      //               ),
                                      //               // color: Colors.white,
                                      //               child: Padding(
                                      //                 padding:
                                      //                     const EdgeInsets
                                      //                         .all(20.0),
                                      //                 child:
                                      //                     SingleChildScrollView(
                                      //                   child: Column(
                                      //                     crossAxisAlignment:
                                      //                         CrossAxisAlignment
                                      //                             .end,
                                      //                     children: [
                                      //                       const SizedBox(
                                      //                           height: 20),
                                      //                       newFormField(
                                      //                           controller:
                                      //                               fromDateController,
                                      //                           type:
                                      //                               TextInputType
                                      //                                   .text,
                                      //                           label:
                                      //                               fromDate,
                                      //                           validate:
                                      //                               (val) {
                                      //                             if (val!
                                      //                                 .isEmpty) {
                                      //                               return 'Please enter the number of days';
                                      //                             }
                                      //                             return null;
                                      //                           }),
                                      //                       const SizedBox(
                                      //                           height: 20),
                                      //                       newFormField(
                                      //                           controller:
                                      //                               toDateController,
                                      //                           type:
                                      //                               TextInputType
                                      //                                   .text,
                                      //                           label: toDate,
                                      //                           validate:
                                      //                               (val) {
                                      //                             if (val!
                                      //                                 .isEmpty) {
                                      //                               return 'Please enter the number of days';
                                      //                             }
                                      //                             return null;
                                      //                           }),
                                      //                       const SizedBox(
                                      //                           height: 20),
                                      //                       newFormField(
                                      //                           controller:
                                      //                               feedBackController,
                                      //                           type:
                                      //                               TextInputType
                                      //                                   .text,
                                      //                           label:
                                      //                               feedback,
                                      //                           validate:
                                      //                               (val) {
                                      //                             if (val!
                                      //                                 .isEmpty) {
                                      //                               return 'Please enter the number of days';
                                      //                             }
                                      //                             return null;
                                      //                           }),
                                      //                       const SizedBox(
                                      //                           height: 30),
                                      //                       // defaultButton(
                                      //                       //     background:
                                      //                       //         Colors
                                      //                       //             .blue,
                                      //                       //     radius: 15.0,
                                      //                       //     width: 150.0,
                                      //                       //     fSize: 20.0,
                                      //                       //     tColor: Colors
                                      //                       //         .white,
                                      //                       //     function: () {
                                      //                       //       // cubit
                                      //                       //       //     .updateVacation(
                                      //                       //       //   soldierID:
                                      //                       //       //       vacation
                                      //                       //       //           .soldierId,
                                      //                       //       //   oldFromDate:
                                      //                       //       //       vacation
                                      //                       //       //           .fromDate,
                                      //                       //       //   oldToDate:
                                      //                       //       //       vacation
                                      //                       //       //           .toDate,
                                      //                       //       //   oldFeedback:
                                      //                       //       //       vacation
                                      //                       //       //           .feedback,
                                      //                       //       //   newFromDate:
                                      //                       //       //       fromDateController
                                      //                       //       //           .text,
                                      //                       //       //   newToDate:
                                      //                       //       //       toDateController
                                      //                       //       //           .text,
                                      //                       //       //   newFeedback:
                                      //                       //       //       feedBackController
                                      //                       //       //           .text,
                                      //                       //       // );
                                      //                       //     },
                                      //                       //     text: edit),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             );
                                      //           });
                                      //     },
                                      //     icon: const Icon(Icons.edit,
                                      //         color: Colors.blue), tooltip: editVacation,),
                                      if (cubit.difference < 0)
                                        //Stop Button
                                        IconButton(
                                          onPressed: () {
                                            cubit.calculateDifference(
                                                soldierId: vacation.soldierId,
                                                toDate: vacation.toDate);
                                            if (cubit.difference < 0) {
                                              cubit.stopVacation(
                                                  vacation.soldierId!,
                                                  vacation.fromDate!,
                                                  vacation.toDate!);
                                            } else {
                                              cubit.deleteVacation(
                                                  vacation.soldierId!,
                                                  vacation.fromDate!,
                                                  vacation.toDate!);
                                            }
                                          },
                                          icon: const Icon(Icons.pause,
                                              color: Colors.amberAccent),
                                          tooltip: stopVacation,
                                        ),
                                    //Delete Button
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            alignment: Alignment.center,
                                            elevation: 8.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            title: const Text(
                                              confirmDeleteVacation,
                                            ),
                                            titleTextStyle: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 20.0,
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actions: [
                                              defaultButton(
                                                  radius: 20.0,
                                                  fSize: 20.0,
                                                  tColor: Colors.white,
                                                  background: Colors.redAccent,
                                                  function: () {
                                                    cubit.deleteVacation(
                                                        vacation.soldierId!,
                                                        vacation.fromDate!,
                                                        vacation.toDate!);
                                                    Navigator.pop(context);
                                                  },
                                                  text: delete),
                                              const SizedBox(height: 15.0),
                                              defaultButton(
                                                  radius: 20.0,
                                                  fSize: 20.0,
                                                  tColor: Colors.white,
                                                  background:
                                                      Colors.greenAccent,
                                                  function: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: cancel),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      tooltip: deleteVacation,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(vacation.feedback ?? ''),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(vacation.toDate ?? ''),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(vacation.fromDate ?? ''),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(vacation.name ?? ''),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    myDivider(),
                          ),
                        ),
                      ),
                      fallback: (BuildContext context) => const Text(noData),
                    ),
                    defaultButton(
                      width: 200.0,
                      radius: 15.0,
                      fSize: 20.0,
                      background: Colors.green,
                      tColor: Colors.white,
                      function: () {
                        cubit.createExtendDoc();
                      },
                      text: printExtend,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
