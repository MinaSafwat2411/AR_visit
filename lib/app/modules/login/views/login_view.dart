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
                'loginTitle'.tr,
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
                    return 'userValidate'.tr;
                  }
                  return null;
                },
                cursorColor: AppColors.trinidadColor,
                controller: controller.aridTextController,
                decoration: InputDecoration(
                  labelText: 'userTitle'.tr,
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
                      return 'passwordValidate1'.tr;
                    }
                    if (value.length < 6) {
                      return 'passwordValidate2'.tr;
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
                    labelText: 'passwordTitle'.tr,
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
                   const Text('If you don\'t have aacount',style: TextStyle(
                    fontSize: 16,
                   ), ),
                   const SizedBox(width: 10,),
                   GestureDetector(
                    onTap: () {
                      
                    },
                     child: const Text('Register',style: TextStyle(
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
