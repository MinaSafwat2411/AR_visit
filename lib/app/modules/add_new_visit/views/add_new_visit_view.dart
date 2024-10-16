import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textformfield.dart';
import '../controllers/add_new_visit_controller.dart';

class AddNewVisitView extends GetView<AddNewVisitController> {
  const AddNewVisitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Visit',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            fontFamily: 'Inter',
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // navigateandend(context, ArVisitLayout());
            Get.back();
          },
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormfield(
                          label:'Patient Name' ,
                          validator: (name){
                          if (name == null || name.isEmpty) {
                            return 'Patient name can\'t be empty';
                          }
                          return null;
                        },
                          textController: controller.patientNameController,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 8, 8, 8),
                              child: Text(
                                'E1C1F',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 45,
                              child: TextFormField(
                                  controller: controller.patientFamIDController,
                                  decoration: InputDecoration(
                                    labelText: 'XXXX',
                                    floatingLabelStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 239, 84, 0),
                                      ),
                                    ),
                                  ),
                                  autofocus: false,
                                  cursorColor:
                                      const Color.fromARGB(255, 239, 84, 0),
                                  validator: (familyID) {
                                    if (familyID == null || familyID.isEmpty) {
                                      return 'Patient\'s family ID must be entered';
                                    } else if (familyID.length >= 7) {
                                      return 'Patient\'s family ID must be 1 to 6 digits';
                                    }
                                    return null;
                                  }),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 8, 12, 8),
                              child: Text(
                                'NR',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.255,
                              height: 45,
                              child: TextFormField(
                                controller:
                                    controller.patientIDNumberController,
                                decoration: InputDecoration(
                                  labelText: 'X',
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 239, 84, 0),
                                    ),
                                  ),
                                ),
                                autofocus: false,
                                cursorColor:
                                    const Color.fromARGB(255, 239, 84, 0),
                                validator: (patientID) {
                                  if (patientID == null || patientID.isEmpty) {
                                    return 'Patient\'s ID must be entered';
                                  } else if (patientID.length != 1) {
                                    return 'Patient\'s ID must be 1 digit';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormfield(
                          textController: controller.patientPhoneController,
                            label:'Patient Phone Number' ,
                            validator:(phone) {
                              if (phone == null || phone.isEmpty) {
                                return 'Patient\'s phone number must be entered';
                              } else if (phone.length != 11) {
                                return 'Patient\'s phone must consist of 11 digits';
                              }
                              return null;
                            },
                            ),
                        const SizedBox(height: 12),
                        CustomTextFormfield(
                          textController: controller.assistantNameController,
                          validator: (value) {
                            return null;
                          },
                          label:'Assistant Name' ,
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormfield(
                          label: 'Assistant Phone',
                          textController: controller.assistantPhoneController,
                          validator: (assisstantPhone) {
                            // Allow the field to be empty
                            if (assisstantPhone == null ||
                                assisstantPhone.isEmpty) {
                              return null;
                            }
                            if (assisstantPhone.length != 11) {
                              return 'Phone must consist of 11 numbers';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          items:
                              ['Hospital', 'Home', 'Dar'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                              controller.addressType = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'Address Type',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormfield(
                          label: 'Address',
                          textController: controller.patientAddressController,
                          validator: (address) {
                            if (address == null || address.isEmpty) {
                              return 'Patient\'s address must be entered';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          items: controller.areaNames.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                              controller.areaName = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'Area',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormfield(
                          textController: controller.patientLocationController,
                          label: 'Google Maps Link',
                          validator: (value) {
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormfield(
                          label: 'Date',
                          textController: controller.dateController,
                          validator: (date) {
                            if (date == null || date.isEmpty) {
                              return 'Date of visit must be chosen';
                            }
                            return null;
                          },
                          onTap: () {
                            controller.selectDate(context);
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 8, 8, 8),
                              child: Text(
                                'From:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.284,
                              height: 45,
                              child: TextFormField(
                                controller: controller.fromTimeController,
                                decoration: InputDecoration(
                                  labelText: 'Start',
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 239, 84, 0),
                                    ),
                                  ),
                                ),
                                readOnly: true,
                                autofocus: false,
                                validator: (start) {
                                  if (start == null || start.isEmpty) {
                                    return 'Start time of visit must be chosen';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  controller.selectedFromTime(context);
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 8, 12, 8),
                              child: Text(
                                'To:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.284,
                              height: 45,
                              child: TextFormField(
                                controller: controller.toTimeController,
                                decoration: InputDecoration(
                                  labelText: 'End',
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 239, 84, 0),
                                    ),
                                  ),
                                ),
                                readOnly: true,
                                autofocus: false,
                                onTap: () {
                                  controller.selectedToTime(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 120,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Notes',
                              floatingLabelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 239, 84, 0),
                                ),
                              ),
                            ),
                            autofocus: false,
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            cursorColor: const Color.fromARGB(255, 239, 84, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 58,
                  child: ConditionalBuilder(
                    fallback: (context) => const SizedBox(
                      width: 50,height: 50,
                        child: CircularProgressIndicator(color: AppColors.Trinidad,)),
                    builder: (context) => CustomButton(
                      text: 'Submit',
                      btncolor:  AppColors.trinidadColor,
                      onPressed: () {
                        if(controller.formKey.currentState!.validate()){
                          controller.addVisit();
                        }
                      },
                    ),
                    condition: !controller.isLoading.value,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
