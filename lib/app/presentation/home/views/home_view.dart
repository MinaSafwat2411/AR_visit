import 'package:ar_visiting_app/app/core/widgets/custom_loading.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_textformfield.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../appcontroller/app_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_alert.dart';
import '../../../routes/app_pages.dart';
import '../../visit_details/di/operation_type.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Form(
      child: Scaffold(
          appBar: AppBar(
            title: Obx(() => Text(controller
                .title[controller.currentScreen.value].value
                .toString())),
            leading: IconButton(
              icon: Image.asset('imageLogo'.tr, width: 40, height: 40),
              onPressed: () async{
                Get.toNamed(
                Routes.PROFILE,
              );
                controller.getData();
              },
            ),
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: SizedBox(
            height: 65,
            width: 65,
            child: FloatingActionButton(
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
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter patient name';
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomTextFormField(
                                            textController: controller.nameAr,
                                            label: 'patientNameAr'.tr,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter patient name in Arabic';
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomTextFormField(
                                            textController: controller.familyId,
                                            label: 'E1C1F'.tr,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter family ID';
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomTextFormField(
                                            textController:
                                                controller.familyNumber,
                                            label: 'NR'.tr,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter family number';
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomTextFormField(
                                            textController: controller.email,
                                            label: 'email'.tr,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter phone number';
                                              }
                                              if (!GetUtils.isPhoneNumber(
                                                  value)) {
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
                                      fallback: (context) =>
                                          const CustomLoading(),
                                      builder: (context) {
                                        return TextButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        AppColors
                                                            .trinidadColor)),
                                            onPressed: () {
                                              controller.addPatient();
                                            },
                                            child: Text(
                                              'add'.tr,
                                              style: const TextStyle(
                                                  color: AppColors.white),
                                            ));
                                      })
                                ],
                              ));
                    },
                    rightButtonText: 'no'.tr,
                    rightFunction: () {
                      Get.back(closeOverlays: true);
                      Get.toNamed(Routes.ADD_EDIT_VISIT, arguments: [OperationType.ADD]);
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              child: Container(
                color: appController.isDark.value
                    ? AppColors.white
                    : AppColors.trinidadColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => GNav(
                          onTabChange: (value) {
                            controller.onBottomNavItemClicked(value);
                          },
                          selectedIndex: controller.currentScreen.value,
                          backgroundColor: appController.isDark.value
                              ? AppColors.white
                              : AppColors.trinidadColor,
                          color: appController.isDark.value
                              ? AppColors.trinidadColor
                              : AppColors.white,
                          activeColor: appController.isDark.value
                              ? AppColors.white
                              : AppColors.trinidadColor,
                          textStyle: textTheme.bodyMedium?.copyWith(
                              color: appController.isDark.value
                                  ? AppColors.white
                                  : AppColors.trinidadColor),
                          tabBackgroundColor: appController.isDark.value
                              ? AppColors.trinidadColor
                              : AppColors.white,
                          style: GnavStyle.google,
                          iconSize: 24,
                          padding: const EdgeInsets.all(12),
                          tabs: [
                            GButton(icon: Icons.person_outline, text: 'me'.tr),
                            GButton(
                                icon: Icons.people_alt_outlined,
                                text: 'visits'.tr),
                            GButton(
                                icon: Icons.analytics_outlined,
                                text: 'reports'.tr),
                            GButton(
                                icon: Icons.archive_outlined,
                                text: 'archives'.tr)
                          ])),
                ),
              ),
            ),
          ),
          body: Obx(() => ConditionalBuilder(
              fallback: (context) => const CustomLoading(),
              condition: !controller.isLoading.value,
              builder: (context) {
                return PageView(
                  onPageChanged: (value) {
                    controller.onPageChange(value);
                    controller.searchController.text = '';
                  },
                  controller: controller.pageController,
                  children: controller.screens,
                );
              }))),
    );
  }
}
