import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool observebool = true.obs;
  TextEditingController aridTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
