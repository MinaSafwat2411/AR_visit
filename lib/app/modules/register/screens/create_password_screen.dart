import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_textformfield.dart';
import '../controllers/register_controller.dart';

class CreatePasswordScreen extends GetView<RegisterController> {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.key3,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(textController: controller.passwordController, label: 'passwordTitle'.tr, validator: (value) {
              if(value!.isEmpty){
                return 'passwordValidate1'.tr;
              }else if(value.length<8){
                return 'passwordValidate2'.tr;
              }
              return null;
            },),
            CustomTextFormField(textController: controller.confirmPasswordController, label: 'confirmpassword'.tr, validator: (value) {
              if(value!=controller.passwordController.text){
                return 'passwordValidate3'.tr;
              }
              return null;
            },),
          ],
        )
    );
  }
}
