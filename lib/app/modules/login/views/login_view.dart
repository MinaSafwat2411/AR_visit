import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
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
                controller.getLoginTitle(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.trinidadColor,
                ),
              ),
              const SizedBox(height: 60),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return controller.getUserValidate();
                  }
                  return null;
                },
                cursorColor: AppColors.trinidadColor,
                controller: controller.aridTextController,
                decoration: InputDecoration(
                  labelText: controller.getUserTitle(),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColors.trinidadColor)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: AppColors.trinidadColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => TextFormField(
                  obscureText: controller.observeBool(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return controller.getPasswordValidate1();
                    }
                    if (value.length < 6) {
                      return controller.getPasswordValidate2();
                    }
                    return null;
                  },
                  cursorColor: AppColors.trinidadColor,
                  controller: controller.passwordTextController,
                  decoration: InputDecoration(
                    suffixIconColor: AppColors.trinidadColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.observeBool(!controller.observeBool());
                      },
                      icon: controller.observeBool()
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    labelText: controller.getPasswordTitle(),
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.trinidadColor)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: AppColors.trinidadColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                () => CustomButton(
                  text: controller.isLoading.value ? controller.getButtonTitleLoading() : controller.getButtonTitle(),
                  height: 50,
                  onPressed: controller.isLoading.value
                      ? () async {}
                      : () async {
                          controller.login();
                        },
                  btnColor: AppColors.trinidadColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
