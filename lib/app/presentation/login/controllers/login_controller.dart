import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/login/loginmodel.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  LoginController(this.useCase);

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool observeBool = true.obs;
  TextEditingController familyIdTextController = TextEditingController();
  TextEditingController numberIdTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  var isLoading = false.obs;
  var login = LoginModel().obs;
  final BaseUseCaseInterface useCase;

  void loginAccount() async {
    isLoading(true);

    if (!validateForm()) {
      isLoading(false);
      return;
    }

    try {
      final value = await useCase.login(LoginModel(
        nR: int.parse(numberIdTextController.text),
        e1C1F: int.parse(familyIdTextController.text),
        password: passwordTextController.text,
      ));

      if (value?.token != null) {
        final enums = await useCase.getEnums();
        print(enums?.toJson());
        if (enums != null) {
          Get.offNamed(Routes.HOME);
        } else {
          Get.snackbar("Error", "Failed to load app data");
        }
      } else {
        Get.snackbar("Login Failed", "Invalid credentials. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }


  bool validateForm() {
    final isValid = loginFormKey.currentState?.validate() ?? false;
    if (!isValid) {
      Get.snackbar("Validation Error", "Please fill in all required fields.");
    }
    return isValid;
  }

  @override
  void onClose() {
    familyIdTextController.dispose();
    numberIdTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
