import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_alert.dart';
import 'package:ar_visiting_app/app/modules/home/controllers/home_controller.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<HomeController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ConditionalBuilder(
      condition: !controller.isLoadingInternal.value,
      fallback: (context) => const Center(child: CircularProgressIndicator(color: AppColors.trinidadColor,),),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('avaRewaseIcon'.tr),
                      width: 100,
                      height: 100,
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
                          style:
                              const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'E1C1F${controller.profile.value.e1C1F}NR${controller.profile.value.nR}',
                          style: const TextStyle(color: AppColors.gray),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.trinidadColor, width: 2)),
                          child:  Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'email'.tr,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.profile.value.email??'',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                Text(
                                  'rank'.tr,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.profile.value.type?.name ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                Text(
                                  'status'.tr,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.profile.value.status?.name?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                Text(
                                  'phone'.tr,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.profile.value.phone ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Obx(() =>Container(
                          decoration:  BoxDecoration(color: controller.isDark.value? AppColors.codGray2: AppColors.white),
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Obx(() => Text(
                              'presonalInformation'.tr,
                              style:  TextStyle(
                                  backgroundColor: controller.isDark.value? AppColors.codGray2: AppColors.white, fontSize: 15),
                            )),
                          ),
                        ))
                        ,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.trinidadColor, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => CustomDoubleAlert(
                                              title: 'languageComfim'.tr,
                                              leftButtonText: 'english'.tr,
                                              rightButtonText: 'arabic'.tr,
                                              leftFunction: () {
                                                controller.changeLanguage('en');
                                              },
                                              rightFunction: () {
                                                controller.changeLanguage('ar');
                                              },
                                            ));
                                  },
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'language'.tr,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.translate,
                                                color: AppColors.trinidadColor,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_outlined,
                                                color: AppColors.trinidadColor,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                       Text(
                                        'darkMode'.tr,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Obx(() => Switch(
                                            value: controller.isDark.value,
                                            onChanged: (value) {
                                              controller.isDark.value = value;
                                              controller.changeTheme();
                                            },
                                            activeColor: AppColors.trinidadColor,
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
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Obx(() =>Container(
                          decoration: BoxDecoration( color: controller.isDark.value? AppColors.codGray2: AppColors.white),
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Obx(() =>Text(
                              'appSetting'.tr,
                              style:  TextStyle(
                                  backgroundColor: controller.isDark.value? AppColors.codGray2: AppColors.white, fontSize: 15),
                            )
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border:
                              Border.all(color: AppColors.trinidadColor, width: 2)),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            controller.logout();
                          },
                          child:  Row(
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
        );
      }
    )
    );
  }
}
