import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.loginFormKey,
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
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' please enter your ARID!';
                  }
                  return null;
                },
                controller: controller.aridTextController,
                decoration: InputDecoration(
                    labelText: 'E1C1FXXXNRX',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TextFormField(
                  obscureText: controller.observebool(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' please enter your password';
                    }
                    return null;
                  },
                  controller: controller.passwordTextController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.observebool(!controller.observebool());
                        },
                        icon: controller.observebool()
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                  text: 'Login',
                  height: 50,
                  onPressed: () async {
                    // TODO: Implement login
                    // if (controller.loginFormKey.currentState!.validate()) {
                    //   if (await authentication.login(
                    //       controller.aridTextController.text,
                    //       controller.passwordTextController.text)) {
                    //     navigateandend(context, const ArVisitLayout());
                    //   }
                    // }

                    // Navigate to Visit TODO: to be removed
                    Get.offNamed(Routes.VISITS);
                    
                  },
                  btncolor: AppColors.trinidadColor),
            ],
          ),
        ),
      ),
    );
  }
}
