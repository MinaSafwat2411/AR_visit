import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_alert.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Obx(() => ConditionalBuilder(
              condition: controller.currentScreen.value==0,
              fallback: (context) => const SizedBox(),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: 
                    DragTarget(
                      builder: (context, candidateData, rejectedData) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.MY_ORDER)?.then((result) {
                                    controller.order.value=result;
                                });
                              },
                              icon: const Icon(Icons.shopping_bag_outlined,size: 28,),
                            ),
                            Obx(() => ConditionalBuilder(
                              condition: controller.order.isNotEmpty,
                              fallback: (context) => const SizedBox(),
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8,),
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(color: AppColors.trinidadColor,borderRadius: BorderRadius.circular(8)),
                                    child: Text('${controller.order.length}',style: const TextStyle(color: AppColors.white,fontSize: 12,fontWeight: FontWeight.bold),),),
                                );
                              }
                            )
                            )
                          ],
                        );
                      },
                    ),
                );
              }
            )
            )
          ],
          backgroundColor: AppColors.white,
          title:Obx(() => Text(controller.title[controller.currentScreen.value].toString())),
        ),
        backgroundColor: AppColors.white,
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
                    Get.toNamed(Routes.ADD_NEW_VISIT);
                  },
                  rightButtonText: 'no'.tr,
                  rightFunction: () {
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
                                              0.6),
                                  child: Form(
                                    child: Column(
                                      children: [
                                        CustomTextFormField(textController: controller.name, label: 'name'.tr, validator: (value) {},),
                                        CustomTextFormField(textController: controller.nameAr, label: 'nameAr'.tr, validator: (value) {},),
                                        CustomTextFormField(textController: controller.familyId, label: 'E1C1F'.tr, validator: (value) {},),
                                        CustomTextFormField(textController: controller.familyNumber, label: 'NR'.tr, validator: (value) {},),
                                        CustomTextFormField(textController: controller.email, label: 'email'.tr, validator: (value) {},),
                                        CustomTextFormField(textController: controller.phone, label: 'phone'.tr, validator: (value) {},)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            AppColors.trinidadColor)),
                                    onPressed: () {
                                      // controller.addPatient();
                                      Get.back(closeOverlays: true);
                                    },
                                    child: Text(
                                      'add'.tr,
                                      style:
                                          const TextStyle(color: AppColors.white),
                                    ))
                              ],
                            ));
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
        bottomNavigationBar: BottomAppBar(
          color: AppColors.white,
          elevation: 10,
          shadowColor: AppColors.gray,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  MaterialButton(
                    height: 60,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      controller.onBottomNavItemClicked(0);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Obx(() => Container(
                                  decoration: BoxDecoration(
                                      color: controller.currentScreen.value == 0
                                          ? AppColors.trinidadColor
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 30,
                                  width: 55,
                                )),
                            Obx(() => Icon(
                                  Icons.people_outline,
                                  color: controller.currentScreen.value == 0
                                      ? AppColors.white
                                      : AppColors.black,
                                )),
                          ],
                        ),
                        Obx(() => Text(
                              'Visits',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: controller.currentScreen.value == 0
                                      ? AppColors.trinidadColor
                                      : AppColors.black),
                            )),
                      ],
                    ),
                  ),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    height: 60,
                    onPressed: () {
                      controller.onBottomNavItemClicked(1);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Obx(() => Container(
                                  decoration: BoxDecoration(
                                      color: controller.currentScreen.value == 1
                                          ? AppColors.trinidadColor
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 30,
                                  width: 55,
                                )),
                            Obx(() => Icon(
                              Icons.archive_outlined,
                              color: controller.currentScreen.value == 1
                                  ? AppColors.white
                                  : AppColors.black,
                            )),
                          ],
                        ),
                        Obx(() => Text(
                              'Archive',
                              style: TextStyle(
                                fontSize: 12,
                                  color: controller.currentScreen.value == 1
                                      ? AppColors.trinidadColor
                                      : AppColors.black),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    splashColor: Colors.transparent,
                    height: 60,
                    onPressed: () {
                      controller.onBottomNavItemClicked(2);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Obx(() => Container(
                                  decoration: BoxDecoration(
                                      color: controller.currentScreen.value == 2
                                          ? AppColors.trinidadColor
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 30,
                                  width: 55,
                                )),
                            Obx(() => Icon(
                              Icons.analytics_outlined,
                              color: controller.currentScreen.value == 2
                                  ? AppColors.white
                                  : AppColors.black,
                            )),
                          ],
                        ),
                        Obx(() => Text(
                              'Reports',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: controller.currentScreen.value == 2
                                      ? AppColors.trinidadColor
                                      : AppColors.black),
                            )),
                      ],
                    ),
                  ),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    height: 60,
                    onPressed: () {
                      controller.onBottomNavItemClicked(3);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Obx(() => Container(
                                  decoration: BoxDecoration(
                                      color: controller.currentScreen.value == 3
                                          ? AppColors.trinidadColor
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 30,
                                  width: 55,
                                )),
                            Obx(() => Icon(
                              Icons.person_outlined,
                              color: controller.currentScreen.value == 3
                                  ? AppColors.white
                                  : AppColors.black,
                            )),
                          ],
                        ),
                        Obx(() => Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: controller.currentScreen.value == 3
                                      ? AppColors.trinidadColor
                                      : AppColors.black),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                controller.currentScreen.value=value;
              },
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
