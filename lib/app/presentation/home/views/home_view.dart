
import 'package:ar_visiting_app/app/core/widgets/custom_textformfield.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_alert.dart';
import '../../../core/widgets/custom_bottom_nav_item.dart';
import '../../../routes/app_pages.dart';
import '../../visit_details/di/operation_type.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title:Obx(() => Text(controller.title[controller.currentScreen.value].value.toString())),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
            elevation: 5,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomDoubleAlert(
                  title: 'patientCreated'.tr,
                  leftButtonText: 'yes'.tr,
                  leftFunction: () {
                    Get.back(closeOverlays: true);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('addPatient'.tr),
                              content: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.42),
                                  child: Form(
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          textController: controller.name,
                                          label: 'patientName'.tr,
                                          validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter patient name';
                                          }
                                          return null;
                                          },
                                        ),
                                        CustomTextFormField(
                                          textController: controller.nameAr,
                                          label: 'patientNameAr'.tr,
                                          validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter patient name in Arabic';
                                          }
                                          return null;
                                          },
                                        ),
                                        CustomTextFormField(
                                          textController: controller.familyId,
                                          label: 'E1C1F'.tr,
                                          validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter family ID';
                                          }
                                          return null;
                                          },
                                        ),
                                        CustomTextFormField(
                                          textController: controller.familyNumber,
                                          label: 'NR'.tr,
                                          validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter family number';
                                          }
                                          return null;
                                          },
                                        ),
                                        CustomTextFormField(
                                          textController: controller.email,
                                          label: 'email'.tr,
                                          validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter email';
                                          }
                                          if (!GetUtils.isEmail(value)) {
                                            return 'Please enter a valid email';
                                          }
                                          return null;
                                          },
                                        ),
                                        CustomTextFormField(
                                          textController: controller.phone,
                                          label: 'phone'.tr,
                                          validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter phone number';
                                          }
                                          if (!GetUtils.isPhoneNumber(value)) {
                                            return 'Please enter a valid phone number';
                                          }
                                          return null;
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                ConditionalBuilder(
                                  condition: !controller.isSubmitted.value,
                                  fallback: (context) => const CircularProgressIndicator(color: AppColors.trinidadColor,),
                                  builder: (context) {
                                    return TextButton(
                                        style: const ButtonStyle(
                                            backgroundColor: WidgetStatePropertyAll(
                                                AppColors.trinidadColor)),
                                        onPressed: () {
                                          controller.addPatient();
                                        },
                                        child: Text(
                                          'add'.tr,
                                          style:
                                              const TextStyle(color: AppColors.white),
                                        ));
                                  }
                                )
                              ],
                            ));
                  },
                  rightButtonText: 'no'.tr,
                  rightFunction: () {
                    Get.back(closeOverlays: true);
                    Get.toNamed(Routes.ADD_EDIT_VISIT,arguments: [controller.lang.value,controller.isDark.value,controller.token.value,OperationType.ADD]);
                  },
                ),
              );
            },
            backgroundColor: AppColors.trinidadColor, // Trinidad color
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: controller.currentScreen.value,
          onTap: (value) {
            controller.onBottomNavItemClicked(value);
          },
          items: [
            CustomBottomNavigationBarItem.create(icon: Icons.people_outline, label: 'visits'.tr),
            CustomBottomNavigationBarItem.create(icon: Icons.archive_outlined, label: 'archive'.tr),
            CustomBottomNavigationBarItem.create(icon: Icons.analytics_outlined, label: 'reports'.tr),
            CustomBottomNavigationBarItem.create(icon: Icons.person_outlined, label: 'profile'.tr),
          ],
        )
        ),
        body: Obx(() => ConditionalBuilder(
          fallback: (context) => const Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(color: AppColors.trinidadColor,),
              ),
            ],
          ),
          condition: !controller.isLoading.value,
          builder: (context) {
            return PageView(
              onPageChanged: (value) {
                controller.me(true);
                controller.currentScreen.value=value;
              },
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: [
                controller.screens[0],
                controller.screens[1],
                controller.screens[2],
                controller.screens[3],
              ],
            );
          }
        )
        )
      ),
    );
  }
}
