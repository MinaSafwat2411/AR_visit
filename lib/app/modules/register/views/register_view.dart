import 'package:ar_visiting_app/app/modules/register/controllers/register_controller.dart';
import 'package:ar_visiting_app/app/modules/register/screens/add_name_arid_screen.dart';
import 'package:ar_visiting_app/app/modules/register/screens/add_phone_email_screen.dart';
import 'package:ar_visiting_app/app/modules/register/screens/create_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Obx(() => Container(height: 2,color:controller.currentScreen.value == 0 ?  AppColors.trinidadColor:AppColors.white,),
                ))),
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Obx(() => Container(height: 2,color: controller.currentScreen.value == 1 ? AppColors.trinidadColor:AppColors.white,),
                ))),
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Obx(() => Container(height: 2,color: controller.currentScreen.value == 2?AppColors.trinidadColor:AppColors.white,),
                ))),
              ],),
            const SizedBox(height: 200),
            Text(
              'loginTitle'.tr,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.trinidadColor,
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                children: const [
                  AddNameAridScreen(),
                  AddPhoneEmailScreen(),
                  CreatePasswordScreen(),
                ],
              ),
            ),
            RegisterButton(onPressed: () {
              switch(controller.pageController.page?.toInt()){
                case 0 :if(controller.key1.currentState!.validate()){
                  controller.currentScreen.value = 1;
                  controller.pageController.jumpToPage(1);
                }
                break;
                case 1 :if(controller.key2.currentState!.validate()){
                  controller.currentScreen.value = 2;
                  controller.pageController.jumpToPage(2);
                }
                break;
                case 2 :if(controller.key3.currentState!.validate()){
                  controller.registerAccount();
                  Get.back();
                }
              }
              controller.getBtnText();
            },btnColor: AppColors.trinidadColor,height: 50,)
          ],
        ),
      ),
    );
  }
}
