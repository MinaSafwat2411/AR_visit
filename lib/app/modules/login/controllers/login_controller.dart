
import 'package:ar_visiting_app/app/core/models/api_response/api_response.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/backend_endpoint.dart';
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

  var login= LoginModel().obs;

  @override
  void onInit() {
    lang.value=Get.arguments[0];
    isDark.value=Get.arguments[1];
    super.onInit();
  }

  void getArid(){
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
    try {
      login.value =LoginModel(
        nR: int.parse(nR.value),
        e1C1F: int.parse(id.value),
        password: passwordTextController.text
      );
      final  response = await DioHelper.postData(
        url: BackendEndpoint.login,
        data: login.toJson(),
      );
      var apiResponse = ApiResponse<UserModel>.fromJson(
        response.data,
            (json) => UserModel.fromJson(json as Map<String, dynamic>),
      );
      CacheHelper.saveData(key: 'token', value: apiResponse.data?.token);
      Get.snackbar("Login", apiResponse.message ?? "");
      Get.offNamed(Routes.HOME, arguments: [lang.value,isDark.value,apiResponse.data!.token]);
    } catch (e) {
      Get.snackbar("Error", e.toString());
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
    super.onClose();
    aridTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
