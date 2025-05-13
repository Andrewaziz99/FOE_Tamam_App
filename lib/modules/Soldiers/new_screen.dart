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

class NewScreen extends StatelessWidget {

  final imagesPath = CacheHelper.getData(key: 'images_folder');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getAllSoldiers(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {
            var cubit = AppCubit.get(context);

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


                ],
              ),
            );
          },
        )
    );
  }
}
