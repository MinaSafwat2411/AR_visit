import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/visits/controllers/visits_controller.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/visits/visitsmodel.dart';
class VisitCardItemWidget extends GetView<VisitController> {
  const VisitCardItemWidget({
    super.key,
    required this.visitData
  });

  final VisitModel visitData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.VISIT_DETAILS,arguments: visitData.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 4,
        color:AppColors.softAmber,
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
                    visitData.patient['name'],  // Accessing patient name
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${controller.getNoOfPeople()} : ${visitData.numberOfPeople}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${controller.getFather()}: ${visitData.father['name']}',  // Accessing father name
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              visitData.servant['name']=="" ?const SizedBox(width: 10,):const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      controller.getStatus(visitData.status),
                      style: TextStyle(
                        color: visitData.status == "Canceled"
                            ? AppColors.redColor
                            : visitData.status == "Assigned"
                            ? AppColors.cornflowerBlue
                            : AppColors.japaneseLaurelColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '${controller.getZone()}: ${visitData.area['name']}',  // Accessing area name
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${controller.getServant()}: ${visitData.servant['name']}',  // Accessing servant name
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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

