import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../appcontroller/app_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_alert.dart';
import '../../../core/widgets/custom_loading.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('profile'.tr),
            leading: IconButton(
              onPressed: () {
                Get.back(result: true);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Obx(
            () => ConditionalBuilder(
                condition: !controller.isLoading.value,
                builder: (context) => SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('imageLogo'.tr),
                                    width: 70,
                                    height: 70,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.profile.value.name ?? '',
                                        style: textTheme.headlineSmall,
                                      ),
                                      Text(
                                        'E1C1F${controller.profile.value.e1C1F}NR${controller.profile.value.nR}',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: AppColors.boulder,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColors.trinidadColor,
                                            width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'email'.tr,
                                            style: textTheme.titleMedium,
                                          ),
                                          Text(
                                            controller.profile.value.email ?? '',
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: AppColors.boulder,
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.trinidadColor,
                                          ),
                                          Text(
                                            'rank'.tr,
                                            style: textTheme.titleMedium,
                                          ),
                                          Text(
                                            controller.profile.value.type?.name ??
                                                '',
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: AppColors.boulder,
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.trinidadColor,
                                          ),
                                          Text(
                                            'status'.tr,
                                            style: textTheme.titleMedium,
                                          ),
                                          Text(
                                            controller
                                                    .profile.value.status?.name ??
                                                '',
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: controller.getStatuses(
                                                  controller.profile.value.status
                                                          ?.value ??
                                                      0),
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.trinidadColor,
                                          ),
                                          Text(
                                            'phone'.tr,
                                            style: textTheme.titleMedium,
                                          ),
                                          Text(
                                            controller.profile.value.phone ?? '',
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: AppColors.boulder,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Obx(() => Text(
                                        'presonalInformation'.tr,
                                        style: textTheme.titleSmall?.copyWith(
                                          backgroundColor:
                                              appController.isDark.value
                                                  ? AppColors.black
                                                  : AppColors.white,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColors.trinidadColor,
                                            width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomDoubleAlert(
                                                        title:
                                                            'languageComfim'.tr,
                                                        leftButtonText:
                                                            'english'.tr,
                                                        rightButtonText:
                                                            'arabic'.tr,
                                                        leftFunction: () {
                                                          appController
                                                              .changeLocale(
                                                                  const Locale(
                                                                      'en'));
                                                          appController
                                                              .changeLanguage(
                                                                  'en');
                                                          controller.getProfile();
                                                        },
                                                        rightFunction: () {
                                                          appController
                                                              .changeLocale(
                                                                  const Locale(
                                                                      'ar'));
                                                          appController
                                                              .changeLanguage(
                                                                  'ar');
                                                          controller.getProfile();
                                                        },
                                                      ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'language'.tr,
                                                    style: textTheme.titleMedium,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 4.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.translate,
                                                          color: AppColors
                                                              .trinidadColor,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          color: AppColors
                                                              .trinidadColor,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.trinidadColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'darkMode'.tr,
                                                  style: textTheme.titleMedium,
                                                ),
                                                Obx(() => Switch(
                                                      value:
                                                          appController.isDark.value,
                                                      onChanged: (value) {
                                                        appController
                                                            .toggleTheme();
                                                      },
                                                      activeColor:
                                                          AppColors.trinidadColor,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Obx(() => Text(
                                        'appSetting'.tr,
                                        style: textTheme.titleSmall?.copyWith(
                                          backgroundColor:
                                              appController.isDark.value
                                                  ? AppColors.black
                                                  : AppColors.white,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                          color: AppColors.trinidadColor,
                                          width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.onLogout();
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.logout,
                                            color: AppColors.trinidadColor,
                                            size: 32,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'logout'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: AppColors.trinidadColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                fallback: (context) => const CustomLoading()),
          )),
    );
  }
}
