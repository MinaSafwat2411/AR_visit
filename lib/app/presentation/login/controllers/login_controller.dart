import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/data/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/backend_endpoint.dart';
import '../../../data/models/login/loginmodel.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool observeBool = true.obs;
  TextEditingController aridTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  var isLoading = false.obs;
  var id = ''.obs;
  var nR = ''.obs;
  var lang = ''.obs;
  var isDark = RxBool(false);
  var token = ''.obs;
  var login = LoginModel().obs;
  final useCase = BaseUseCase(repository: DioHelperRepository.repository);

  @override
  void onInit() {
    lang.value = Get.arguments[0];
    isDark.value = Get.arguments[1];
    super.onInit();
  }

  void getArid() {
    RegExp regExp = RegExp(r'E1C1F(\d+)NR(\d+)');
    Match? match = regExp.firstMatch(aridTextController.text);
    if (match != null) {
      id.value = match.group(1) ?? '';
      nR.value = match.group(2) ?? '';
    }
  }

  void loginAccount() async {
    getArid();
    isLoading(true);

    var login = await useCase.login(lang.value, LoginModel(
        nR: int.parse(nR.value),
        e1C1F: int.parse(id.value),
        password: passwordTextController.text));
    if (login != null) {
      Get.offNamed(Routes.HOME,
          arguments: [lang.value, isDark.value, login.token]);
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
    aridTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
