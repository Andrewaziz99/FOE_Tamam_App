import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tamam/shared/components/components.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';

import '../../shared/components/constants.dart';
import 'new_soldier_screen.dart';

class ViewSoldiersScreen extends StatelessWidget {
  final ScrollController _scrollbarController = ScrollController();


  TextEditingController editRankController = TextEditingController();
  TextEditingController editNameController = TextEditingController();
  TextEditingController editPhoneController = TextEditingController();
  TextEditingController editAddPhoneController = TextEditingController();
  TextEditingController editBirthDateController = TextEditingController();
  TextEditingController editCityController = TextEditingController();
  TextEditingController editImageController = TextEditingController();
  TextEditingController editNationalIDController = TextEditingController();
  TextEditingController editSoldierIDController = TextEditingController();
  TextEditingController editRetiringDateController = TextEditingController();
  TextEditingController editFacultyController = TextEditingController();
  TextEditingController editSpecController = TextEditingController();
  TextEditingController editGradeController = TextEditingController();
  TextEditingController editHomeAddressController = TextEditingController();
  TextEditingController editHome_numController = TextEditingController();
  TextEditingController editFather_jobController = TextEditingController();
  TextEditingController editMother_jobController = TextEditingController();
  TextEditingController editFather_phoneController = TextEditingController();
  TextEditingController editMother_phoneController = TextEditingController();
  TextEditingController editNum_of_siblingsController = TextEditingController();
  TextEditingController editSkillsController = TextEditingController();
  TextEditingController editFunctionController = TextEditingController();
  TextEditingController editJoinDateController = TextEditingController();

  ViewSoldiersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getAllSoldiers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          var cubit = AppCubit.get(context);

          if(state is getSoldierByIdSuccess){
            var cubit = AppCubit.get(context);

            editRankController.text = cubit.soldierModel!.soldierRank!;
            editNameController.text = cubit.soldierModel!.soldierName!;
            editPhoneController.text = cubit.soldierModel!.soldierPhone!;
            editAddPhoneController.text = cubit.soldierModel!.soldierAddPhone!;
            editBirthDateController.text = cubit.soldierModel!.soldierBDate!;
            editCityController.text = cubit.soldierModel!.soldierCity!;
            editImageController.text = cubit.soldierModel!.soldierImage!;
            editNationalIDController.text = cubit.soldierModel!.soldierNationalId!;
            editSoldierIDController.text = cubit.soldierModel!.soldierId!;
            editRetiringDateController.text = cubit.soldierModel!.soldierRetireDate!;
            editFacultyController.text = cubit.soldierModel!.soldierFaculty!;
            editSpecController.text = cubit.soldierModel!.soldierSpeciality!;
            editGradeController.text = cubit.soldierModel!.soldierGrade!;
            editHomeAddressController.text = cubit.soldierModel!.soldierHomeAddress!;
            editHome_numController.text = cubit.soldierModel!.soldierHomePhone!;
            editFather_jobController.text = cubit.soldierModel!.soldierFatherJob!;
            editMother_jobController.text = cubit.soldierModel!.soldierMotherJob!;
            editFather_phoneController.text = cubit.soldierModel!.soldierFatherPhone!;
            editMother_phoneController.text = cubit.soldierModel!.soldierMotherPhone!;
            editNum_of_siblingsController.text = cubit.soldierModel!.soldierNumOfSiblings!;
            editSkillsController.text = cubit.soldierModel!.soldierSkills!;
            editFunctionController.text = cubit.soldierModel!.soldierFunction!;
            editJoinDateController.text = cubit.soldierModel!.soldierJoinDate!;

            // print('Soldier Data: ${cubit.soldierModel!.soldierName}');
          }

