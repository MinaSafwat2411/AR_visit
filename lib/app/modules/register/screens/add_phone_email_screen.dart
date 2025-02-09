import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/widgets/custom_small_textField.dart';
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
            },),
            CustomTextFormField(textController: controller.phoneController, label: 'phone'.tr, validator: (value) {
              if(value.length != 11){
                return 'phoneValidate'.tr;
              }
            },),
          ],
        )
    );;
  }
}
