import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/data/models/patient/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/add_edit_visit/controllers/add_edit_visit_controller.dart';

class PatientBottomSheet extends GetView<AddEditVisitController> {
  PatientBottomSheet({
    super.key,
    required this.title,
    required this.isDark,
    required this.patients,
  });

  final String title;
  List<PatientModel> patients;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: isDark ? AppColors.black : AppColors.lightGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.gray20,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    letterSpacing: -0.45,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(closeOverlays: true),
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.gray20,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text('x'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: patients.length,
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.onSelectPatient(patients.elementAt(index));
                      },
                      child: SizedBox(
                        height: 72,
                        child: Card(
                          elevation: 2,
                          color: isDark ? AppColors.codGray2 : AppColors
                              .lightGray,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              patients.elementAt(index).name??'',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
            ),
          ),
        ],
      ),
    );
  }
}
