import 'package:ar_visiting_app/app/core/widgets/custom_small_textField.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../appcontroller/app_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_big_textfield.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final AppController appController = Get.find();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Form(
        key: controller.loginFormKey,
        autovalidateMode:
            AutovalidateMode.onUserInteraction, // Enable auto validation
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'loginTitle'.tr,
                style: textTheme.headlineMedium?.copyWith(),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("E1C1F"),
                  CustomSmallTextField(
                    isDark: appController.isDark.value,
                    textController: controller.familyIdTextController,
                    validator: (value) =>  value == null || value.isEmpty ? 'familyIdValidate'.tr : null,
                  ),
                  const Text("NR"),
                  CustomSmallTextField(
                    isDark: appController.isDark.value,
                    textController: controller.numberIdTextController,
                    validator: (value) =>  value == null || value.isEmpty ? 'numberIdValidate'.tr : null,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => CustomBigTextField(
                  observe: controller.observeBool(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'passwordValidate1'.tr;
                    }
                    if (value.length < 6) {
                      return 'passwordValidate2'.tr;
                    }
                    return null;
                  },
                  controller: controller.passwordTextController,
                  isDark: appController.isDark.value,
                  label: 'passwordTitle'.tr,
                  icon: IconButton(
                    onPressed: () {
                      controller.observeBool.value =
                          !controller.observeBool.value;
                    },
                    icon: Icon(
                      controller.observeBool.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.trinidadColor,
                    )
                  ),
                  border: 12,
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                () => CustomButton(
                  text: controller.isLoading.value ? 'loginLoading'.tr : 'login'.tr,
                  height: 50,
                  onPressed: controller.isLoading.value
                      ? () async {}
                      : () async {
                          controller.loginAccount();
                        },
                  btnColor: AppColors.trinidadColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                 children: [
                    Text('registerInfo'.tr,style: const TextStyle(
                    fontSize: 16,
                   ), ),
                   const SizedBox(width: 10,),
                   GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                     child:  Text('register'.tr,style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                     ), ),
                   )
                 ],
               )
            ],
          ),
        ),
      ),
    );
  }
}
