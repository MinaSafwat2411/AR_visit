
import 'package:ar_visiting_app/app/core/sharedchache/cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/app_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool observeBool = true.obs;
  TextEditingController aridTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  var isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String lang=CacheHelper.getData(key: 'lang')??'en';

  String getLoginTitle(){
    return lang == 'en' ? AppStringsEn.loginTitle:AppStringsAr.loginTitle;
  }
  String getPasswordTitle(){
    return  lang == 'en' ? AppStringsEn.passwordTitle:AppStringsAr.passwordTitle;
  }
  String getUserTitle(){
    return  lang == 'en' ? AppStringsEn.userTitle:AppStringsAr.userTitle;
  }
  String getUserValidate(){
    return  lang == 'en' ? AppStringsEn.userValidate:AppStringsAr.userValidate;
  }
  String getPasswordValidate1(){
    return  lang == 'en' ? AppStringsEn.passwordValidate1:AppStringsAr.passwordValidate1;
  }
  String getPasswordValidate2(){
    return  lang == 'en' ? AppStringsEn.passwordValidate2:AppStringsAr.passwordValidate2;
  }
  String getButtonTitle(){
    return  lang == 'en' ? AppStringsEn.login:AppStringsAr.login;
  }
  String getButtonTitleLoading(){
    return  lang == 'en' ? AppStringsEn.loginLoading:AppStringsAr.loginLoading;
  }
  void login() async {
    isLoading(true);
    try {
      String? email = await getEmailFromUsername(aridTextController.text);

      if (email != null) {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: passwordTextController.text,
        );
        Get.snackbar("Login", "Logged in successfully!");
        CacheHelper.saveData(key: 'loginDone', value: true);
        CacheHelper.saveData(key: 'user', value: aridTextController.text);
        Get.offNamed(Routes.VISITS);
      } else {
        Get.snackbar("Error", "Username not found");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
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
