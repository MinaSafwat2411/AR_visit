
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

  void login() async {
    isLoading(true);
    try {
      // Step 1: Retrieve email associated with the username
      String? email = await getEmailFromUsername(aridTextController.text);

      if (email != null) {
        // Step 2: Use the retrieved email to sign in
        await auth.signInWithEmailAndPassword(
          email: email,
          password: passwordTextController.text,
        );

        Get.snackbar("Login", "Logged in successfully!");
        Get.offNamed(Routes.VISITS);
      } else {
        // If username not found, show error message
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
      // Query Firestore for the document with the username
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      // Check if a document was found
      if (querySnapshot.docs.isNotEmpty) {
        // Get the email field from the document
        return querySnapshot.docs.first.data()['email'] as String;
      } else {
        // No user found with that username
        print("No user found with that username");
        return null;
      }
    } catch (e) {
      print('Error fetching email: $e');
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
