
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

  void login() async {
    isLoading(true);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: aridTextController.text,
        password: passwordTextController.text,
      );
      Get.snackbar("Login", "Logged in successfully!");
      Get.offNamed(Routes.VISITS);
    }catch (e) {
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
