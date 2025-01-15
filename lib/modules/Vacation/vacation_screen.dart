import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class VacationScreen extends StatelessWidget {
  final TextEditingController daysController =
      TextEditingController(text: convertToArabic('7'));
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController feedBackController = TextEditingController();

  final TextEditingController editFromDateController = TextEditingController();
  final TextEditingController editToDateController = TextEditingController();
  final TextEditingController editFeedBackController = TextEditingController();

  Map<String, dynamic> soldierData = {};

  int count = 0;

  VacationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getAllNotInVAC()..getActiveVacations(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {

          if (state is getActiveVacationsSuccessState) {

            var cubit = AppCubit.get(context);

            cubit.soldiers.clear();

            for(int index = 0; index < cubit.VacData.length; index++){
              cubit.AddToList(
                  index,
                  cubit.VacData[index].soldierId,
                  cubit.VacData[index].name,
                  cubit.VacData[index].fromDate,
                  cubit.VacData[index].toDate,
                  cubit.VacData[index].feedback,
                  cubit.VacData[index].rank
              );


              editFromDateController.text = cubit.VacData[index].fromDate!;
              editToDateController.text = cubit.VacData[index].toDate!;
              editFeedBackController.text = cubit.VacData[index].feedback!;

            }
            cubit.updateCheckedList();

          }


          if (state is updateListSuccess) {
            Navigator.pop(context);
            CherryToast.success(
              title: const Text(updateListSuccessMsg),
              enableIconAnimation: true,
              animationDuration: const Duration(milliseconds: 500),
              autoDismiss: true,
              animationType: AnimationType.fromTop,
              toastPosition: Position.top,
              toastDuration: const Duration(seconds: 5),
            ).show(context);
          }

          if (state is genTableSuccess) {
            CherryToast.success(
              title: const Text(genTableSuccessMsg),
              enableIconAnimation: true,
              animationDuration: const Duration(milliseconds: 500),
              autoDismiss: true,
              animationType: AnimationType.fromTop,
              toastPosition: Position.top,
              toastDuration: const Duration(seconds: 5),
            ).show(context);
          }

          if (state is makeVacationSuccess) {
            AppCubit.get(context).soldiers.clear();
            CherryToast.success(
              title: const Text(makeVacationSuccessMsg),
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
          var cubit = AppCubit.get(context);

          // final List<Map<String, dynamic>> isChecked = List.generate(
          //   cubit.soldiers.length,
          //       (index) => {
          //     'id': index,
          //     'isChecked': false,
          //   },
          // );


          return Scaffold(
            appBar: AppBar(
              elevation: 0.5,
              title: const Text(appTitle,
                  style: TextStyle(fontSize: 25.0, color: Colors.white)),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Duration Field
                        Flexible(
                          flex: 2,
                          child: newFormField(
                            controller: daysController,
                            type: TextInputType.text,
                            label: duration,
                            validate: (val) {
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10), // Space between fields

                        // Dropdown for Name
                        Flexible(
                          flex: 3,
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
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
                              cubit.changeSelectedValue(value!);
                              soldierData = cubit.soldierNotInVAC
                                  .firstWhere(
                                      (element) => element.soldierName == value)
                                  .toMap();
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
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // To Date Picker
                        Flexible(
                          flex: 3,
                          child: newFormField(
                            textAlign: TextAlign.right,
                            controller: toDateController,
                            type: TextInputType.datetime,
                            suffix: Icons.calendar_today,
                            prefix: Icons.date_range,
                            prefixColor: Colors.blue,
                            prefixPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now().add(Duration(
                                    days: int.parse(convertArabicToEnglish(
                                        daysController.text)))),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.parse('2050-12-30'),
                              ).then((value) {
                                toDateController.text = convertToArabic(
                                    DateFormat('yyyy/MM/dd').format(value!));
                                DateTime from_date = DateTime.parse(
                                    convertArabicToEnglish(
                                        fromDateController.text));
                                DateTime to_date = DateTime.parse(
                                    convertArabicToEnglish(
                                        toDateController.text));
                                daysController.text = convertToArabic(
                                    (to_date.difference(from_date).inDays)
                                        .toString());
                              });
                            },
                            label: toDate,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a valid date";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10), // Space between fields
                        // From Date Picker
                        Flexible(
                          flex: 3,
                          child: newFormField(
                            textAlign: TextAlign.right,
                            controller: fromDateController,
                            type: TextInputType.datetime,
                            suffix: Icons.calendar_today,
                            prefix: Icons.date_range,
                            prefixColor: Colors.blue,
                            prefixPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.parse('2050-12-30'),
                              ).then((value) {
                                fromDateController.text = convertToArabic(
                                    DateFormat('yyyy/MM/dd').format(value!));
                                toDateController.text = convertToArabic(
                                    DateFormat('yyyy/MM/dd').format(value.add(
                                        Duration(
                                            days: int.parse(
                                                convertArabicToEnglish(
                                                    daysController.text))))));
                              });
                            },
                            label: fromDate,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a valid date";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    newFormField(
                        controller: feedBackController,
                        type: TextInputType.text,
                        label: feedback,
                        validate: (val) {}),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        background: Colors.green,
                        tColor: Colors.white,
                        fSize: 20.0,
                        radius: 20.0,
                        function: () {
                          cubit.AddToList(
                              count,
                              soldierData['soldierId'],
                              soldierData['soldierName'],
                              fromDateController.text,
                              toDateController.text,
                              feedBackController.text,
                              soldierData['soldierRank']);
                          count++;
                          cubit.updateCheckedList();
                        },
                        text: add),
                    const SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListView.separated(
                        itemCount: cubit.soldiers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //Delete Button
                                    IconButton(
                                      onPressed: () {
                                        cubit.removeSoldierFromList(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(width: 20),

                                    //Edit Button
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 500.0,
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                ),
                                                // color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        const SizedBox(
                                                            height: 20),
                                                        ConditionalBuilder(
                                                            condition: state !=
                                                                getSoldierByIdLoading,
                                                            builder: (context) {
                                                              return Column(
                                                                children: [
                                                                  newFormField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    controller:
                                                                        editFromDateController,
                                                                    type: TextInputType
                                                                        .datetime,
                                                                    suffix: Icons
                                                                        .calendar_today,
                                                                    prefix: Icons
                                                                        .date_range,
                                                                    prefixColor:
                                                                        Colors
                                                                            .blue,
                                                                    prefixPressed:
                                                                        () {
                                                                      showDatePicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            DateTime.now(),
                                                                        firstDate:
                                                                            DateTime(1900),
                                                                        lastDate:
                                                                            DateTime.parse('2050-12-30'),
                                                                      ).then(
                                                                          (value) {
                                                                            editFromDateController
                                                                            .text = convertToArabic(DateFormat(
                                                                                'yyyy/MM/dd')
                                                                            .format(value!));
                                                                      });
                                                                    },
                                                                    label:
                                                                        fromDate,
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
                                                                    height:
                                                                        20.0,
                                                                  ),
                                                                  newFormField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    controller:
                                                                    editToDateController,
                                                                    type: TextInputType
                                                                        .datetime,
                                                                    suffix: Icons
                                                                        .calendar_today,
                                                                    prefix: Icons
                                                                        .date_range,
                                                                    prefixColor:
                                                                        Colors
                                                                            .blue,
                                                                    prefixPressed:
                                                                        () {
                                                                      showDatePicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            DateTime.now().add(Duration(days: int.parse(convertArabicToEnglish(daysController.text)))),
                                                                        firstDate:
                                                                            DateTime(1900),
                                                                        lastDate:
                                                                            DateTime.parse('2050-12-30'),
                                                                      ).then(
                                                                          (value) {
                                                                            editToDateController
                                                                            .text = convertToArabic(DateFormat(
                                                                                'yyyy/MM/dd')
                                                                            .format(value!));
                                                                      });
                                                                    },
                                                                    label:
                                                                        toDate,
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
                                                                    height:
                                                                        20.0,
                                                                  ),
                                                                  newFormField(
                                                                      controller:
                                                                          editFeedBackController,
                                                                      type: TextInputType
                                                                          .text,
                                                                      label:
                                                                          feedback,
                                                                      validate:
                                                                          (val) {
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(
                                                                    height:
                                                                        30.0,
                                                                  ),
                                                                  defaultButton(
                                                                      function:
                                                                          () {
                                                                        cubit.updateList(
                                                                            index,
                                                                            cubit.soldiers[index]['soldierId'],
                                                                            cubit.soldiers[index]['name'],
                                                                            editFromDateController.text,
                                                                            editToDateController.text,
                                                                            editFeedBackController.text,
                                                                            cubit.soldiers[index]['rank']);
                                                                      },
                                                                      text:
                                                                          edit,
                                                                      radius:
                                                                          15.0,
                                                                      tColor: Colors
                                                                          .white,
                                                                      background:
                                                                          Colors
                                                                              .blueAccent),
                                                                ],
                                                              );
                                                            },
                                                            fallback: (context) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator())),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const Spacer(),

                                    //FeedBack
                                    Text(cubit.soldiers[index]['feedback']),
                                    const Spacer(),

                                    //to Date
                                    Text(cubit.soldiers[index]['toDate']),
                                    const Spacer(),
                                    //From Date
                                    Text(cubit.soldiers[index]['fromDate']),
                                    const Spacer(),
                                    //Soldier Name
                                    Text(cubit.soldiers[index]['name']),

                                    const Spacer(),
                                    //CheckBox
                                    Checkbox(
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                        value: cubit.isChecked[index]['isChecked'],
                                        onChanged: (val){
                                          print(cubit.isChecked[index]['isChecked']);
                                          cubit.triggerCheckBox(val!, index);
                                          print(cubit.isChecked[index]['isChecked']);
                                          // print(val);
                                          // cubit.isChecked[index]['isChecked'] = val;
                                        }
                                    ),




                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 20.0,
                        ),
                      ),
                    ),





                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(
                            width: 400,
                            fSize: 20.0,
                            radius: 20.0,
                            background: Colors.blue,
                            tColor: Colors.white,
                            function: () async {
                              final checkedSoldiers = cubit.soldiers.where((s) {
                                final index = cubit.soldiers.indexOf(s);
                                return cubit.isChecked[index]['isChecked'];
                              }).toList();
                                await cubit.createVACDocFromList(checkedSoldiers);
                            },
                            text: printBtn3),
                        const SizedBox(width: 20),
                        defaultButton(
                            width: 400,
                            fSize: 20.0,
                            background: Colors.blue,
                            tColor: Colors.white,
                            radius: 20.0,
                            function: () async {
                              final checkedSoldiers = cubit.soldiers.where((s) {
                                final index = cubit.soldiers.indexOf(s);
                                return cubit.isChecked[index]['isChecked'];
                              }).toList();
                                await cubit.createMOVDocFromList(checkedSoldiers);
                            },
                            text: printBtn2),
                        const SizedBox(width: 20),
                        defaultButton(
                            width: 400,
                            fSize: 20.0,
                            radius: 20.0,
                            background: Colors.green,
                            tColor: Colors.white,
                            function: () {
                              for(int i = 0; i < cubit.soldiers.length; i++){
                                cubit.makeVacation(
                                    soldierID: cubit.soldiers[i]['soldierID'],
                                    fromDate: cubit.soldiers[i]['fromDate'],
                                    toDate: cubit.soldiers[i]['toDate'],
                                    feedback: cubit.soldiers[i]['feedback'],
                                    rank: cubit.soldiers[i]['rank'],
                                    name: cubit.soldiers[i]['name']);
                              }
                            },
                            text: save),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
