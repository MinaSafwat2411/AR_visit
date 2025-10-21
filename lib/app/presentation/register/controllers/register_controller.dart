import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/register/register_model.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../domain/usecase/base_use_case_interface.dart';

class RegisterController extends GetxController{
  RegisterController(this.useCase);
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
  final BaseUseCaseInterface useCase;


  void getBtnText(){
    if(pageController.page==2){
      btnText.value = 'register'.tr;
    }else{
      btnText.value = 'next'.tr;
    }
  }

  void registerAccount()async{
    try{
      isLoading(true);
      await useCase.register( RegisterModel(
          nameAr: nameArController.text,
          name: nameController.text,
          phone: phoneController.text,
          email: emailController.text,
          nR: int.parse(familyNumberController.text),
          e1C1F: int.parse(familyIdController.text),
          password: passwordController.text
      ));
    }catch(e){
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading(false);
    }
  }
}