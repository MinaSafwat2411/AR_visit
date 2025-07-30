import 'package:ar_visiting_app/app/appcontroller/app_controller.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_small_textField.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class AddNameAridScreen extends GetView<RegisterController> {
  AddNameAridScreen({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.key1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(
              textController: controller.nameController,
              label: 'name'.tr,
              validator: (value) {
                if (value.isEmpty) {
                  return 'nameValidate'.tr;
                }
                return null;
              },
            ),
            CustomTextFormField(
              textController: controller.nameArController,
              label: 'nameAr'.tr,
              validator: (value) {
                if (value.isEmpty) {
                  return 'nameValidate'.tr;
                }
                return null;
              },
            ),
            Row(
              children: [
                const Text("E1C1F"),
                const Spacer(),
                CustomSmallTextField(
                  textController: controller.familyIdController,
                  label: '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'userValidate'.tr;
                    }
                    return null;
                  },
                  isDark: appController.isDark.value,
                ),
                const Spacer(),
                const Text("NR"),
                const Spacer(),
                CustomSmallTextField(
                  textController: controller.familyNumberController,
                  label: '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'userValidate'.tr;
                    }
                    return null;
                  },
                  isDark: appController.isDark.value,
                ),
              ],
            ),
          ],
        ));
  }
}
