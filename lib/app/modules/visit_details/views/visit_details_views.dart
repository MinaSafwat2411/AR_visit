import 'package:ar_visiting_app/app/core/widgets/TestVisitdetails.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_alert.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_bottom_sheet.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_button.dart';
import 'package:ar_visiting_app/app/modules/visit_details/controllers/visit_details_controllers.dart';
import 'package:ar_visiting_app/app/modules/visit_details/di/bottom_sheet_type.dart';
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
          title: Text(
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
              padding: const EdgeInsets.symmetric(horizontal: 8),
                menuPadding: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20), // Set your desired border radius here
                ),
                iconSize: 30,
                initialValue: OperationType.NEW,
                onSelected: (OperationType value) {
                  if (value == OperationType.EDIT) {
                    if(controller.visit.value.status?.value != 5 &&controller.visit.value.status?.value != 5) {
                      Get.toNamed(Routes.ADD_EDIT_VISIT,
                          arguments: [controller.lang.value,controller.isDark.value,controller.token.value,OperationType.EDIT,controller.visit.value]);
                    } else {
                      Get.snackbar('Visit', 'can\'t edit this visit');
                    }
                  }  else if (value == OperationType.CLONE) {
                    Get.toNamed(Routes.ADD_EDIT_VISIT,
                        arguments: [controller.lang.value,controller.isDark.value,controller.token.value,OperationType.CLONE,controller.visit.value]);
                  } else if (value == OperationType.DELAYED) {
                    showDialog(
                        context: context,
                        builder: (context) => CustomDoubleAlert(
                              title: 'delayComfirm'.tr,
                              leftButtonText: 'yes'.tr,
                              rightButtonText: 'no'.tr,
                              leftFunction: () {
                                if(controller.visit.value.status?.value != 5 &&controller.visit.value.status?.value != 5) {
                                  controller.onDelay();
                                } else {
                                  Get.back(closeOverlays: true);
                                  Get.snackbar('Visit', 'can\'t delay this visit');
                                }
                              },
                              rightFunction: () =>
                                  Get.back(closeOverlays: true),
                        ));
                  }else if (value == OperationType.CANCELED) {
                    showDialog(
                        context: context,
                        builder: (context) => CustomDoubleAlert(
                          title: 'cancelComfirm'.tr,
                          leftButtonText: 'yes'.tr,
                          rightButtonText: 'no'.tr,
                          leftFunction: () {
                            if(controller.visit.value.status?.value != 5 &&controller.visit.value.status?.value != 5) {
                              controller.onCanceled();
                            } else {
                              Get.back(closeOverlays: true);
                              Get.snackbar('Visit', 'can\'t cancel this visit');
                            }
                          },
                          rightFunction: () =>
                              Get.back(closeOverlays: true),
                        ));
                  }
                },
                position: PopupMenuPosition.under,
                color: controller.isDark.value? AppColors.black:AppColors.white,
                itemBuilder: (context) => <PopupMenuEntry<OperationType>>[
                      PopupMenuItem<OperationType>(
                        value: OperationType.EDIT,
                        child: Row(
                          children: [
                            const Icon(Icons.edit),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('edit'.tr,style: TextStyle(
                              color: controller.isDark.value? AppColors.white: AppColors.black,
                            ),),
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
                            const Icon(Icons.plus_one_outlined),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('cancel'.tr,style: TextStyle(
                              color: controller.isDark.value? AppColors.white: AppColors.black,
                            ),),
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
                            const Icon(
                              Icons.copy,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('clone'.tr,style: TextStyle(
                              color: controller.isDark.value? AppColors.white: AppColors.black,
                            ),),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(
                        height: 1,
                      ),
                      PopupMenuItem<OperationType>(
                          value: OperationType.DELAYED,
                          child: Row(
                            children: [
                              const Icon(Icons.watch_off_outlined),
                              const SizedBox(
                                width: 15,
                              ),
                              Text('deylayed'.tr,style: TextStyle(
                                color: controller.isDark.value? AppColors.white: AppColors.black,
                              ),)
                            ],
                          ))
                    ])
          ],
          leading: IconButton(
            onPressed: () {
              Get.back(result: true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ConditionalBuilder(
          builder: (context) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.trinidadColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    'patientName'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.userName ?? '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                   Text(
                                    'patientPhone'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (await controller
                                          .requestPhonePermission()) {
                                        // Launch the phone call
                                        controller.launchPhoneDialer(
                                            controller.visit.value.userPhone ??
                                                '');
                                      }
                                    },
                                    child: Text(
                                      controller.visit.value.userPhone ?? '',
                                      style:
                                          const TextStyle(color: AppColors.gray),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                            decoration:
                                 BoxDecoration(color: controller.isDark.value? AppColors.codGray2: AppColors.white),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                'patientInformation'.tr,
                                style:  TextStyle(
                                    backgroundColor:  controller.isDark.value? AppColors.codGray2: AppColors.white,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.trinidadColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'assistantName'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.attendant ?? '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'assistantPhoneNumber'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (await controller
                                          .requestPhonePermission()) {
                                        // Launch the phone call
                                        controller.launchPhoneDialer(controller
                                            .visit.value.attendantPhone!);
                                      }
                                    },
                                    child: Text(
                                      controller.visit.value.attendantPhone ?? '',
                                      style:
                                          const TextStyle(color: AppColors.gray),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                            decoration:
                                 BoxDecoration(color:  controller.isDark.value? AppColors.codGray2: AppColors.white),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                'assistantInformation'.tr,
                                style:  TextStyle(
                                    backgroundColor:  controller.isDark.value? AppColors.codGray2: AppColors.white,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.trinidadColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    'addressType'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.getAddressType(
                                        controller.visit.value.addressType ?? -1),
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                   Text(
                                    'zone'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.areaName ?? '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'address'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.address ?? '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'googleMapsLink'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (await controller
                                          .requestPhonePermission()) {
                                        // Launch the phone call
                                        controller.launchGoogleLink(controller
                                            .visit.value.addressUrl!
                                            .substring(8));
                                      }
                                    },
                                    child: Text(
                                      controller.visit.value.addressUrl ?? '',
                                      style:
                                          const TextStyle(color: AppColors.gray),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                            decoration:
                                 BoxDecoration(color: controller.isDark.value? AppColors.codGray2: AppColors.white),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                'address'.tr,
                                style:  TextStyle(
                                    backgroundColor:  controller.isDark.value? AppColors.codGray2: AppColors.white,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.trinidadColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    'from'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.from ?? '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                   Text(
                                    'to'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.to ?? '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                   Text(
                                    'date'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.date ?? '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                   Text(
                                    'noOfPeople'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.patientNums.toString(),
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                            decoration:
                                 BoxDecoration(color:  controller.isDark.value? AppColors.codGray2: AppColors.white),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                'visitInformation'.tr,
                                style:  TextStyle(
                                    backgroundColor:  controller.isDark.value? AppColors.codGray2: AppColors.white,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.trinidadColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'father'.tr,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.fatherName ??
                                        '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                   Text(
                                    'servant'.tr,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.servantName ??
                                        '',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                            decoration:
                                 BoxDecoration(color: controller.isDark.value? AppColors.codGray2: AppColors.white),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                'assign'.tr,
                                style:  TextStyle(
                                    backgroundColor:  controller.isDark.value? AppColors.codGray2: AppColors.white,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.trinidadColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'notes'.tr,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.note ?? 'No Note',
                                    style: const TextStyle(color: AppColors.gray),
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'status'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    controller.visit.value.status?.name ?? '',
                                    style: TextStyle(
                                        color: controller.statusColor(controller
                                                .visit.value.status?.value ??
                                            -1),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                            decoration:
                                 BoxDecoration(color: controller.isDark.value? AppColors.codGray2: AppColors.white),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                'addtionalInformation'.tr,
                                style:  TextStyle(
                                    backgroundColor:  controller.isDark.value? AppColors.codGray2: AppColors.white,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => ConditionalBuilder(
                      condition: controller.visit.value.status?.value != 2 && controller.visit.value.status?.value != 5&&controller.visit.value.status?.value != 6,
                      fallback: (context) => const SizedBox(),
                      builder: (context) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 58,
                          child: CustomButton(
                            text: 'assign'.tr,
                            btnColor: AppColors.trinidadColor,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomDoubleAlert(
                                        title: 'assignComfirm'.tr,
                                        leftButtonText: 'father'.tr,
                                        rightButtonText: 'servant'.tr,
                                        leftFunction: () {
                                          Get.back(closeOverlays: true);
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomBottomSheet(
                                                title: 'father'.tr, 
                                                items: controller.fatherNames,
                                                bottomSheetType: BottomSheetType.FATHER,
                                                isDark: controller.isDark.value,
                                              );
                                            },
                                          );
                                        },
                                        rightFunction: () {
                                          Get.back(closeOverlays: true);
                                            showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomBottomSheet(
                                                title: 'servant'.tr, 
                                                items: controller.servantNames,
                                                bottomSheetType: BottomSheetType.SERVANT,
                                                isDark: controller.isDark.value,
                                                );
                                            },
                                          );
                                        },
                                      ));
                            },
                          ),
                        );
                      })),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(() => ConditionalBuilder(
                      condition: controller.visit.value.status?.value !=5 && controller.visit.value.status?.value != 6,
                      fallback: (context) => const SizedBox(),
                      builder: (context) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 58,
                          child: CustomButton(
                            text: 'done'.tr,
                            btnColor: AppColors.green,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomDoubleAlert(
                                        title: 'doneComfirm'.tr,
                                        leftButtonText: 'yes'.tr,
                                        rightButtonText: 'no'.tr,
                                        leftFunction: () => controller.onDone(),
                                        rightFunction: () =>
                                            Get.back(closeOverlays: true),
                                      ));
                            },
                          ),
                        );
                      })),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(() => ConditionalBuilder(
                      fallback: (context) => const SizedBox(),
                      condition: controller.visit.value.fatherName!= null && controller.visit.value.fatherName != '' && controller.visit.value.status?.value !=5&& controller.visit.value.status?.value !=6&& controller.visit.value.status?.value !=2,
                      builder: (context) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 58,
                          child: CustomButton(
                            text: 'inprogress'.tr,
                            btnColor: AppColors.blue,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomDoubleAlert(
                                        title: 'inprogressComfirm'.tr,
                                        leftButtonText: 'yes'.tr,
                                        rightButtonText: 'no'.tr,
                                        leftFunction: () =>
                                            controller.onInProgress(),
                                        rightFunction: () =>
                                            Get.back(closeOverlays: true),
                                      ));
                            },
                          ),
                        );
                      })),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
          condition: !controller.isLoading.value,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.trinidadColor,
            ),
          ),
        )));
  }
}
