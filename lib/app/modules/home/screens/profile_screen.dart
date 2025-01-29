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
                    alignment: Alignment.topLeft,
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
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'email',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.profile.value.email??'',
                                  style: TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Rank',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.profile.value.type?.name ?? '',
                                  style: TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'status',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.profile.value.status?.name?? '',
                                  style: TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Phone',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.profile.value.phone ?? '',
                                  style: TextStyle(color: AppColors.gray),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Container(
                          decoration: const BoxDecoration(color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'presonal information',
                              style: TextStyle(
                                  backgroundColor: AppColors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.topLeft,
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
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Language',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Padding(
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
                                      const Text(
                                        'Dark Mode',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Obx(() => Switch(
                                            value: controller.darkMode.value,
                                            onChanged: (value) {
                                              controller.darkMode.value = value;
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
                        child: Container(
                          decoration: const BoxDecoration(color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'App Setting',
                              style: TextStyle(
                                  backgroundColor: AppColors.white, fontSize: 15),
                            ),
                          ),
                        ),
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
                          child: const Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: AppColors.trinidadColor,
                                size: 32,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Log out',
                                style: TextStyle(
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
