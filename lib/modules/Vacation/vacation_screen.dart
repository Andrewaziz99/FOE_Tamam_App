
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class VacationScreen extends StatelessWidget {
  final SearchController _searchController = SearchController();

  final TextEditingController daysController = TextEditingController(text: convertToArabic('7'));
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController feedBackController = TextEditingController();

Map<String, dynamic> soldierData = {};

  int count = 0;

  VacationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getNotInVAC(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = AppCubit.get(context);
          // cubit.soldierData.clear();
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
                                  .firstWhere((element) =>
                                      element.soldierName == value)
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
                                toDateController.text=convertToArabic(DateFormat('yyyy/MM/dd').format(value.add(Duration(days: int.parse(convertArabicToEnglish(daysController.text))))));
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
                        validate: (val){}),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      background: Colors.green,
                        tColor: Colors.white,
                        fSize: 20.0,
                        radius: 20.0,
                        function: () {
                          cubit.AddToList(count, soldierData['soldierId'], soldierData['soldierName'], fromDateController.text, toDateController.text, feedBackController.text, soldierData['soldierRank']);
                          count ++;
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
                                        cubit.soldiers.removeAt(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const Spacer(),
                                    //to Date
                                    Text(toDateController.text),
                                    const Spacer(),
                                    //From Date
                                    Text(fromDateController.text),
                                    const Spacer(),
                                    //Soldier ID
                                    Text(cubit.soldiers[index]['name']),
                                    // //Name
                                    // const Spacer(),
                                    // Text(soldierData['soldierName'] ?? name),
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
                    defaultButton(
                      width: 400,
                      fSize: 20.0,
                      background: Colors.green,
                        tColor: Colors.white,
                        radius: 20.0,
                        function: () async{
                          await cubit.createMOVDocFromList( cubit.soldiers);
                          await cubit.createVACDocFromList( cubit.soldiers);

                        },
                        text: printBtn3),
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
