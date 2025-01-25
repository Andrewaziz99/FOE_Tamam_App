import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';
import 'package:tamam/shared/components/components.dart';
import 'package:tamam/shared/components/constants.dart';
import 'package:tamam/shared/cubit/cubit.dart';
import 'package:tamam/shared/cubit/states.dart';
import 'package:tamam/shared/network/local/cache_helper.dart';

import 'new_soldier_screen.dart';

class ViewScreen extends StatelessWidget {
  ViewScreen({super.key});

  final imagesPath = CacheHelper.getData(key: 'images_folder');

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
  TextEditingController editSoldierIdImageController = TextEditingController();
  TextEditingController editSoldierNationalIdImageController = TextEditingController();



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
              editSoldierIdImageController.text = cubit.soldierModel!.soldierIdImage!;
              editSoldierNationalIdImageController.text = cubit.soldierModel!.soldierNationalIdImage!;
            }

            if (state is updateSoldierImageSuccess) {
              editImageController.clear();
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
                title: const Text(updateImageSuccess),
              ).show(context);
            }

            if (state is updateSoldierImageLoading) {
              editImageController.clear();
              cubit.savedImagePath = '';
              cubit.imageFileName = '';
            }

            if (state is enterNewSoldierError) {
              cubit.savedImagePath = '';
              cubit.savedSoldierIdImagePath = '';
              cubit.savedSoldierNationalIdImagePath = '';
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
              cubit.savedSoldierIdImagePath = '';
              cubit.savedSoldierNationalIdImagePath = '';
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
              editImageController.text = cubit.imageFileName;
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
              cubit.savedImagePath = '';
              cubit.savedSoldierIdImagePath = '';
              cubit.savedSoldierNationalIdImagePath = '';
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

            if (state is pickSoldierIdImageSuccess) {
              editSoldierIdImageController.text = cubit.soldierIdImageName;
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

            if (state is pickSoldierNationalIdImageSuccess) {
              editSoldierNationalIdImageController.text = cubit.soldierNationalIdImageName;
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
                                                        ? FileImage(File('$imagesPath\\${cubit.soldiersList[index].soldierImage!}'))
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
                                                        editImageController.text = cubit.imageFileName;
                                                      },
                                                      background: Colors.blue,
                                                      tColor: Colors.white,
                                                      width: 200.0,
                                                      radius: 20.0,
                                                      fSize: 20.0,
                                                      text: selectImage),

                                                  const SizedBox(width: 20.0),
                                                  defaultButton(
                                                      function: () async {
                                                        await cubit.updateSoldierImage(soldierId: cubit.soldiersList[index].soldierId!, imagePath: editImageController.text);
                                                        Navigator.pop(context);
                                                      },
                                                      background: Colors.green,
                                                      tColor: Colors.white,
                                                      width: 200.0,
                                                      radius: 20.0,
                                                      fSize: 20.0,
                                                      text: save),
                                                ],
                                                actionsAlignment: MainAxisAlignment.center,
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: cubit
                                                .soldiersList[index]
                                                .soldierImage !=
                                                null &&
                                                cubit.soldiersList[index]
                                                    .soldierImage!.isNotEmpty
                                                ? FileImage(File('$imagesPath\\${cubit.soldiersList[index].soldierImage!}'))
                                                : const AssetImage(
                                                'assets/images/unknown_image.png')
                                            as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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

                                            defaultArabicFormField(
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
                                                              ? FileImage(File('$imagesPath\\${cubit.soldierModel!.soldierNationalIdImage!}'))
                                                              : const AssetImage('assets/images/unknown_image.png') as ImageProvider,
                                                          errorBuilder: OctoError.icon(color: Colors.red),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        actions: [
                                                          defaultButton(
                                                              function: () {
                                                                cubit.pickSoldierNationalIdImage();
                                                                editSoldierNationalIdImageController.text = cubit.soldierNationalIdImageName;

                                                              },
                                                              background: Colors.blue,
                                                              tColor: Colors.white,
                                                              radius: 20.0,
                                                              fSize: 20.0,
                                                              text: selectImage),
                                                          const SizedBox(height: 20.0),
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
                                                              ? FileImage(File('$imagesPath\\${cubit.soldierModel!.soldierIdImage!}'))
                                                              : const AssetImage('assets/images/unknown_image.png') as ImageProvider,
                                                          errorBuilder: OctoError.icon(color: Colors.red),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        actions: [
                                                          defaultButton(
                                                              function: () {
                                                                cubit.pickSoldierIdImage();
                                                                editSoldierIdImageController.text = cubit.soldierIdImageName;

                                                              },
                                                              background: Colors.blue,
                                                              tColor: Colors.white,
                                                              radius: 20.0,
                                                              fSize: 20.0,
                                                              text: selectImage),
                                                          const SizedBox(height: 20.0),
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
                                                      id: cubit.soldierModel!.id.toString(),
                                                      name: editNameController.text,
                                                      rank: editRankController.text,
                                                      phone: editPhoneController.text,
                                                      addPhone: editAddPhoneController.text,
                                                      birthDate: editBirthDateController.text,
                                                      city: editCityController.text,
                                                      image: editImageController.text,
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
                                                      soldierIdImage: editSoldierIdImageController.text,
                                                      soldierNationalIdImage: editSoldierNationalIdImageController.text,
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
