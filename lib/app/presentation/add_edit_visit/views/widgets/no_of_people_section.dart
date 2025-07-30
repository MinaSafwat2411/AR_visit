import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/custom_big_textfield.dart';
import '../../controllers/add_edit_visit_controller.dart';

class NoOfPeopleSection extends GetView<AddEditVisitController> {
  const NoOfPeopleSection({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBigTextField(
          border: 12,
          controller: controller.numberOfPeopleController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'noOfPeopleRequired'.tr;
            }
            return null;
          },
          label: 'noOfPeople'.tr,
          isDark: isDark,
          observe: false,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
