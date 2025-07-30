import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/register_controller.dart';
import '../screens/add_name_arid_screen.dart';
import '../screens/add_phone_email_screen.dart';
import '../screens/create_password_screen.dart';

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
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Obx(
                          () => Container(
                            height: 2,
                            color: controller.currentScreen.value == 0
                                ? AppColors.trinidadColor
                                : AppColors.white,
                          ),
                        ))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Obx(
                          () => Container(
                            height: 2,
                            color: controller.currentScreen.value == 1
                                ? AppColors.trinidadColor
                                : AppColors.white,
                          ),
                        ))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Obx(
                          () => Container(
                            height: 2,
                            color: controller.currentScreen.value == 2
                                ? AppColors.trinidadColor
                                : AppColors.white,
                          ),
                        ))),
              ],
            ),
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
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children:  [
                  AddNameAridScreen(),
                  const AddPhoneEmailScreen(),
                  const CreatePasswordScreen(),
                ],
              ),
            ),
            Obx(() => ConditionalBuilder(
                  condition: !controller.isLoading.value,
                  builder: (context) => RegisterButton(
                    onPressed: () {
                      switch (controller.pageController.page?.toInt()) {
                        case 0:
                          if (controller.key1.currentState!.validate()) {
                            controller.currentScreen.value = 1;
                            controller.pageController.jumpToPage(1);
                          }
                          break;
                        case 1:
                          if (controller.key2.currentState!.validate()) {
                            controller.currentScreen.value = 2;
                            controller.pageController.jumpToPage(2);
                          }
                          break;
                        case 2:
                          if (controller.key3.currentState!.validate()) {
                            controller.registerAccount();
                          }
                      }
                      controller.getBtnText();
                    },
                    btnColor: AppColors.trinidadColor,
                    height: 50,
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.trinidadColor,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
