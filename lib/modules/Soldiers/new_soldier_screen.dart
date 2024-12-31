import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tamam/shared/components/constants.dart';

import '../../shared/components/components.dart';

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


Widget addSoldier(cubit, context, submitBtn) => SingleChildScrollView(
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
            cubit.enterNewSoldier(
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
          text: submitBtn,
          fSize: 20.0,
          radius: 15.0,
        ),
      ]),
    );
