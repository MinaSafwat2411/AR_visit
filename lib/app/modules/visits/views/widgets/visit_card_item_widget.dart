import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/visits/controllers/visits_controller.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/models/visits/visitsmodel.dart';
import '../../../../core/widgets/custom_alert.dart';

class VisitCardItemWidget extends GetView<VisitController> {
  const VisitCardItemWidget({
    super.key,
    required this.visitData,
  });

  final VisitModel visitData;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(visitData.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.6,
        children: [
          SlidableAction(
            borderRadius:  controller.lang=='en'? const BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0))
                :const BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) =>  CustomDoubleAlert(
                    title:  'cloneComfirm'.tr,
                    leftButtonText: 'yes'.tr,
                    rightButtonText: 'no'.tr,
                    leftFunction: () => controller.onClone(visitData.id),
                    rightFunction: () => Get.back(closeOverlays: true),
                  )
              );
            },
            backgroundColor: AppColors.softAmber,
            foregroundColor: Colors.black,
            icon: Icons.copy,
            padding: const EdgeInsets.all(8.0),
            label: 'Clone',
          ),
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) =>  CustomDoubleAlert(
                    title: 'doneComfirm'.tr,
                    leftButtonText: 'yes'.tr,
                    rightButtonText: 'no'.tr,
                    leftFunction: () => controller.onDone(visitData.id),
                    rightFunction: () => Get.back(closeOverlays: true),
                  )
              );
            },
            padding: const EdgeInsets.all(8.0),
            backgroundColor: AppColors.softAmber,
            foregroundColor: Colors.black,  // Use a contrasting color
            icon: Icons.check_circle_outline,
            label: 'Done',
          ),
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) =>  CustomDoubleAlert(
                    title:  'cancelComfirm'.tr,
                    leftButtonText: 'yes'.tr,
                    rightButtonText: 'no'.tr,
                    leftFunction: () => controller.onCanceled(visitData.id),
                    rightFunction: () => Get.back(closeOverlays: true),
                  )
              );
            },
            borderRadius: controller.lang=='en'? const BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                :const BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
            backgroundColor: AppColors.softAmber,
            foregroundColor: Colors.black,
            icon: Icons.cancel_outlined,
            padding: const EdgeInsets.all(8.0),
            label: 'Cancel',
          ),

        ],
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.VISIT_DETAILS, arguments: visitData.id);
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 4,
          color: AppColors.softAmber,
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
                      visitData.patient['name'], // Accessing patient name
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${'noOfPeople'.tr} : ${visitData.numberOfPeople}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${'father'.tr}: ${controller.lang == 'en' ? visitData.father['name'] : visitData.father['nameAr']}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                visitData.servant['name'] == "" ? const SizedBox(width: 10) : const Spacer(),
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
                      '${'zone'.tr}: ${controller.lang == 'en' ? visitData.area['name'] : visitData.area['nameAr']}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${'servant'.tr}: ${controller.lang == 'en' ? visitData.servant['name'] : visitData.servant['nameAr']}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
