import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../appcontroller/app_controller.dart';
import '../../../../data/models/visits/visitmodel.dart';
import '../../controllers/home_controller.dart';

class VisitCardItemOrderWidget extends GetView<HomeController> {
  VisitCardItemOrderWidget({
    super.key,
    required this.visit,
  });

  final AppController appController = Get.find();
  final VisitModel visit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Slidable(
        key: ValueKey(visit.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.6,
          children: [
            SlidableAction(
              borderRadius: appController.lang.value == 'en'
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0))
                  : const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
              onPressed: (context) {
                controller.onDone(visit.id??0);
              },
              backgroundColor: AppColors.softAmber,
              foregroundColor: Colors.black,
              icon: Icons.check,
              padding: const EdgeInsets.all(8.0),
              label: 'done'.tr,
            ),
            SlidableAction(
              onPressed: (context) {
                controller.onCanceled(visit.id??0);
              },
              borderRadius: appController.lang.value == 'en'
                  ? const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
              backgroundColor: AppColors.softAmber,
              foregroundColor: Colors.black,
              icon: Icons.cancel_outlined,
              padding: const EdgeInsets.all(8.0),
              label: 'cancel'.tr,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: (){
            Get.toNamed(Routes.VISIT_DETAILS, arguments: visit
            )?.then(
              (value) {
                if (value) {
                  controller.getData();
                }
              },
            );
          },
          child: Card(
            margin: const EdgeInsets.all(4.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 4,
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
                        visit.userName??"",
                        style: textTheme.titleMedium?.copyWith(
                          color: controller.statusColor(visit.status?.value??0),
                        ),
                      ),
                      Text(
                        '${'noOfPeople'.tr} : ${visit.patientNums??''}',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.black
                        ),
                      ),
                      Text(
                        '${'father'.tr}: ${visit.fatherName ?? ''}',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.black
                        ),
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
                          visit.status?.name ?? '',
                          style: textTheme.titleMedium?.copyWith(
                            color: controller.statusColor(visit.status?.value??0),
                          ),
                        ),
                      ),
                      Text(
                        '${'zone'.tr}: ${visit.area?.name??''}',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.black
                        ),
                      ),
                      Text(
                        '${'servant'.tr}: ${visit.servantName ?? ''}',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.black
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
