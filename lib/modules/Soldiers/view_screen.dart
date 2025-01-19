import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';
import 'package:tamam/shared/components/components.dart';
import 'package:tamam/shared/components/constants.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';

import 'new_soldier_screen.dart';

class ViewScreen extends StatelessWidget {
  ViewScreen({super.key});

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



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getAllSoldiers(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {

            var cubit = AppCubit.get(context);

            if (state is getSoldierByIdSuccess) {
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
            }



          },
          builder: (BuildContext context, Object? state) {
            var cubit = AppCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                elevation: 0.5,
                title: const Text(
                  appTitle,
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
                centerTitle: true,
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: addNewSoldier,
                isExtended: true,
                backgroundColor: Colors.redAccent,
                hoverColor: Colors.amberAccent,
                hoverElevation: 10.0,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 20),
                              ConditionalBuilder(
                                condition: state is! enterNewSoldierLoading,
                                builder: (BuildContext context) =>
                                    addSoldier(cubit, context, add),
                                fallback: (BuildContext context) =>
                                    const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
              body: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Semi-Transparent Overlay
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                    ),
                  ),
                  // Main Content
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: const BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: ConditionalBuilder(
                          condition: cubit.soldiersList.isNotEmpty ||
                              state is! getAllSoldiersLoading,
                          builder: (BuildContext context) {
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.soldiersList.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      myDivider(),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ListTile(
                                    leading: const Icon(Icons.arrow_back_ios, color: Colors.white60,),
                                    textColor: Colors.white,
                                    title: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        cubit.soldiersList[index].soldierName!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.transparent,
                                                content: OctoImage(
                                                    image: cubit
                                                                    .soldiersList[
                                                                        index]
                                                                    .soldierImage !=
                                                                null &&
                                                            cubit
                                                                .soldiersList[
                                                                    index]
                                                                .soldierImage!
                                                                .isNotEmpty
                                                        ? FileImage(File(cubit
                                                            .soldiersList[index]
                                                            .soldierImage!))
                                                        : const AssetImage(
                                                                'assets/images/unknown_image.png')
                                                            as ImageProvider),
                                                actions: [
                                                  defaultButton(
                                                      function: () {
                                                        Navigator.pop(context);
                                                      },
                                                      background: Colors.white,
                                                      tColor: Colors.black,
                                                      width: 200.0,
                                                      radius: 20.0,
                                                      fSize: 20.0,
                                                      text: back),
                                                  const SizedBox(width: 20.0),
                                                  defaultButton(
                                                      function: () async {
                                                        await cubit.pickImage();
                                                        editImageController.text = cubit.savedImagePath;
                                                      },
                                                      background: Colors.blue,
                                                      tColor: Colors.white,
                                                      width: 200.0,
                                                      radius: 20.0,
                                                      fSize: 20.0,
                                                      text: edit),
                                                ],
                                                actionsAlignment: MainAxisAlignment.center,
                                              );
                                            });
                                      },
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: cubit
                                                        .soldiersList[index]
                                                        .soldierImage !=
                                                    null &&
                                                cubit.soldiersList[index]
                                                    .soldierImage!.isNotEmpty
                                            ? FileImage(File(cubit
                                                .soldiersList[index]
                                                .soldierImage!))
                                            : const AssetImage(
                                                    'assets/images/unknown_image.png')
                                                as ImageProvider,
                                      ),
                                    ),
                                    onTap: () {
                                      cubit.getSoldierById(
                                          cubit.soldiersList[index].soldierId!);

                                    },
                                  ),
                                );
                              },
                            );
                          },
                          fallback: (BuildContext context) => const Center(
                            child: Text(
                              noData,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Left Soldier Data Area
                  if(cubit.soldierModel != null)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.6, // Example: 40% of screen width
                        decoration: const BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: ConditionalBuilder(
                          condition: cubit.soldierModel != null || state is! getSoldierByIdLoading,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //Values
                                    Expanded(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editRankController,
                                                type: TextInputType.text,
                                                label: rank,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editNameController,
                                                type: TextInputType.text,
                                                label: name,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editSoldierIDController,
                                                type: TextInputType.text,
                                                label: soldierlId,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editNationalIDController,
                                                type: TextInputType.text,
                                                label: nationalId,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editPhoneController,
                                                type: TextInputType.text,
                                                label: phone,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editAddPhoneController,
                                                type: TextInputType.text,
                                                label: add_phone,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editFather_phoneController,
                                                type: TextInputType.text,
                                                label: fatherPhone,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editMother_phoneController,
                                                type: TextInputType.text,
                                                label: motherPhone,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editCityController,
                                                type: TextInputType.text,
                                                label: city,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editHomeAddressController,
                                                type: TextInputType.text,
                                                label: homeAddress,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editBirthDateController,
                                                type: TextInputType.text,
                                                label: bDate,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editFacultyController,
                                                type: TextInputType.text,
                                                label: faculty,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editSpecController,
                                                type: TextInputType.text,
                                                label: speciality,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editSkillsController,
                                                type: TextInputType.text,
                                                label: skills,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editFather_jobController,
                                                type: TextInputType.text,
                                                label: fatherJob,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editMother_jobController,
                                                type: TextInputType.text,
                                                label: motherJob,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editFunctionController,
                                                type: TextInputType.text,
                                                label: job,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 20.0),

                                            defaultFormField(
                                                controller: editRetiringDateController,
                                                type: TextInputType.text,
                                                label: retireDate,
                                                validate: (val){
                                                  if(val!.isEmpty){
                                                    return 'Name must not be empty';
                                                  }
                                                  return null;
                                                }
                                            ),

                                            const SizedBox(height: 30.0),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                defaultButton(
                                                  radius: 30.0,
                                                  fSize: 20.0,
                                                  tColor: Colors.white,
                                                  background: Colors.greenAccent,
                                                  width: MediaQuery.of(context).size.width *
                                                      0.2,
                                                  function: () {
                                                    showDialog(context: context, builder: (context) {
                                                      return AlertDialog(
                                                        content: OctoImage(
                                                          image: cubit.soldierModel != null &&
                                                              cubit.soldierModel!.soldierNationalIdImage != null &&
                                                              cubit.soldierModel!.soldierNationalIdImage!.isNotEmpty
                                                              ? FileImage(File(cubit.soldierModel!.soldierNationalIdImage!))
                                                              : const AssetImage('assets/images/unknown_image.png') as ImageProvider,
                                                          errorBuilder: OctoError.icon(color: Colors.red),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        actions: [
                                                          defaultButton(
                                                              function: () {
                                                                Navigator.pop(context);
                                                              },
                                                              background: Colors.black,
                                                              tColor: Colors.white,
                                                              radius: 20.0,
                                                              fSize: 20.0,
                                                              text: back),
                                                        ],
                                                      );
                                                    });
                                                  },
                                                  text: soldierNationalIdImage,
                                                ),

                                                const SizedBox(width: 20.0),

                                                defaultButton(
                                                  radius: 30.0,
                                                  fSize: 20.0,
                                                  tColor: Colors.white,
                                                  background: Colors.greenAccent,
                                                  width: MediaQuery.of(context).size.width *
                                                      0.2,
                                                  function: () {
                                                    showDialog(context: context, builder: (context) {
                                                      return AlertDialog(
                                                        content: OctoImage(
                                                          image: cubit.soldierModel != null &&
                                                              cubit.soldierModel!.soldierIdImage != null &&
                                                              cubit.soldierModel!.soldierIdImage!.isNotEmpty
                                                              ? FileImage(File(cubit.soldierModel!.soldierIdImage!))
                                                              : const AssetImage('assets/images/unknown_image.png') as ImageProvider,
                                                          errorBuilder: OctoError.icon(color: Colors.red),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        actions: [
                                                          defaultButton(
                                                              function: () {
                                                                Navigator.pop(context);
                                                              },
                                                              background: Colors.black,
                                                              tColor: Colors.white,
                                                              radius: 20.0,
                                                              fSize: 20.0,
                                                              text: back),
                                                        ],
                                                      );
                                                    });
                                                  },
                                                  text: soldierIdImage,
                                                ),

                                              ],
                                            ),

                                            const SizedBox(height: 50.0),

                                            if(cubit.soldierModel != null)
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                defaultButton(
                                                  radius: 30.0,
                                                  fSize: 20.0,
                                                  tColor: Colors.white,
                                                  background: Colors.redAccent,
                                                  width: MediaQuery.of(context).size.width *
                                                      0.2,
                                                  function: () {
                                                    showDialog(context: context, builder: (context) {
                                                      return AlertDialog(
                                                        alignment: Alignment.center,
                                                        title: const Center(child: Text(deleteSoldier)),
                                                        content: const Text(deleteSoldierProgress),
                                                        actions: [
                                                          defaultButton(
                                                              function: () {
                                                                cubit.deleteSoldier(cubit.soldierModel!.soldierId!);
                                                                Navigator.pop(context);
                                                              },
                                                              background: Colors.redAccent,
                                                              tColor: Colors.white,
                                                              radius: 20.0,
                                                              fSize: 20.0,
                                                              text: confirmDelete),
                                                          const SizedBox(height: 20.0),
                                                          defaultButton(
                                                              function: () {
                                                                Navigator.pop(context);
                                                              },
                                                              background: Colors.black,
                                                              tColor: Colors.white,
                                                              radius: 20.0,
                                                              fSize: 20.0,
                                                              text: cancel),
                                                        ],
                                                      );
                                                    });
                                                  },
                                                  text: delete,
                                                ),
                                                const SizedBox(width: 20.0),
                                                defaultButton(
                                                  radius: 30.0,
                                                  fSize: 20.0,
                                                  tColor: Colors.white,
                                                  background: Colors.blueAccent,
                                                  width: MediaQuery.of(context).size.width *
                                                      0.2,
                                                  text: edit,
                                                  function: () {
                                                    cubit.updateSoldier(
                                                      name: editNameController.text,
                                                      rank: editRankController.text,
                                                      phone: editPhoneController.text,
                                                      addPhone: editAddPhoneController.text,
                                                      birthDate: editBirthDateController.text,
                                                      city: editCityController.text,
                                                      image: cubit.savedImagePath,
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
                                                ),
                                              ],
                                            )



                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 30.0),

                                    //Constants
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.end,
                                    //   children: [
                                    //     const Text(':$rank', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$name', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$soldierlId', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$nationalId', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$phone', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$add_phone', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$fatherPhone', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$motherPhone', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$city', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$homeAddress', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$bDate', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$faculty', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$speciality', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$fatherJob', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$motherJob', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$job', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //
                                    //     const SizedBox(height: 20.0),
                                    //
                                    //     const Text(':$retireDate', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                    //

                                    //
                                    //
                                    //   ],
                                    // ),




                                  ],
                                ),
                              ),
                            );
                          },
                          fallback: (BuildContext context) => const Center(
                            child: Text(
                              noData,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        ));
  }
}
