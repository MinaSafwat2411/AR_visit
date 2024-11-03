import 'package:ar_visiting_app/app/core/widgets/custom_alert.dart';
import 'package:ar_visiting_app/app/modules/visit_details/controllers/visit_details_controllers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/TestVisitdetails.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../routes/app_pages.dart';
import '../di/operation_type.dart';

class VisitDetailsViews extends GetView<VisitDetailsControllers> {
  const VisitDetailsViews({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Visit Details',
            textAlign: TextAlign.center,
            style: TextStyle(
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
                    showDialog(
                        context: context,
                        builder: (context) =>  CustomDoubleAlert(
                          title: 'You want to Edit this Visit ',
                          leftButtonText: 'Yes',
                          rightButtonText: 'No',
                          leftFunction: () {
                            Get.back(closeOverlays: true);
                            Get.toNamed(Routes.EDIT_VISIT,arguments: controller.id);
                          },
                          rightFunction: () => Get.back(closeOverlays: true),
                        )
                    );
                  } else if (value == OperationType.CANCELED) {
                    showDialog(
                        context: context,
                        builder: (context) =>  CustomDoubleAlert(
                          title: 'You want to Cancel this Visit ',
                          leftButtonText: 'Yes',
                          rightButtonText: 'No',
                          leftFunction: () => controller.onCanceled(),
                          rightFunction: () => Get.back(closeOverlays: true),
                        )
                    );
                  }
                },
                position: PopupMenuPosition.under,
                color: AppColors.white,
                itemBuilder: (context) => <PopupMenuEntry<OperationType>>[
                      const PopupMenuItem<OperationType>(
                        value: OperationType.EDIT,
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('assets/edit.png'),
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(
                        height: 1,
                      ),
                      const PopupMenuItem<OperationType>(
                        value: OperationType.CANCELED,
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('assets/cancel.png'),
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Cancel'),
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
                    title: 'Name',
                    value: controller.visitData.value.patient['name'],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'ARID',
                      value:
                          "E1C1F${controller.visitData.value.patient['PatientFamilyId']}NR${controller.visitData.value.patient['PatientIDNumber']}"),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'patient number',
                      value: controller.visitData.value.patient['phoneNumber']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'assistant name',
                      value: controller.visitData.value.assistant['name']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'assistant phone',
                      value:
                          controller.visitData.value.assistant['phoneNumber']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'address',
                      value: controller.visitData.value.address['address']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'address Type',
                      value: controller.visitData.value.address['addressType']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'area',
                      value: controller.visitData.value.area['name']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'location',
                      value: controller.visitData.value.googleLink),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'No. of people',
                      value: controller.visitData.value.numberOfPeople),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'Date',
                      value: controller.visitData.value.visitDate
                          .substring(5)
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                    title: 'Time',
                    value: controller.visitTime.value,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'Father',
                      value: controller.visitData.value.father['name']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'Servant',
                      value: controller.visitData.value.servant['name']
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'Note', value: controller.visitData.value.note),
                  const SizedBox(
                    height: 30,
                  ),
                      controller.visitData.value.status=="Assigned"||
                      controller.visitData.value.status=="NEW" ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'Assign',
                      btnColor: AppColors.chartreuseYellow,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>  CustomDoubleAlert(
                              title: 'Choose who You want to assign to?',
                              leftButtonText: 'Father',
                              rightButtonText: 'Servant',
                              leftFunction: () {
                                Get.back(closeOverlays: true);
                                Get.toNamed(Routes.ASSIN_Father_VISIT,arguments: controller.id);
                              },
                              rightFunction: () {
                                Get.back(closeOverlays: true);
                                Get.toNamed(Routes.ASSIN_SERVANT_VISIT,arguments: controller.id);
                              },
                            )
                        );
                      },
                    ),
                  ) : const SizedBox(height: 0,),
                  const SizedBox(
                    height: 12,
                  ),
                  controller.visitData.value.status=="Assigned" ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'Done',
                      btnColor: AppColors.green,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>  CustomDoubleAlert(
                              title: 'This Visit is Done',
                              leftButtonText: 'Yes',
                              rightButtonText: 'No',
                              leftFunction: () => controller.onDone(),
                              rightFunction: () => Get.back(closeOverlays: true),
                            )
                        );
                      },
                    ),
                  ): const SizedBox(height: 0,),
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
