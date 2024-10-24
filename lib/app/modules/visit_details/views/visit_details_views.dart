import 'package:ar_visiting_app/app/core/utils/MenuItem.dart';
import 'package:ar_visiting_app/app/modules/visit_details/controllers/visit_details_controllers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/TestVisitdetails.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../routes/app_pages.dart';

class VisitDetailsViews extends GetView<VisitDetailsControllers> {
  const VisitDetailsViews({super.key, this.id});
  final String? id;
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
                initialValue: 'nothing',
                onSelected: (String value) {
                  if (value == 'edit') {
                  } else if (value == 'cancelled') {}
                },
                position: PopupMenuPosition.under,
                color: AppColors.white,
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
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
                      const PopupMenuItem<String>(
                        value: 'canceled',
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
              Get.offNamed(Routes.VISITS);
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
                    value: "E1C1F" +
                        controller.visitData.value.patient['PatientFamilyId'] +
                        "NR" +
                        controller.visitData.value.patient['PatientIDNumber'],
                  ),
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
                      value: controller.visitData.value.patient['name']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'assistant phone',
                      value: controller.visitData.value.patient['phoneNumber']),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'address',
                      value: controller.visitData.value.address),
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
                  Row(
                    children: [
                      TestVisitDetails(
                          title: 'Date',
                          value: controller.visitData.value.visitDate
                              .substring(5)),
                      const SizedBox(
                        width: 15,
                      ),
                      TestVisitDetails(
                          title: 'Time',
                          value: controller.visitData.value.visitTimeRangeFrom
                                  .substring(0, 4) +
                              ' To ' +
                              controller.visitData.value.visitTimeRangeTo
                                  .substring(0, 4)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      TestVisitDetails(
                          title: 'Father',
                          value: controller.visitData.value.father['name']),
                      const SizedBox(
                        width: 15,
                      ),
                      TestVisitDetails(
                          title: 'Servant',
                          value: controller.visitData.value.servant['name']),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TestVisitDetails(
                      title: 'Note', value: controller.visitData.value.note),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'Assign',
                      btnColor: AppColors.chartreuseYellow,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 58,
                    child: CustomButton(
                      text: 'Done',
                      btnColor: AppColors.green,
                      onPressed: () {},
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
