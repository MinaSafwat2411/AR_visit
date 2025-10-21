import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/login/loginmodel.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
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

    var login = await useCase.login(
        LoginModel(
            nR: int.parse(numberIdTextController.text),
            e1C1F: int.parse(familyIdTextController.text),
            password: passwordTextController.text));
    if (login != null) {
      Get.offNamed(Routes.HOME);
    }
    isLoading(false);
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
    super.onClose();
    familyIdTextController.dispose();
    numberIdTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
