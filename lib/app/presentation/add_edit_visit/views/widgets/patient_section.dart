import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../data/models/patient/patient_model.dart';
import '../../controllers/add_edit_visit_controller.dart';

class PatientSection extends GetView<AddEditVisitController> {
  const PatientSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (controller.currentScreen.value == 0)
          DropdownMenu(
            initialSelection: controller.selectedPatient.value,
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: AppColors.boulder)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: AppColors.boulder)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: AppColors.boulder))),
            dropdownMenuEntries: (controller.patientAr)
                .map((e) => DropdownMenuEntry<PatientModel>(
              value: e,
              label: e.name ?? "",
            ))
                .toList(),
            requestFocusOnTap: true,
            onSelected: (value) {
              controller
                  .onSelectPatient(value ?? PatientModel());
            },
            width: double.infinity,
            hintText: 'patientName'.tr,
            menuHeight: 300,
            enableSearch: true,
            controller: controller.patientNameController,
            enableFilter: true,
            menuStyle: MenuStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

          ),
        if (controller.currentScreen.value == 0)
          const SizedBox(
            height: 8,
          ),
      ],
    );
  }
}
