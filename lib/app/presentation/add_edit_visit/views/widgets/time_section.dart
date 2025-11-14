import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/custom_big_textfield.dart';
import '../../../../core/widgets/custom_small_textField.dart';
import '../../controllers/add_edit_visit_controller.dart';

class TimeSection extends GetView<AddEditVisitController> {
  const TimeSection({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        CustomBigTextField(
          border: 12,
          label: 'date'.tr,
          controller: controller.dateController,
          validator: (date) {
            if (date == null || date.isEmpty) {
              return 'dateValidate'.tr;
            }
            try {
              DateTime datePicked =
              DateFormat("dd-MM-yyyy").parseStrict(date);
              if (datePicked.isBefore(DateTime.now())) {
                return 'dateValidate2'.tr;
              }
            } catch (e) {
              return 'Invalid date format';
            }
            return null;
          },
          isDark: isDark,
          observe: false,
          function: () => controller.selectDate(context),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'from'.tr,
              style: textTheme.titleSmall,
            ),
            CustomSmallTextField(
              label: 'start'.tr,
              validator: (start) {
                if (start == null || start.isEmpty) {
                  return 'fromValidate'.tr;
                }
                return null;
              },
              textController: controller.fromTimeController,
              function: () {
                controller.selectedFromTime(context);
              },
              isDark: isDark,
              textKey: controller.formKey,
            ),
            Text(
              'to'.tr,
              style: textTheme.titleSmall,
            ),
            CustomSmallTextField(
              function: () {
                controller.selectedToTime();
              },
              textController: controller.toTimeController,
              validator: (end) {
                if (end == null || end.isEmpty) {
                  return 'toValidate'.tr;
                }
                return null;
              },
              label: 'end'.tr,
              isDark: isDark,
              textKey: controller.formKey,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
