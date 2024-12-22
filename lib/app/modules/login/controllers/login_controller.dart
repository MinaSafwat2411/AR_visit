
import 'package:ar_visiting_app/app/core/models/api_response/api_response.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/secure_cache_helper.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginModel login= LoginModel();


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
      login =LoginModel(
        nR: int.parse(nR.value),
        e1C1F: int.parse(id.value),
        password: passwordTextController.text
      );
      final  response = await DioHelper.postData(
        url: BackendEndpoint.login,
        data: login.toJson(),
      );

      final apiResponse = ApiResponse<LoginModel>.fromJson(
        response.data,
            (data) => LoginModel.fromJson(data),
      );
      SecureCacheHelper.saveData(key: 'token', value: apiResponse.data!.token);
      Get.snackbar("Login", apiResponse.message);
      Get.offNamed(Routes.VISITS);
    } catch (e) {
      Get.snackbar("Error", 'Invalid Credentials');
    } finally {
      isLoading(false);
    }
  }

  Future<String?> getEmailFromUsername(String username) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data()['email'] as String;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  bool validateForm() {
    final isValid = loginFormKey.currentState?.validate() ?? false;
    if (!isValid) {
      Get.snackbar("Validation Error", "Please fill in all required fields.");
    }
    return isValid;
  }

  void handleFirebaseError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = "Invalid email format.";
        break;
      case 'user-not-found':
        errorMessage = "No user found with this email.";
        break;
      case 'wrong-password':
        errorMessage = "Incorrect password.";
        break;
      default:
        errorMessage = "Login failed. Please try again.";
    }
    Get.snackbar("Login Error", errorMessage);
  }


  @override
  void onClose() {
    super.onClose();
    aridTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
