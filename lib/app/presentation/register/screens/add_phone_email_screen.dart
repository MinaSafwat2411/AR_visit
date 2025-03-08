import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_textformfield.dart';
import '../controllers/register_controller.dart';

class AddPhoneEmailScreen extends GetView<RegisterController> {
  const AddPhoneEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Form(
        key: controller.key2,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(textController: controller.emailController, label: 'email'.tr, validator: (value) {
              final RegExp emailRegex = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
              );
              if(!emailRegex.hasMatch(value)){
                return 'emailValidate'.tr;
              }
              return null;
            },),
            CustomTextFormField(textController: controller.phoneController, label: 'phone'.tr, validator: (value) {
              if(value.length != 11){
                return 'phoneValidate'.tr;
              }
              return null;
            },),
          ],
        )
    );
  }
}
