import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/login/loginmodel.dart';
import '../../presentation/home/controllers/home_controller.dart';
import '../utils/app_colors.dart';

class CustomDropDownList extends GetView<HomeController> {
  const CustomDropDownList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: DropdownMenu(
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.boulder)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.boulder)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.boulder))),
        dropdownMenuEntries: (controller.users)
            .map((e) => DropdownMenuEntry<DropDown>(
                  value: e,
                  label: e.name?.nameAr ?? "",
                ))
            .toList(),
        requestFocusOnTap: true,
        onSelected: (value) {
          controller.onUserSelected(value ?? DropDown());
        },
        width: double.infinity,
        hintText: 'patientName'.tr,
        menuHeight: 300,
        enableSearch: true,
        controller: controller.reportController,
        enableFilter: true,
        menuStyle: MenuStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
