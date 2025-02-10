import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/controller/main_controller.dart';
import '../../../core/models/register/register_model.dart';

class RegisterController extends GetxController{
  var pageController =PageController();
  var nameController =TextEditingController();
  var nameArController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var familyIdController = TextEditingController();
  var familyNumberController = TextEditingController();
  var key1 = GlobalKey<FormState>();
  var key2 = GlobalKey<FormState>();
  var key3 = GlobalKey<FormState>();
  var isLoading = false.obs;
  var observeBool = true.obs;
  var validate = false.obs;
  var currentScreen= 0.obs;
  var btnText = 'next'.tr.obs;
  var lang = ''.obs;
  var isDark = RxBool(false);
  var mainController = MainController();
  var register =RegisterModel().obs;

  void getBtnText(){
    if(pageController.page==2){
      btnText.value = 'register'.tr;
    }else{
      btnText.value = 'next'.tr;
    }
  }

  void registerAccount()async{
    isLoading(true);
    register.value=RegisterModel(
      nameAr: nameArController.text,
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      nR: int.parse(familyNumberController.text),
      e1C1F: int.parse(familyIdController.text),
      password: passwordController.text
    );
    await mainController.register(lang.value, register.value);
    isLoading(false);
    Get.back();
  }

  @override
  void onInit() {
    lang.value = Get.arguments[0];
    isDark.value = Get.arguments[1];
    super.onInit();
  }
}