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

class ViewSoldiersScreen extends StatelessWidget {
  final ScrollController _scrollbarController = ScrollController();


  TextEditingController rankController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addPhoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController nationalIDController = TextEditingController();
  TextEditingController soldierIDController = TextEditingController();
  TextEditingController retiringDateController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController specController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController home_numController = TextEditingController();
  TextEditingController father_jobController = TextEditingController();
  TextEditingController mother_jobController = TextEditingController();
  TextEditingController father_phoneController = TextEditingController();
  TextEditingController mother_phoneController = TextEditingController();
  TextEditingController num_of_siblingsController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController functionController = TextEditingController();
  TextEditingController joinDateController = TextEditingController();

  ViewSoldiersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getSoldiers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          var cubit = AppCubit.get(context);
          if(state is getSoldierSuccess){
            var cubit = AppCubit.get(context);

            rankController.text = cubit.soldierModel!.soldierRank!;
            nameController.text = cubit.soldierModel!.soldierName!;
            phoneController.text = cubit.soldierModel!.soldierPhone!;
            addPhoneController.text = cubit.soldierModel!.soldierAddPhone!;
            birthDateController.text = cubit.soldierModel!.soldierBDate!;
            cityController.text = cubit.soldierModel!.soldierCity!;
            imageController.text = cubit.soldierModel!.soldierImage!;
            nationalIDController.text = cubit.soldierModel!.soldierNationalId!;
            soldierIDController.text = cubit.soldierModel!.soldierId!;
            retiringDateController.text = cubit.soldierModel!.soldierRetireDate!;
            facultyController.text = cubit.soldierModel!.soldierFaculty!;
            specController.text = cubit.soldierModel!.soldierSpeciality!;
            gradeController.text = cubit.soldierModel!.soldierGrade!;
            homeAddressController.text = cubit.soldierModel!.soldierHomeAddress!;
            home_numController.text = cubit.soldierModel!.soldierHomePhone!;
            father_jobController.text = cubit.soldierModel!.soldierFatherJob!;
            mother_jobController.text = cubit.soldierModel!.soldierMotherJob!;
            father_phoneController.text = cubit.soldierModel!.soldierFatherPhone!;
            mother_phoneController.text = cubit.soldierModel!.soldierMotherPhone!;
            num_of_siblingsController.text = cubit.soldierModel!.soldierNumOfSiblings!;
            skillsController.text = cubit.soldierModel!.soldierSkills!;
            functionController.text = cubit.soldierModel!.soldierFunction!;
            joinDateController.text = cubit.soldierModel!.soldierJoinDate!;

          }

