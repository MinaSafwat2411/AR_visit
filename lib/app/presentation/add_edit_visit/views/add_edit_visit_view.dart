import 'package:ar_visiting_app/app/core/widgets/custom_small_textField.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_alert.dart';
import '../../../core/widgets/custom_big_textfield.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_dropdownlist.dart';
import '../../../core/widgets/custom_textformfield.dart';
import '../controllers/add_edit_visit_controller.dart';

class AddEditVisitView extends GetView<AddEditVisitController> {
  const AddEditVisitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
                controller.titles[controller.currentScreen.value],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontFamily: 'Inter',
                ),
              )),
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
          child: Obx(() => ConditionalBuilder(
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.trinidadColor,
                    ),
                  ),
              condition: !controller.internalLoading.value,
              builder: (context) {
                return Obx(() => CustomButton(
                      text:
                          controller.buttonText[controller.currentScreen.value],
                      btnColor: AppColors.trinidadColor,
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) => CustomDoubleAlert(
                                    title: 'Save Visit',
                                    rightFunction: () {
                                      Get.back(closeOverlays: true);
                                    },
                                    leftFunction: () {
                                      Get.back(closeOverlays: true);
                                      switch (controller.currentScreen.value) {
                                        case 0:
                                          controller.addVisit();
                                        case 1:
                                          controller.editVisit();
                                        case 2:
                                          controller.clone();
                                      }
                                    },
                                    rightButtonText: 'no'.tr,
                                    leftButtonText: 'yes'.tr,
                                  ));
                        }
                      },
                    ));
              })),
        ),
        body: Obx(() => ConditionalBuilder(
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
                                const SizedBox(
                                  height: 10,
                                ),
                                if (controller.currentScreen.value == 0)
                                  CustomDropDownList(
                                    onChangeValue: (String? value) {
                                      controller.userType.value = value!;
                                    },
                                    label: 'user'.tr,
                                    items: controller.userNames,
                                    currentValue: controller.userType.value,
                                  ),
                                if (controller.currentScreen.value == 0)
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          'E1C1F',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        CustomSmallTextField(
                                          textController:
                                              controller.patientFamIDController,
                                          label: 'XXXX',
                                        ),
                                        const Text(
                                          'NR',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        CustomSmallTextField(
                                          label: 'X',
                                          textController: controller
                                              .patientIDNumberController,
                                        ),
                                      ],
                                    ),
                                  ),
                                CustomTextFormField(
                                  textController:
                                      controller.assistantNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'assistantNameValidate'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  label: 'assistantName'.tr,
                                ),
                                CustomTextFormField(
                                  textController:
                                      controller.numberOfPeopleController,
                                  validator: (value) {
                                    return null;
                                  },
                                  label: 'noOfPeople'.tr,
                                ),
                                CustomTextFormField(
                                  label: 'assistantPhoneNumber'.tr,
                                  textController:
                                      controller.assistantPhoneController,
                                  validator: (assistantPhone) {
                                    // Allow the field to be empty
                                    if (assistantPhone == null ||
                                        assistantPhone.isEmpty) {
                                      return 'assistantPhoneNumberValidate1'.tr;
                                    }
                                    if (assistantPhone.length != 11) {
                                      return 'assistantPhoneNumberValidate2'.tr;
                                    }
                                    return null;
                                  },
                                ),
                                CustomDropDownList(
                                  onChangeValue: (String? value) {
                                    controller.addressType.value = value!;
                                  },
                                  label: 'addressType'.tr,
                                  items: controller.addressTypeList,
                                  currentValue: controller.addressType.value,
                                ),
                                CustomTextFormField(
                                  label: 'address'.tr,
                                  textController:
                                      controller.patientAddressController,
                                  validator: (address) {
                                    if (address == null || address.isEmpty) {
                                      return 'addressValidate'.tr;
                                    }
                                    return null;
                                  },
                                ),
                                CustomDropDownList(
                                  onChangeValue: (String? value) {
                                    controller.areaName.value = value!;
                                  },
                                  label: 'zone'.tr,
                                  items: controller.areaNames,
                                  currentValue: controller.visit.value.area?.name,
                                ),
                                CustomTextFormField(
                                  textController:
                                      controller.googleLinkController,
                                  label: 'googleMapsLink'.tr,
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  label: 'date'.tr,
                                  textController: controller.dateController,
                                  validator: (date) {
                                    if (date == null || date.isEmpty) {
                                      return 'dateValidate'.tr;
                                    }
                                    try {
                                      DateTime datePicked =
                                          DateFormat("dd-MM-yyyy")
                                              .parseStrict(date);
                                      if (datePicked.isBefore(DateTime.now())) {
                                        return 'dateValidate2'.tr;
                                      }
                                    } catch (e) {
                                      return 'Invalid date format';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    controller.selectDate(context);
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'from'.tr,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      CustomSmallTextField(
                                        label: 'start'.tr,
                                        validator: (start) {
                                          if (start == null || start.isEmpty) {
                                            return 'fromValidate'.tr;
                                          }
                                          return null;
                                        },
                                        textController:
                                            controller.fromTimeController,
                                        function: () {
                                          controller.selectedFromTime(context);
                                        },
                                      ),
                                      Text(
                                        'to'.tr,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      CustomSmallTextField(
                                        function: () {
                                          controller.selectedToTime();
                                        },
                                        textController:
                                            controller.toTimeController,
                                        validator: (end) {
                                          if (end == null || end.isEmpty) {
                                            return 'toValidate'.tr;
                                          }
                                          return null;
                                        },
                                        label: 'end'.tr,
                                      ),
                                    ],
                                  ),
                                ),
                                CustomBigTextField(
                                    label: 'notes'.tr,
                                    controller: controller.noteController),
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
                ))));
  }
}
