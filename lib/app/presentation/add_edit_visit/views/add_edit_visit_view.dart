import 'package:ar_visiting_app/app/core/widgets/custom_loading.dart';
import 'package:ar_visiting_app/app/presentation/add_edit_visit/views/widgets/address_section.dart';
import 'package:ar_visiting_app/app/presentation/add_edit_visit/views/widgets/assistant_section.dart';
import 'package:ar_visiting_app/app/presentation/add_edit_visit/views/widgets/no_of_people_section.dart';
import 'package:ar_visiting_app/app/presentation/add_edit_visit/views/widgets/patient_section.dart';
import 'package:ar_visiting_app/app/presentation/add_edit_visit/views/widgets/time_section.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../appcontroller/app_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_big_textfield.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/add_edit_visit_controller.dart';

class AddEditVisitView extends GetView<AddEditVisitController> {
  AddEditVisitView({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isDark = appController.isDark.value;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
                controller.titles[controller.currentScreen.value],
                textAlign: TextAlign.center,
                style: textTheme.titleLarge,
              )),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => ConditionalBuilder(
              fallback: (context) => const CustomLoading(),
              condition: !controller.internalLoading.value,
              builder: (context) {
                return Obx(() => CustomButton(
                      height: 58,
                      text:
                          controller.buttonText[controller.currentScreen.value],
                      btnColor: AppColors.trinidadColor,
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          switch (controller.currentScreen.value) {
                            case 0:
                              controller.addVisit();
                            case 1:
                              controller.editVisit();
                            case 2:
                              controller.clone();
                          }
                        }
                      },
                    ));
              })),
        ),
        body: Obx(() => ConditionalBuilder(
            condition: !controller.isLoading.value,
            builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const PatientSection(),
                          AssistantSection(isDark: isDark),
                          NoOfPeopleSection(isDark: isDark),
                          AddressSection(isDark: isDark,lang: appController.lang.value,),
                          TimeSection(isDark: isDark),
                          CustomBigTextField(
                            label: 'notes'.tr,
                            controller: controller.noteController,
                            isDark: isDark,
                            observe: false,
                            border: 12,
                          ),
                          const SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            fallback: (context) => const CustomLoading())));
  }
}