          if (state is enterNewSoldierError) {
            CherryToast.error(
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
            cubit.getAllSoldiers();
            cubit.savedImagePath = '';
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

          if (state is pickImageSuccess) {
            CherryToast.success(
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

          if (state is pickImageError) {
            CherryToast.error(
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: const Text(imagePickError),
            ).show(context);
          }

          if (state is updateSoldierSuccess){
            Navigator.pop(context);
            cubit.getAllSoldiers();
            CherryToast.success(
              animationType: AnimationType.fromTop,
              enableIconAnimation: true,
              animationCurve: Curves.easeInOutQuint,
              displayIcon: true,
              toastDuration: const Duration(seconds: 5),
              displayCloseButton: true,
              autoDismiss: true,
              toastPosition: Position.top,
              title: const Text(soldierEditSuccess),
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
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.greenAccent,
              hoverColor: Colors.amberAccent,
                hoverElevation: 10.0,
                onPressed: (){
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
                child: const Icon(Icons.add)),
            body: ConditionalBuilder(
              condition: cubit.soldiersList.isNotEmpty,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Scrollbar(
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  interactive: true,
                  trackVisibility: true,
                  thumbVisibility: true,
                  controller: _scrollbarController,
                  child: ListView.separated(
                    controller: _scrollbarController,
                    separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      width: 20.0,
                    ),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    dragStartBehavior: DragStartBehavior.start,
                    itemBuilder: (context, index) => Container(
                      width: 500,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //Image
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CircleAvatar(
                                    radius: 150,
                                    backgroundImage:
                                    FileImage(File('${cubit.soldiersList[index].soldierImage}')),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),

                              //Soldier Data

                              //SoldierName
                              Text(
                                  '$name: ${cubit.soldiersList[index].soldierName}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //SoldierRank
                              Text(
                                  '$rank: ${cubit.soldiersList[index].soldierRank}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierID
                              Text(
                                  '$soldierlId: ${cubit.soldiersList[index].soldierId}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierNationalID
                              Text(
                                  '$nationalId: ${cubit.soldiersList[index].soldierNationalId}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierPhone
                              Text(
                                  '$phone: ${cubit.soldiersList[index].soldierPhone}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierAddPhone
                              Text(
                                  '$add_phone: ${cubit.soldiersList[index].soldierAddPhone}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierFunction
                              Text(
                                  '$job: ${cubit.soldiersList[index].soldierFunction}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierCity
                              Text(
                                  '$city: ${cubit.soldiersList[index].soldierCity}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierHomeAddress
                              Text(
                                  '$homeAddress: ${cubit.soldiersList[index].soldierHomeAddress}'),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierBDate
                              Text(
                                  '$bDate: ${cubit.soldiersList[index].soldierBDate}'),

                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierJoinDate
                              Text(
                                  '$joinDate: ${cubit.soldiersList[index].soldierJoinDate}'),

                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierRetireDate
                              Text(
                                  '$retireDate: ${cubit.soldiersList[index].soldierRetireDate}'),

                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierFaculty
                              Text(
                                  '$faculty: ${cubit.soldiersList[index].soldierFaculty}'),

                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierSpeciality
                              Text(
                                  '$speciality: ${cubit.soldiersList[index].soldierSpeciality}'),

                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierFatherJob
                              Text(
                                  '$fatherJob: ${cubit.soldiersList[index].soldierFatherJob}'),

                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierMotherJob
                              Text(
                                  '$motherJob: ${cubit.soldiersList[index].soldierMotherJob}'),

                              const SizedBox(
                                height: 10.0,
                              ),

                              //soldierSkills
                              Text(
                                  '$skills: ${cubit.soldiersList[index].soldierSkills}'),

                              const SizedBox(
                                height: 10.0,
                              ),

                              //Buttons
                              const SizedBox(
                                height: 50.0,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Delete Button
                                  defaultButton(
                                      width: 150,
                                      radius: 30,
                                      function: () {
                                        cubit.deleteSoldier(cubit.soldiersList[index].soldierId);
                                      },
                                      tColor: Colors.white,
                                      text: delete,
                                      background: Colors.redAccent),

                                  const Spacer(),

                                  //Edit Button
                                  defaultButton(
                                      tColor: Colors.white,
                                      width: 150,
                                      radius: 30,
                                      function: () {
                                        cubit.getSoldierById(cubit.soldiersList[index].soldierId);
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
                                                          condition: cubit.soldiersList.isNotEmpty,
                                                          builder: (BuildContext
                                                          context) =>
                                                              SingleChildScrollView(
                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                                                  const SizedBox(height: 20),
                                                                  Center(
                                                                    child: Stack(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius: 100.0,
                                                                          backgroundImage: FileImage(File('${cubit.soldiersList[index].soldierImage}')),
                                                                        ),
                                                                        Positioned(
                                                                          bottom: 20.0,
                                                                          right: 20.0,
                                                                          child: InkWell(
                                                                            onTap: () {
                                                                              cubit.pickImage();
                                                                              editImageController.text = cubit.savedImagePath;
                                                                            },
                                                                            child: const Icon(
                                                                              Icons.camera_alt_outlined,
                                                                              color: Colors.green,
                                                                              size: 30.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  DropdownButtonFormField2<String>(
                                                                    alignment: Alignment.centerRight,
                                                                    isExpanded: true,
                                                                    style: const TextStyle(
                                                                      locale: Locale('ar'),
                                                                      color: Colors.black,
                                                                      fontSize: 16,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                                                      border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                      ),
                                                                    ),
                                                                    hint: const Text(
                                                                      rank,
                                                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                                                      //textDirection: //textDirection.rtl,
                                                                      textAlign: TextAlign.right,
                                                                      locale: Locale('ar'),
                                                                    ),
                                                                    items: ranks
                                                                        .map((item) => DropdownMenuItem<String>(
                                                                      value: item,
                                                                      child: Text(
                                                                        item,
                                                                        textAlign: TextAlign.right,
                                                                        //textDirection: //textDirection.rtl,
                                                                        locale: const Locale('ar'),
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                        ),
                                                                      ),
                                                                    ))
                                                                        .toList(),
                                                                    validator: (value) {
                                                                      if (value == null) {
                                                                        return rankError;
                                                                      }
                                                                      return null;
                                                                    },
                                                                    onChanged: (value) {
                                                                      editRankController.text = value.toString();
                                                                    },
                                                                    buttonStyleData: const ButtonStyleData(
                                                                      padding: EdgeInsets.only(right: 8),
                                                                    ),
                                                                    iconStyleData: const IconStyleData(
                                                                      icon: Icon(
                                                                        Icons.arrow_drop_down,
                                                                        color: Colors.white,
                                                                      ),
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
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editNameController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.person,
                                                                      label: name,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return nameError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editPhoneController,
                                                                      type: TextInputType.phone,
                                                                      suffix: Icons.phone,
                                                                      label: phone,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return phoneError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editAddPhoneController,
                                                                      type: TextInputType.phone,
                                                                      suffix: Icons.phone,
                                                                      label: add_phone,
                                                                      validate: (value) {
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editBirthDateController,
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
                                                                          editBirthDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
                                                                        });
                                                                      },
                                                                      label: bDate,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return bDateError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: cityController,
                                                                      type: TextInputType.datetime,
                                                                      suffix: Icons.location_city,
                                                                      label: city,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return cityError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editHomeAddressController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.location_on,
                                                                      label: homeAddress,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return homeAddressError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editHome_numController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.numbers,
                                                                      label: homePhone,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return homePhoneError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editNationalIDController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.credit_card,
                                                                      label: nationalId,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return nationalIdError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editSoldierIDController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.credit_card,
                                                                      label: soldierlId,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return soldierlIdError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editRetiringDateController,
                                                                      type: TextInputType.datetime,
                                                                      suffix: Icons.calendar_today,
                                                                      label: retireDate,
                                                                      prefix: Icons.date_range,
                                                                      prefixColor: Colors.blue,
                                                                      prefixPressed: () {
                                                                        showDatePicker(
                                                                          context: context,
                                                                          initialDate: DateTime.now(),
                                                                          firstDate: DateTime(1900),
                                                                          lastDate: DateTime.parse('2050-12-30'),
                                                                        ).then((value) {
                                                                          editRetiringDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
                                                                        });
                                                                      },
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return retireDateError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editFacultyController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.school,
                                                                      label: faculty,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return facultyError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editSpecController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.school,
                                                                      label: speciality,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return specialityError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editGradeController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.grade,
                                                                      label: grade,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return gradeError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editFather_jobController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.work,
                                                                      label: fatherJob,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return fatherJobError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editMother_jobController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.work,
                                                                      label: motherJob,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return motherJobError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editFather_phoneController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.phone,
                                                                      label: fatherPhone,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return fatherPhoneError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editMother_phoneController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.phone,
                                                                      label: motherPhone,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return motherPhoneError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editNum_of_siblingsController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.people,
                                                                      label: numOfSiblings,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return numOfSiblingsError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editSkillsController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.work,
                                                                      label: skills,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return skillsError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editFunctionController,
                                                                      type: TextInputType.text,
                                                                      suffix: Icons.work,
                                                                      label: job,
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return jobError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  newFormField(
                                                                      textAlign: TextAlign.right,
                                                                      //textDirection: //textDirection.rtl,
                                                                      controller: editJoinDateController,
                                                                      type: TextInputType.datetime,
                                                                      suffix: Icons.calendar_today,
                                                                      label: joinDate,
                                                                      prefix: Icons.date_range,
                                                                      prefixColor: Colors.blue,
                                                                      prefixPressed: () {
                                                                        showDatePicker(
                                                                          context: context,
                                                                          initialDate: DateTime.now(),
                                                                          firstDate: DateTime(1970),
                                                                          lastDate: DateTime.parse('2050-12-30'),
                                                                        ).then((value) {
                                                                          editJoinDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
                                                                        });
                                                                      },
                                                                      validate: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return joinDateError;
                                                                        }
                                                                        return null;
                                                                      }),
                                                                  const SizedBox(height: 20),
                                                                  defaultButton(
                                                                    function: () {
                                                                      cubit.updateSoldier(
                                                                        name: editNameController.text,
                                                                        rank: editRankController.text,
                                                                        phone: editPhoneController.text,
                                                                        addPhone: editAddPhoneController.text,
                                                                        birthDate: editBirthDateController.text,
                                                                        city: editCityController.text,
                                                                        image: cubit.savedImagePath,
                                                                        nationalID: editNationalIDController.text,
                                                                        soldierID: editSoldierIDController.text,
                                                                        retiringDate: editRetiringDateController.text,
                                                                        faculty: editFacultyController.text,
                                                                        spec: editSpecController.text,
                                                                        grade: editGradeController.text,
                                                                        homeAddress: editHomeAddressController.text,
                                                                        home_num: editHome_numController.text,
                                                                        father_job: editFather_jobController.text,
                                                                        mother_job: editMother_jobController.text,
                                                                        father_phone: editFather_phoneController.text,
                                                                        mother_phone: editMother_phoneController.text,
                                                                        num_of_siblings: editNum_of_siblingsController.text,
                                                                        skills: editSkillsController.text,
                                                                        function: editFunctionController.text,
                                                                        joinDate: editJoinDateController.text,
                                                                      );

                                                                    },
                                                                    background: Colors.green,
                                                                    text: edit,
                                                                    fSize: 20.0,
                                                                    radius: 15.0,
                                                                  ),
                                                                ]),
                                                              ),
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
                                      text: edit,
                                      background: Colors.blueAccent),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: cubit.soldiersList.length,
                  ),
                ),
              ),
              fallback: (BuildContext context) => const Center(
                child: Text(noData, style: TextStyle(fontSize: 20.0),),
              ),
            ),
          );
        },
      ),
    );
  }
}

