import 'package:ar_visiting_app/app/core/widgets/custom_small_textField.dart';
import 'package:ar_visiting_app/app/modules/edit_visit/controllers/edit_visit_controller.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_alert.dart';
import '../../../core/widgets/custom_big_textfield.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_dropdownlist.dart';
import '../../../core/widgets/custom_textformfield.dart';

class EditVisitView extends GetView<EditVisitController> {
  const EditVisitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(
            controller.getEditVisitTitle(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              fontFamily: 'Inter',
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 58,
          child: CustomButton(
            text: controller.getEdit(),
            btnColor: AppColors.trinidadColor,
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                showDialog(
                    context: context,
                    builder:(context) =>CustomDoubleAlert(
                      title: controller.getEditVisitComfirm(),
                      rightFunction: () {
                        Get.back(closeOverlays: true);
                      },
                      leftFunction: () {
                        controller.editVisit();
                      },
                      rightButtonText: controller.getComfirmNo(),
                      leftButtonText: controller.getComfirmYes(),
                    ));
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
                              label: controller.getPatientName(),
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return controller.getPatientNameValidate();
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
                                  ),
                                ],
                              ),
                            ),
                            CustomTextFormField(
                              textController: controller.patientPhoneController,
                              label: controller.getPatientPhoneNumber(),
                              validator: (phone) {
                                return null;
                              },
                            ),
                            CustomTextFormField(
                              textController: controller.assistantNameController,
                              validator: (value) {
                                if(value ==null||value.isEmpty){
                                  return controller.getAssistantNameValidate();
                                }else {
                                  return null;
                                }
                              },
                              label: controller.getAssistantName(),
                            ),
                            CustomTextFormField(
                              textController: controller.numberOfPeopleController,
                              validator: (value) {
                                return null;
                              },
                              label: controller.getNoOfPeople(),
                            ),
                            CustomTextFormField(
                              label: controller.getAssistantPhoneNumber(),
                              textController: controller.assistantPhoneController,
                              validator: (assistantPhone) {
                                // Allow the field to be empty
                                if (assistantPhone == null ||
                                    assistantPhone.isEmpty) {
                                  return controller.getAssistantPhoneNumberValidate1();
                                }
                                if (assistantPhone.length != 11) {
                                  return controller.getAssistantPhoneNumberValidate2();
                                }
                                return null;
                              },
                            ),
                            CustomDropDownList(
                              onChangeValue: (String? value) {
                                controller.addressType.value = value!;
                              },
                              label: controller.getAddressType(),
                              items: controller.getAddressTypeList(),
                            ),
                            CustomTextFormField(
                              label: controller.getAddress(),
                              textController: controller.patientAddressController,
                              validator: (address) {
                                if (address == null || address.isEmpty) {
                                  return controller.getAddressValidate();
                                }
                                return null;
                              },
                            ),
                            CustomDropDownList(
                              onChangeValue:(String? value) {
                                controller.areaName.value = value!;
                              },
                              label: controller.getZone(),
                              items: controller.areaNames,
                            ),
                            CustomTextFormField(
                              textController: controller.googleLinkController,
                              label: controller.getGoogleMapLink(),
                              validator: (value) {
                                return null;
                              },
                            ),
                            CustomTextFormField(
                              label: controller.getDate(),
                              textController: controller.dateController,
                              validator: (date) {
                                if (date == null || date.isEmpty) {
                                  return controller.getDateValidate();
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
                                  Text(
                                    controller.getFrom(),
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  CustomSmallTextField(
                                    label: controller.getStart(),
                                    validator: (start) {
                                      if (start == null || start.isEmpty) {
                                        return controller.getFromValidate();
                                      }
                                      return null;
                                    },
                                    textController: controller.fromTimeController,
                                    function: () {
                                      controller.selectedFromTime(context);
                                    },
                                  ),
                                  Text(
                                    controller.getTo(),
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  CustomSmallTextField(
                                    function: () {
                                      controller.selectedToTime(context);
                                    },
                                    textController: controller.toTimeController,
                                    validator: (end) {
                                      if (end == null || end.isEmpty) {
                                        return controller.getToValidate();
                                      }
                                      return null;
                                    },
                                    label: controller.getEnd(),
                                  ),
                                ],
                              ),
                            ),
                            CustomBigTextField(
                                label: controller.getNotes(),
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
