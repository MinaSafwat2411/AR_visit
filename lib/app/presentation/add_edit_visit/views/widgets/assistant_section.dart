import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_big_textfield.dart';
import '../../controllers/add_edit_visit_controller.dart';

class AssistantSection extends GetView<AddEditVisitController> {
  const AssistantSection({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBigTextField(
          border: 12,
          controller: controller.assistantNameController,
          label: 'assistantName'.tr,
          isDark: isDark,
          observe: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'assistantNameRequired'.tr;
            }
            return null;
          }
        ),
        const SizedBox(
          height: 8,
        ),
        CustomBigTextField(
          border: 12,
          label: 'assistantPhoneNumber'.tr,
          controller: controller.assistantPhoneController,
          isDark: isDark,
          observe: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'assistantPhoneNumberRequired'.tr;
            }
            return null;
          }
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
