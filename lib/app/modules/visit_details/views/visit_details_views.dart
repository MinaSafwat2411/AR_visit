import 'package:ar_visiting_app/app/core/widgets/TestVisitdetails.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_alert.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_button.dart';
import 'package:ar_visiting_app/app/modules/visit_details/controllers/visit_details_controllers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../di/operation_type.dart';


class VisitDetailsViews extends GetView<VisitDetailsControllers> {
  const VisitDetailsViews({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title:  Text(
            'visitDetailsTitle'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20), // Set your desired border radius here
                ),
                iconSize: 30,
                initialValue: OperationType.NEW,
                onSelected: (OperationType value) {
                  if (value == OperationType.EDIT) {
                    Get.toNamed(Routes.EDIT_VISIT,arguments: controller.visit.value.id);
                  } else if (value == OperationType.CANCELED) {
                    showDialog(
                        context: context,
                        builder: (context) =>  CustomDoubleAlert(
                          title:  'cancelComfirm'.tr,
                          leftButtonText: 'yes'.tr,
                          rightButtonText: 'no'.tr,
                          leftFunction: () => controller.onCanceled(),
                          rightFunction: () => Get.back(closeOverlays: true),
                        )
                    );
                  }else if(value==OperationType.CLONE){
                    showDialog(
                        context: context,
                        builder: (context) =>  CustomDoubleAlert(
                          title:  'cloneComfirm'.tr,
                          leftButtonText: 'yes'.tr,
                          rightButtonText: 'no'.tr,
                          leftFunction: () => controller.onClone(controller.visitId),
                          rightFunction: () => Get.back(closeOverlays: true),
                        )
                    );
                  }
                },
                position: PopupMenuPosition.under,
                color: AppColors.white,
                itemBuilder: (context) => <PopupMenuEntry<OperationType>>[
                  PopupMenuItem<OperationType>(
                        value: OperationType.EDIT,
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('editIcon'.tr),
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('edit'.tr),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(
                        height: 1,
                      ),
                       PopupMenuItem<OperationType>(
                        value: OperationType.CANCELED,
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('cancelIcon'.tr),
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('cancel'.tr),
                          ],
                        ),
                      ),
                  const PopupMenuDivider(
                    height: 1,
                  ),
                  PopupMenuItem<OperationType>(
                        value: OperationType.CLONE,
                        child: Row(
                          children: [
                            const Icon(Icons.copy,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('clone'.tr),
                          ],
                        ),
                      ),
                    ])
          ],
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.VISITS);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: ConditionalBuilder(
            builder: (context) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  TestVisitDetails(
                    title: 'patientName'.tr,
                    value: controller.visit.value.userName,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'assistantName'.tr,
                      value: controller.visit.value.attendant),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await controller.requestPhonePermission()) {
                      // Launch the phone call
                        controller.launchPhoneDialer(controller.visit.value.attendantPhone!);
                      }
                    },
                    child: TestVisitDetails(
                        title: 'assistantPhoneNumber'.tr,
                        value:
                           controller.visit.value.attendantPhone),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'address'.tr,
                      value: controller.visit.value.address),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'addressType'.tr,
                      value: controller.getAddressType(controller.visit.value.status!.value)),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'zone'.tr,
                      value: controller.visit.value.areaName),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await controller.requestPhonePermission()) {
                        // Launch the phone call
                        controller.launchGoogleLink(controller.visit.value.addressUrl!.substring(8));
                      }
                    },
                    child: TestVisitDetails(
                        title: 'googleMapsLink'.tr,
                        value: controller.visit.value.addressUrl),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'noOfPeople'.tr,
                      value: controller.visit.value.patientNums.toString()),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'date'.tr,
                      value: controller.visit.value.date!.substring(0, 10)
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                    title: 'time'.tr,
                    value: controller.visitTime.value,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'father'.tr,
                      value: controller.visit.value.fatherName),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'servant'.tr,
                      value: controller.visit.value.servantName
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'notes'.tr, value: controller.visit.value.note??'' ),
                  const SizedBox(
                    height: 30,
                  ),
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'assign'.tr,
                      btnColor: AppColors.trinidadColor,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>  CustomDoubleAlert(
                              title: 'assignComfirm'.tr,
                              leftButtonText: 'father'.tr,
                              rightButtonText: 'servant'.tr,
                              leftFunction: () {
                                Get.back(closeOverlays: true);
                                Get.toNamed(Routes.ASSIN_Father_VISIT,arguments: controller.visitId);
                              },
                              rightFunction: () {
                                Get.back(closeOverlays: true);
                                Get.toNamed(Routes.ASSIN_SERVANT_VISIT, arguments: controller.visitId)!;
                              },
                            )
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'done'.tr,
                      btnColor: AppColors.green,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>  CustomDoubleAlert(
                              title: 'doneComfirm'.tr,
                              leftButtonText: 'yes'.tr,
                              rightButtonText: 'no'.tr,
                              leftFunction: () => controller.onDone(),
                              rightFunction: () => Get.back(closeOverlays: true),
                            )
                        );
                      },
                    ),
                  ),
                                    const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'inprogress'.tr,
                      btnColor: AppColors.blue,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>  CustomDoubleAlert(
                              title: 'inprogressComfirm'.tr,
                              leftButtonText: 'yes'.tr,
                              rightButtonText: 'no'.tr,
                              leftFunction: () => controller.onInprogress(),
                              rightFunction: () => Get.back(closeOverlays: true),
                            )
                        );
                      },
                    ),
                  ),
                                    const SizedBox(
                    height: 12,
                  ),
                                    SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'cancel'.tr,
                      btnColor: AppColors.red,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>  CustomDoubleAlert(
                              title: 'cancelComfirm'.tr,
                              leftButtonText: 'yes'.tr,
                              rightButtonText: 'no'.tr,
                              leftFunction: () => controller.onCanceled(),
                              rightFunction: () => Get.back(closeOverlays: true),
                            )
                        );
                      },
                    ),
                  ),
                                    const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'Delayed'.tr,
                      btnColor: AppColors.orange,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>  CustomDoubleAlert(
                              title: 'deylayComfirm'.tr,
                              leftButtonText: 'yes'.tr,
                              rightButtonText: 'no'.tr,
                              leftFunction: () => controller.onDelay(),
                              rightFunction: () => Get.back(closeOverlays: true),
                            )
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            condition: !controller.isLoading.value,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(
                color: AppColors.trinidadColor,
              ),
            ),
          ),
        )));
  }
}
