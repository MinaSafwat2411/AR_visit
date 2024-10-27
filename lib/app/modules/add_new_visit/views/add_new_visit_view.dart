import 'package:ar_visiting_app/app/core/widgets/custom_small_textField.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_big_textfield.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_dropdownlist.dart';
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
            Get.offNamed(Routes.VISITS);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 58,
        child: CustomButton(
          text: 'Submit',
          btnColor: AppColors.trinidadColor,
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              controller.addVisit();
              if(!controller.isLoading.value){
                Get.offAll(Routes.VISITS);
              }
            }
          },
        ),
      ),
      body: Obx(() =>ConditionalBuilder(
          condition: !controller.isLoading.value,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                          CustomTextFormField(
                            label: 'Patient Name',
                            validator: (name) {
                              if (name == null || name.isEmpty) {
                                return 'Patient name can\'t be empty';
                              }
                              return null;
                            },
                            textController: controller.patientNameController,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'E1C1F',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                CustomSmallTextField(
                                  validator: (familyID) {
                                    if (familyID == null || familyID.isEmpty) {
                                      return 'Patient\'s family ID must be entered';
                                    } else if (familyID.length >= 7) {
                                      return 'Patient\'s family ID must be 1 to 6 digits';
                                    }
                                    return null;
                                  },
                                  textController: controller.patientFamIDController,
                                  label: 'XXXX',
                                ),
                                const Text(
                                  'NR',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                CustomSmallTextField(
                                  label: 'X',
                                  textController:
                                  controller.patientIDNumberController,
                                  validator: (patientID) {
                                    if (patientID == null || patientID.isEmpty) {
                                      return 'Patient\'s ID must be entered';
                                    } else if (patientID.length != 1) {
                                      return 'Patient\'s ID must be 1 digit';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          CustomTextFormField(
                            textController: controller.patientPhoneController,
                            label: 'Patient Phone Number',
                            validator: (phone) {
                              if (phone == null || phone.isEmpty) {
                                return 'Patient\'s phone number must be entered';
                              } else if (phone.length != 11) {
                                return 'Patient\'s phone must consist of 11 digits';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            textController: controller.assistantNameController,
                            validator: (value) {
                              return null;
                            },
                            label: 'Assistant Name',
                          ),
                          CustomTextFormField(
                            textController: controller.numberOfPeopleController,
                            validator: (value) {
                              return null;
                            },
                            label: 'No. of People',
                          ),
                          CustomTextFormField(
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
                          CustomDropDownList(
                            onChangeValue: controller.addressType.value,
                            label: 'Address Type',
                            items: const ['Hospital', 'Home', 'Dar'],
                          ),
                          CustomTextFormField(
                            label: 'Address',
                            textController: controller.patientAddressController,
                            validator: (address) {
                              if (address == null || address.isEmpty) {
                                return 'Patient\'s address must be entered';
                              }
                              return null;
                            },
                          ),
                          CustomDropDownList(
                            onChangeValue: controller.areaName.value,
                            label: 'Area',
                            items: controller.areaNames,
                          ),
                          CustomTextFormField(
                            textController: controller.googleLinkController,
                            label: 'Google Maps Link',
                            validator: (value) {
                              return null;
                            },
                          ),
                          CustomTextFormField(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'From:',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                CustomSmallTextField(
                                  label: 'Start',
                                  validator: (start) {
                                    if (start == null || start.isEmpty) {
                                      return 'Start time of visit must be chosen';
                                    }
                                    return null;
                                  },
                                  textController: controller.fromTimeController,
                                  function: () {
                                    controller.selectedFromTime(context);
                                  },
                                ),
                                const Text(
                                  'To:',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                CustomSmallTextField(
                                  function: () {
                                    controller.selectedToTime(context);
                                  },
                                  textController: controller.toTimeController,
                                  validator: (end) {
                                    if (end == null || end.isEmpty) {
                                      return 'Start time of visit must be chosen';
                                    }
                                    return null;
                                  },
                                  label: 'End',
                                ),
                              ],
                            ),
                          ),
                          CustomBigTextField(
                              label: 'Notes',
                              controller: controller.noteController
                          ),
                          const SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.trinidadColor,
            ),
          ))

    )
    );
  }
}
