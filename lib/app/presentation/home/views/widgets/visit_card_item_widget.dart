import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/visits/visitmodel.dart';
import '../../controllers/home_controller.dart';

class VisitCardItemWidget extends GetView<HomeController> {
  const VisitCardItemWidget({super.key, required this.visit});
  final VisitModel visit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.VISIT_DETAILS, arguments: [
          controller.lang.value,
          controller.isDark.value,
          controller.token.value,
          visit
        ])?.then(
          (value) {
            if (value) {
              controller.getData();
            }
          },
        );
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 4,
        color:
            controller.isDark.value ? AppColors.codGray : AppColors.softAmber,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    visit.userName!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${'noOfPeople'.tr} : ${visit.patientNums}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${'father'.tr}: ${visit.fatherName ?? ''}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      visit.status!.name ?? '',
                      style: TextStyle(
                        color:
                            controller.statusColor(visit.status?.value ?? 0),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '${'zone'.tr}: ${visit.area?.name}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${'servant'.tr}: ${visit.servantName ?? ''}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
