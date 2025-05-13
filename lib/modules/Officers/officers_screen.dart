import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tamam/modules/Officers/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'cubit/cubit.dart';

class OfficersScreen extends StatelessWidget {

  TextEditingController daysController = TextEditingController(text: convertToArabic('3'));
  TextEditingController nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OfficersCubit()..getOfficers(),
      child:  BlocConsumer<OfficersCubit, officersStates>(
          builder: (BuildContext context, state) {
            final cubit = OfficersCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0.5,
                title: const Text(appTitle,
                    style: TextStyle(fontSize: 25.0, color: Colors.white)),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  //Background Image
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //Data
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlurryContainer(
                              color: Colors.black.withAlpha(80),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 20),
                                  // Name Field
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: CustomDropDownMenu(
                                      showTitle: true,
                                      title: name,
                                      titleColor: Colors.white,
                                      textColor: Colors.white,
                                      controller: nameController,
                                      screenWidth: MediaQuery.of(context).size.width,
                                      screenRatio: MediaQuery.of(context).devicePixelRatio * 0.3,
                                      entries: [
                                        for (var officer in cubit.officersList)
                                          DropdownMenuEntry(value: officer.officerName, label: officer.officerName!)
                                      ],
                                      onSelected: null,
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  // Duration Field
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: defaultFormField(
                                      textColor: Colors.white,
                                      labelColor: Colors.white,
                                      controller: daysController,
                                      type: TextInputType.text,
                                      label: duration,
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  // Start Date Field
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: defaultFormField(
                                      suffixPressed: (){
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now().add(const Duration(days: 1)),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.parse('2050-12-30'),
                                        ).then((value) {
                                          startDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
                                        });
                                      },
                                      suffix: Icons.calendar_today,
                                      suffixColor: Colors.white,
                                      textColor: Colors.white,
                                      labelColor: Colors.white,
                                      controller: startDateController,
                                      type: TextInputType.text,
                                      label: fromDate,
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  // End Date Field
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: defaultFormField(
                                      suffixPressed: (){
                                        final days = int.parse(convertArabicToEnglish(daysController.text));
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now().add(Duration(days: days + 1)),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.parse('2050-12-30'),
                                        ).then((value) {
                                          endDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
                                        });
                                      },
                                      suffix: Icons.calendar_today,
                                      suffixColor: Colors.white,
                                      textColor: Colors.white,
                                      labelColor: Colors.white,
                                      controller: endDateController,
                                      type: TextInputType.text,
                                      label: toDate,
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Print all and Register Button
                                defaultButton(
                                    function: () {
                                      final data = [
                                        {
                                        'name': cubit.officersList.first.officerName,
                                        'rank': cubit.officersList.first.officerRank,
                                        'location': cubit.officersList.first.officerCity,
                                        'job': cubit.officersList.first.officerJob,
                                        'startDate': startDateController.text,
                                        'endDate': endDateController.text,
                                      },
                                        {
                                          'name': cubit.officersList.last.officerName,
                                          'rank': cubit.officersList.last.officerRank,
                                          'location': cubit.officersList.last.officerCity,
                                          'job': cubit.officersList.last.officerJob,
                                          'startDate': startDateController.text,
                                          'endDate': endDateController.text,
                                        }
                                      ];
                                      cubit.registerOfficerVacation(data, startDateController.text, endDateController.text).then((value) {
                                      cubit.printMovements(data);
                                      cubit.printVacationPasses(data);
                                      });
                                    },
                                    text: registerAndPrint,
                                    background: Colors.green,
                                    tColor: Colors.white,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    radius: 15.0,
                                    fSize: 20.0
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (BuildContext context, state) {
          }
      ),
    );
  }
}
