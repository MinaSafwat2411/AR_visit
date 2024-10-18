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
        autovalidateMode: AutovalidateMode.onUserInteraction, // Enable auto validation
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AVA REWASE VISIT',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.trinidadColor,
                ),
              ),
              const SizedBox(height: 60),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ARID!';
                  }
                  return null;
                },
                controller: controller.aridTextController,
                decoration: InputDecoration(
                  labelText: 'E1C1FXXXNRX',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                    () => TextFormField(
                  obscureText: controller.observeBool(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  controller: controller.passwordTextController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.observeBool(!controller.observeBool());
                      },
                      icon: controller.observeBool()
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                    () => CustomButton(
                  text: controller.isLoading.value ? 'Logging in...' : 'Login',
                  height: 50,
                  onPressed:controller.isLoading.value ? () async {} :() async {
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
