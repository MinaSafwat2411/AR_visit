import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/models/visits/visitmodel.dart';
import '../../../../core/widgets/custom_alert.dart';
import '../../controllers/home_controller.dart';

class VisitCardItemWidget extends GetView<HomeController> {
  const VisitCardItemWidget({
    super.key,
    required this.visit
  });
  final VisitModel visit;
  @override
  Widget build(BuildContext context) {
    return Slidable(
    key: ValueKey(visit.id),
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.6,
      children: [
      SlidableAction(
        borderRadius: controller.lang.value == 'en'
          ? const BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0))
          : const BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
        onPressed: (context) {
        showDialog(
          context: context,
          builder: (context) => CustomDoubleAlert(
          title: 'cloneComfirm'.tr,
          leftButtonText: 'yes'.tr,
          rightButtonText: 'no'.tr,
          leftFunction: () => controller.onClone(visit),
          rightFunction: () => Get.back(closeOverlays: true),
          ),
        );
        },
        backgroundColor: controller.isDark.value? AppColors.codGray: AppColors.softAmber,
        foregroundColor: controller.isDark.value? AppColors.trinidadColor: AppColors.black,
        icon: Icons.copy,
        padding: const EdgeInsets.all(8.0),
        label: 'clone'.tr,
      ),
      SlidableAction(
        onPressed: (context) {
        showDialog(
          context: context,
          builder: (context) => CustomDoubleAlert(
          title: 'doneComfirm'.tr,
          leftButtonText: 'yes'.tr,
          rightButtonText: 'no'.tr,
          leftFunction: () => controller.onDone(visit.id!),
          rightFunction: () => Get.back(closeOverlays: true),
          ),
        );
        },
        padding: const EdgeInsets.all(8.0),
        backgroundColor: controller.isDark.value? AppColors.codGray: AppColors.softAmber,
        foregroundColor: controller.isDark.value? AppColors.trinidadColor: AppColors.black,
        icon: Icons.check_circle_outline,
        label: 'done'.tr,
      ),
      SlidableAction(
        onPressed: (context) {
        showDialog(
          context: context,
          builder: (context) => CustomDoubleAlert(
          title: 'cancelComfirm'.tr,
          leftButtonText: 'yes'.tr,
          rightButtonText: 'no'.tr,
          leftFunction: () => controller.onCanceled(visit.id!),
          rightFunction: () => Get.back(closeOverlays: true),
          ),
        );
        },
        borderRadius: controller.lang == 'en'
          ? const BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
          : const BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
        backgroundColor: controller.isDark.value? AppColors.codGray: AppColors.softAmber,
        foregroundColor: controller.isDark.value? AppColors.trinidadColor: AppColors.black,
        icon: Icons.cancel_outlined,
        padding: const EdgeInsets.all(8.0),
        label: 'cancel'.tr,
      ),
      ],
    ),
    child: GestureDetector(
      onTap: () {
      Get.toNamed(Routes.VISIT_DETAILS, arguments: visit)?.then((value) {
        if(value){
          controller.getVisitsData();
        }
      },);
      },
      child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 4,
      color: controller.isDark.value? AppColors.codGray: AppColors.softAmber,
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
            '${'noOfPeople'.tr} : ${visit.patientNums}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Text(
            '${'father'.tr}: ${visit.fatherName ?? ''}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
          ),
          const SizedBox(width: 10,),
          Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              visit.status!.name ?? '',
              style: TextStyle(
              color: controller.statusColor(visit.status?.value ?? 0),
              fontSize: 15,
              fontWeight: FontWeight.w500,
              ),
            ),
            ),
            Text(
            '${'zone'.tr}: ${visit.areaName}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Text(
            '${'servant'.tr}: ${visit.servantName ?? ''}',
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