          if (state is updateSoldierSuccess){
            Navigator.pop(context);
            cubit.getSoldiers();
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
            body: Padding(
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
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage:
                                  AssetImage('assets/images/unknown_image.png'),
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

                            //soldierPhone
                            Text(
                                '$phone: ${cubit.soldiersList[index].soldierPhone}'),
                            const SizedBox(
                              height: 10.0,
                            ),

                            //soldierID
                            Text(
                                '$soldierlId: ${cubit.soldiersList[index].soldierId}'),
                            const SizedBox(
                              height: 10.0,
                            ),

                            //soldierFunction
                            Text(
                                '$function: ${cubit.soldiersList[index].soldierFunction}'),
                            const SizedBox(
                              height: 10.0,
                            ),

                            //Buttons
                            const SizedBox(
                              height: 100.0,
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
                                    text: delete,
                                    background: Colors.redAccent),

                                const Spacer(),

                                //Edit Button
                                defaultButton(
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
                                                        condition: cubit.state
                                                        is! updateSoldierLoading,
                                                        builder: (BuildContext
                                                        context) =>
                                                            SingleChildScrollView(
                                                              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                                                const SizedBox(height: 20),
                                                                Center(
                                                                  child: Stack(
                                                                    children: [
                                                                      const CircleAvatar(
                                                                        radius: 100.0,
                                                                        backgroundImage: AssetImage('assets/images/unknown_image.png'),
                                                                      ),
                                                                      Positioned(
                                                                        bottom: 20.0,
                                                                        right: 20.0,
                                                                        child: InkWell(
                                                                          onTap: () {
                                                                            cubit.pickImage();
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
                                                                    rankController.text = value.toString();
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
                                                                    controller: nameController,
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
                                                                    controller: phoneController,
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
                                                                    controller: addPhoneController,
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
                                                                    controller: birthDateController,
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
                                                                        birthDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
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
                                                                    controller: homeAddressController,
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
                                                                    controller: home_numController,
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
                                                                    controller: nationalIDController,
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
                                                                    controller: soldierIDController,
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
                                                                    controller: retiringDateController,
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
                                                                        retiringDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
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
                                                                    controller: facultyController,
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
                                                                    controller: specController,
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
                                                                    controller: gradeController,
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
                                                                    controller: father_jobController,
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
                                                                    controller: mother_jobController,
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
                                                                    controller: father_phoneController,
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
                                                                    controller: mother_phoneController,
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
                                                                    controller: num_of_siblingsController,
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
                                                                    controller: skillsController,
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
                                                                    controller: functionController,
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
                                                                    controller: joinDateController,
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
                                                                        joinDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
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
                                                                      name: nameController.text,
                                                                      rank: rankController.text,
                                                                      phone: phoneController.text,
                                                                      addPhone: addPhoneController.text,
                                                                      birthDate: birthDateController.text,
                                                                      city: cityController.text,
                                                                      image: imageController.text,
                                                                      nationalID: nationalIDController.text,
                                                                      soldierID: soldierIDController.text,
                                                                      retiringDate: retiringDateController.text,
                                                                      faculty: facultyController.text,
                                                                      spec: specController.text,
                                                                      grade: gradeController.text,
                                                                      homeAddress: homeAddressController.text,
                                                                      home_num: home_numController.text,
                                                                      father_job: father_jobController.text,
                                                                      mother_job: mother_jobController.text,
                                                                      father_phone: father_phoneController.text,
                                                                      mother_phone: mother_phoneController.text,
                                                                      num_of_siblings: num_of_siblingsController.text,
                                                                      skills: skillsController.text,
                                                                      function: functionController.text,
                                                                      joinDate: joinDateController.text,
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
          );
        },
      ),
    );
  }
}

// Widget soldierItem(cubit, index, context) {
//   if (cubit.soldiersList.isEmpty) {
//     return const Center(child: Text(soldiersListEmpty));
//   } else {
//     return Container(
//       width: 400,
//       height: 200,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.grey,
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               //Image
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: CircleAvatar(
//                     radius: 100,
//                     backgroundImage:
//                         AssetImage('assets/images/unknown_image.png'),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//
//               //Soldier Data
//
//               //SoldierName
//               Text(
//                   '$name: ${cubit.soldiersList[index].soldierName}'),
//               const SizedBox(
//                 height: 10.0,
//               ),
//
//               //SoldierRank
//               Text(
//                   '$rank: ${cubit.soldiersList[index].soldierRank}'),
//               const SizedBox(
//                 height: 10.0,
//               ),
//
//               //soldierPhone
//               Text(
//                   '$phone: ${cubit.soldiersList[index].soldierPhone}'),
//               const SizedBox(
//                 height: 10.0,
//               ),
//
//               //soldierID
//               Text(
//                   '$soldierlId: ${cubit.soldiersList[index].soldierId}'),
//               const SizedBox(
//                 height: 10.0,
//               ),
//
//               //soldierFunction
//               Text(
//                   '$function: ${cubit.soldiersList[index].soldierFunction}'),
//               const SizedBox(
//                 height: 10.0,
//               ),
//
//               //Buttons
//               const SizedBox(
//                 height: 100.0,
//               ),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   //Delete Button
//                   defaultButton(
//                       width: 100,
//                       radius: 30,
//                       function: () {
//                         cubit.deleteSoldier(cubit.soldiersList[index].soldierId);
//                       },
//                       text: delete,
//                       background: Colors.redAccent),
//
//                   const Spacer(),
//
//                   //Edit Button
//                   defaultButton(
//                       width: 100,
//                       radius: 30,
//                       function: () {
//                         cubit.getSoldierById(cubit.soldiersList[index].soldierId);
//                         showModalBottomSheet(
//                             context: context,
//                             builder: (context) {
//                               return Container(
//                                 width: double.infinity,
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(20.0),
//                                     topRight: Radius.circular(20.0),
//                                   ),
//                                 ),
//                                 // color: Colors.white,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.end,
//                                       children: [
//                                         const SizedBox(height: 20),
//                                         ConditionalBuilder(
//                                           condition: cubit.state
//                                           is! updateSoldierLoading,
//                                           builder: (BuildContext
//                                           context) =>
//                                               SingleChildScrollView(
//                                                 child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//                                                   const SizedBox(height: 20),
//                                                   Center(
//                                                     child: Stack(
//                                                       children: [
//                                                         const CircleAvatar(
//                                                           radius: 100.0,
//                                                           backgroundImage: AssetImage('assets/images/unknown_image.png'),
//                                                         ),
//                                                         Positioned(
//                                                           bottom: 20.0,
//                                                           right: 20.0,
//                                                           child: InkWell(
//                                                             onTap: () {
//                                                               cubit.pickImage();
//                                                             },
//                                                             child: const Icon(
//                                                               Icons.camera_alt_outlined,
//                                                               color: Colors.green,
//                                                               size: 30.0,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   DropdownButtonFormField2<String>(
//                                                     alignment: Alignment.centerRight,
//                                                     isExpanded: true,
//                                                     style: const TextStyle(
//                                                       locale: Locale('ar'),
//                                                       color: Colors.black,
//                                                       fontSize: 16,
//                                                     ),
//                                                     decoration: InputDecoration(
//                                                       contentPadding: const EdgeInsets.symmetric(vertical: 16),
//                                                       border: OutlineInputBorder(
//                                                         borderRadius: BorderRadius.circular(15),
//                                                       ),
//                                                     ),
//                                                     hint: const Text(
//                                                       rank,
//                                                       style: TextStyle(fontSize: 16, color: Colors.black),
//                                                       //textDirection: //textDirection.rtl,
//                                                       textAlign: TextAlign.right,
//                                                       locale: Locale('ar'),
//                                                     ),
//                                                     items: ranks
//                                                         .map((item) => DropdownMenuItem<String>(
//                                                       value: item,
//                                                       child: Text(
//                                                         item,
//                                                         textAlign: TextAlign.right,
//                                                         //textDirection: //textDirection.rtl,
//                                                         locale: const Locale('ar'),
//                                                         style: const TextStyle(
//                                                           fontSize: 16,
//                                                         ),
//                                                       ),
//                                                     ))
//                                                         .toList(),
//                                                     validator: (value) {
//                                                       if (value == null) {
//                                                         return rankError;
//                                                       }
//                                                       return null;
//                                                     },
//                                                     onChanged: (value) {
//                                                       rankController.text = value.toString();
//                                                     },
//                                                     buttonStyleData: const ButtonStyleData(
//                                                       padding: EdgeInsets.only(right: 8),
//                                                     ),
//                                                     iconStyleData: const IconStyleData(
//                                                       icon: Icon(
//                                                         Icons.arrow_drop_down,
//                                                         color: Colors.white,
//                                                       ),
//                                                       iconSize: 24,
//                                                     ),
//                                                     dropdownStyleData: DropdownStyleData(
//                                                       decoration: BoxDecoration(
//                                                         borderRadius: BorderRadius.circular(15),
//                                                       ),
//                                                     ),
//                                                     menuItemStyleData: const MenuItemStyleData(
//                                                       padding: EdgeInsets.symmetric(horizontal: 16),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: nameController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.person,
//                                                       label: name,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return nameError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: phoneController,
//                                                       type: TextInputType.phone,
//                                                       suffix: Icons.phone,
//                                                       label: phone,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return phoneError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: addPhoneController,
//                                                       type: TextInputType.phone,
//                                                       suffix: Icons.phone,
//                                                       label: add_phone,
//                                                       validate: (value) {}),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: birthDateController,
//                                                       type: TextInputType.datetime,
//                                                       suffix: Icons.calendar_today,
//                                                       prefix: Icons.date_range,
//                                                       prefixColor: Colors.blue,
//                                                       prefixPressed: () {
//                                                         showDatePicker(
//                                                           context: context,
//                                                           initialDate: DateTime.now(),
//                                                           firstDate: DateTime(1900),
//                                                           lastDate: DateTime.parse('2050-12-30'),
//                                                         ).then((value) {
//                                                           birthDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
//                                                         });
//                                                       },
//                                                       label: bDate,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return bDateError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: cityController,
//                                                       type: TextInputType.datetime,
//                                                       suffix: Icons.location_city,
//                                                       label: city,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return cityError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: homeAddressController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.location_on,
//                                                       label: homeAddress,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return homeAddressError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: home_numController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.numbers,
//                                                       label: homePhone,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return homePhoneError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: nationalIDController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.credit_card,
//                                                       label: nationalId,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return nationalIdError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: soldierIDController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.credit_card,
//                                                       label: soldierlId,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return soldierlIdError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: retiringDateController,
//                                                       type: TextInputType.datetime,
//                                                       suffix: Icons.calendar_today,
//                                                       label: retireDate,
//                                                       prefix: Icons.date_range,
//                                                       prefixColor: Colors.blue,
//                                                       prefixPressed: () {
//                                                         showDatePicker(
//                                                           context: context,
//                                                           initialDate: DateTime.now(),
//                                                           firstDate: DateTime(1900),
//                                                           lastDate: DateTime.parse('2050-12-30'),
//                                                         ).then((value) {
//                                                           retiringDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
//                                                         });
//                                                       },
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return retireDateError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: facultyController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.school,
//                                                       label: faculty,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return facultyError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: specController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.school,
//                                                       label: speciality,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return specialityError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: gradeController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.grade,
//                                                       label: grade,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return gradeError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: father_jobController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.work,
//                                                       label: fatherJob,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return fatherJobError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: mother_jobController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.work,
//                                                       label: motherJob,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return motherJobError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: father_phoneController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.phone,
//                                                       label: fatherPhone,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return fatherPhoneError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: mother_phoneController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.phone,
//                                                       label: motherPhone,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return motherPhoneError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: num_of_siblingsController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.people,
//                                                       label: numOfSiblings,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return numOfSiblingsError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: skillsController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.work,
//                                                       label: skills,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return skillsError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: functionController,
//                                                       type: TextInputType.text,
//                                                       suffix: Icons.work,
//                                                       label: job,
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return jobError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   newFormField(
//                                                       textAlign: TextAlign.right,
//                                                       //textDirection: //textDirection.rtl,
//                                                       controller: joinDateController,
//                                                       type: TextInputType.datetime,
//                                                       suffix: Icons.calendar_today,
//                                                       label: joinDate,
//                                                       prefix: Icons.date_range,
//                                                       prefixColor: Colors.blue,
//                                                       prefixPressed: () {
//                                                         showDatePicker(
//                                                           context: context,
//                                                           initialDate: DateTime.now(),
//                                                           firstDate: DateTime(1970),
//                                                           lastDate: DateTime.parse('2050-12-30'),
//                                                         ).then((value) {
//                                                           joinDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
//                                                         });
//                                                       },
//                                                       validate: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return joinDateError;
//                                                         }
//                                                         return null;
//                                                       }),
//                                                   const SizedBox(height: 20),
//                                                   defaultButton(
//                                                     function: () {
//                                                       cubit.updateSoldier(
//                                                         name: nameController.text,
//                                                         rank: rankController.text,
//                                                         phone: phoneController.text,
//                                                         addPhone: addPhoneController.text,
//                                                         birthDate: birthDateController.text,
//                                                         city: cityController.text,
//                                                         image: imageController.text,
//                                                         nationalID: nationalIDController.text,
//                                                         soldierID: soldierIDController.text,
//                                                         retiringDate: retiringDateController.text,
//                                                         faculty: facultyController.text,
//                                                         spec: specController.text,
//                                                         grade: gradeController.text,
//                                                         homeAddress: homeAddressController.text,
//                                                         home_num: home_numController.text,
//                                                         father_job: father_jobController.text,
//                                                         mother_job: mother_jobController.text,
//                                                         father_phone: father_phoneController.text,
//                                                         mother_phone: mother_phoneController.text,
//                                                         num_of_siblings: num_of_siblingsController.text,
//                                                         skills: skillsController.text,
//                                                         function: functionController.text,
//                                                         joinDate: joinDateController.text,
//                                                       );
//
//                                                     },
//                                                     background: Colors.green,
//                                                     text: edit,
//                                                     fSize: 20.0,
//                                                     radius: 15.0,
//                                                   ),
//                                                 ]),
//                                               ),
//                                           fallback: (BuildContext
//                                           context) =>
//                                           const Center(
//                                               child:
//                                               CircularProgressIndicator()),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                       text: edit,
//                       background: Colors.blueAccent),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// Widget editSoldier(cubit, context, submitBtn) => SingleChildScrollView(
//   child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//     const SizedBox(height: 20),
//     Center(
//       child: Stack(
//         children: [
//           const CircleAvatar(
//             radius: 100.0,
//             backgroundImage: AssetImage('assets/images/unknown_image.png'),
//           ),
//           Positioned(
//             bottom: 20.0,
//             right: 20.0,
//             child: InkWell(
//               onTap: () {
//                 cubit.pickImage();
//               },
//               child: const Icon(
//                 Icons.camera_alt_outlined,
//                 color: Colors.green,
//                 size: 30.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//     const SizedBox(height: 20),
//     DropdownButtonFormField2<String>(
//       alignment: Alignment.centerRight,
//       isExpanded: true,
//       style: const TextStyle(
//         locale: Locale('ar'),
//         color: Colors.black,
//         fontSize: 16,
//       ),
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(vertical: 16),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       hint: const Text(
//         rank,
//         style: TextStyle(fontSize: 16, color: Colors.black),
//         //textDirection: //textDirection.rtl,
//         textAlign: TextAlign.right,
//         locale: Locale('ar'),
//       ),
//       items: ranks
//           .map((item) => DropdownMenuItem<String>(
//         value: item,
//         child: Text(
//           item,
//           textAlign: TextAlign.right,
//           //textDirection: //textDirection.rtl,
//           locale: const Locale('ar'),
//           style: const TextStyle(
//             fontSize: 16,
//           ),
//         ),
//       ))
//           .toList(),
//       validator: (value) {
//         if (value == null) {
//           return rankError;
//         }
//         return null;
//       },
//       onChanged: (value) {
//         rankController.text = value.toString();
//       },
//       buttonStyleData: const ButtonStyleData(
//         padding: EdgeInsets.only(right: 8),
//       ),
//       iconStyleData: const IconStyleData(
//         icon: Icon(
//           Icons.arrow_drop_down,
//           color: Colors.white,
//         ),
//         iconSize: 24,
//       ),
//       dropdownStyleData: DropdownStyleData(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       menuItemStyleData: const MenuItemStyleData(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//       ),
//     ),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: nameController,
//         type: TextInputType.text,
//         suffix: Icons.person,
//         label: name,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return nameError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: phoneController,
//         type: TextInputType.phone,
//         suffix: Icons.phone,
//         label: phone,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return phoneError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: addPhoneController,
//         type: TextInputType.phone,
//         suffix: Icons.phone,
//         label: add_phone,
//         validate: (value) {}),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: birthDateController,
//         type: TextInputType.datetime,
//         suffix: Icons.calendar_today,
//         prefix: Icons.date_range,
//         prefixColor: Colors.blue,
//         prefixPressed: () {
//           showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(1900),
//             lastDate: DateTime.parse('2050-12-30'),
//           ).then((value) {
//             birthDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
//           });
//         },
//         label: bDate,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return bDateError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: cityController,
//         type: TextInputType.datetime,
//         suffix: Icons.location_city,
//         label: city,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return cityError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: homeAddressController,
//         type: TextInputType.text,
//         suffix: Icons.location_on,
//         label: homeAddress,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return homeAddressError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: home_numController,
//         type: TextInputType.text,
//         suffix: Icons.numbers,
//         label: homePhone,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return homePhoneError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: nationalIDController,
//         type: TextInputType.text,
//         suffix: Icons.credit_card,
//         label: nationalId,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return nationalIdError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: soldierIDController,
//         type: TextInputType.text,
//         suffix: Icons.credit_card,
//         label: soldierlId,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return soldierlIdError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: retiringDateController,
//         type: TextInputType.datetime,
//         suffix: Icons.calendar_today,
//         label: retireDate,
//         prefix: Icons.date_range,
//         prefixColor: Colors.blue,
//         prefixPressed: () {
//           showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(1900),
//             lastDate: DateTime.parse('2050-12-30'),
//           ).then((value) {
//             retiringDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
//           });
//         },
//         validate: (value) {
//           if (value!.isEmpty) {
//             return retireDateError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: facultyController,
//         type: TextInputType.text,
//         suffix: Icons.school,
//         label: faculty,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return facultyError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: specController,
//         type: TextInputType.text,
//         suffix: Icons.school,
//         label: speciality,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return specialityError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: gradeController,
//         type: TextInputType.text,
//         suffix: Icons.grade,
//         label: grade,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return gradeError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: father_jobController,
//         type: TextInputType.text,
//         suffix: Icons.work,
//         label: fatherJob,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return fatherJobError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: mother_jobController,
//         type: TextInputType.text,
//         suffix: Icons.work,
//         label: motherJob,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return motherJobError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: father_phoneController,
//         type: TextInputType.text,
//         suffix: Icons.phone,
//         label: fatherPhone,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return fatherPhoneError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: mother_phoneController,
//         type: TextInputType.text,
//         suffix: Icons.phone,
//         label: motherPhone,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return motherPhoneError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: num_of_siblingsController,
//         type: TextInputType.text,
//         suffix: Icons.people,
//         label: numOfSiblings,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return numOfSiblingsError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: skillsController,
//         type: TextInputType.text,
//         suffix: Icons.work,
//         label: skills,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return skillsError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: functionController,
//         type: TextInputType.text,
//         suffix: Icons.work,
//         label: job,
//         validate: (value) {
//           if (value!.isEmpty) {
//             return jobError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     newFormField(
//         textAlign: TextAlign.right,
//         //textDirection: //textDirection.rtl,
//         controller: joinDateController,
//         type: TextInputType.datetime,
//         suffix: Icons.calendar_today,
//         label: joinDate,
//         prefix: Icons.date_range,
//         prefixColor: Colors.blue,
//         prefixPressed: () {
//           showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(1970),
//             lastDate: DateTime.parse('2050-12-30'),
//           ).then((value) {
//             joinDateController.text = convertToArabic(DateFormat('yyyy/MM/dd').format(value!));
//           });
//         },
//         validate: (value) {
//           if (value!.isEmpty) {
//             return joinDateError;
//           }
//           return null;
//         }),
//     const SizedBox(height: 20),
//     defaultButton(
//       function: () {
//         cubit.enterNewSoldier(
//           name: nameController.text,
//           rank: rankController.text,
//           phone: phoneController.text,
//           addPhone: addPhoneController.text,
//           birthDate: birthDateController.text,
//           city: cityController.text,
//           image: imageController.text,
//           nationalID: nationalIDController.text,
//           soldierID: soldierIDController.text,
//           retiringDate: retiringDateController.text,
//           faculty: facultyController.text,
//           spec: specController.text,
//           grade: gradeController.text,
//           homeAddress: homeAddressController.text,
//           home_num: home_numController.text,
//           father_job: father_jobController.text,
//           mother_job: mother_jobController.text,
//           father_phone: father_phoneController.text,
//           mother_phone: mother_phoneController.text,
//           num_of_siblings: num_of_siblingsController.text,
//           skills: skillsController.text,
//           function: functionController.text,
//           joinDate: joinDateController.text,
//         );
//       },
//       background: Colors.green,
//       text: submitBtn,
//       fSize: 20.0,
//       radius: 15.0,
//     ),
//   ]),
// );