import 'package:ar_visiting_app/app/modules/profile/controllers/profile_controllers.dart';
import 'package:ar_visiting_app/app/modules/profile/views/widgets/custom_profile_card.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../routes/app_pages.dart';

class ProfileViews extends GetView<ProfileControllers> {
  const ProfileViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title:  Text(
          controller.getProfile(),
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
      body:  ConditionalBuilder(
        condition:  !controller.isLoading.value,
        fallback: (context) => const Center(child: CircularProgressIndicator(color: AppColors.trinidadColor,),),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                        image: AssetImage(AppStrings.avaRewase),
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(width: 24,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.name.value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color:AppColors.mirage
                            )
                        ),
                        Text(
                            controller.user.value.id!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color:AppColors.doveGray
                            )
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 50,),
                CustomProfileCard(title: controller.getAccount(),image: AppStrings.account,),
                const SizedBox(height: 25,),
                CustomProfileCard(title: controller.getLanguage(),image: AppStrings.translate,),
                const SizedBox(height: 25,),
                CustomProfileCard(title: controller.getSettings(),image: AppStrings.settings,),
                const SizedBox(height: 25,),
                CustomProfileCard(title: controller.getFQA(),image: AppStrings.faq,),
                const SizedBox(height: 25,),
                Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: (){
                    controller.logout();
                  }, child:  Text(controller.getLogout(),style: const TextStyle(
                      color: AppColors.trinidadColor
                  ),),),
                )

              ],
            ),
          );
        }
      ),
    )
    );
  }
}
