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
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20), // Set your desired border radius here
                ),
                iconSize: 30,
                initialValue: OperationType.NEW,
                onSelected: (OperationType value) {
                  if (value == OperationType.EDIT) {
                    Get.toNamed(Routes.EDIT_VISIT,
                        arguments: controller.visit.value.id);
                  } else if (value == OperationType.CANCELED) {
                    showDialog(
                        context: context,
                        builder: (context) => CustomDoubleAlert(
                              title: 'cancelComfirm'.tr,
                              leftButtonText: 'yes'.tr,
                              rightButtonText: 'no'.tr,
                              leftFunction: () => controller.onCanceled(),
                              rightFunction: () =>
                                  Get.back(closeOverlays: true),
                            ));
                  } else if (value == OperationType.CLONE) {
                    showDialog(
                        context: context,
                        builder: (context) => CustomDoubleAlert(
                              title: 'cloneComfirm'.tr,
                              leftButtonText: 'yes'.tr,
                              rightButtonText: 'no'.tr,
                              leftFunction: () =>
                                  controller.onClone(controller.visitId),
                              rightFunction: () =>
                                  Get.back(closeOverlays: true),
                            ));
                  }else if(value ==OperationType.DELAYED){
                     showDialog(
                          context: context,
                          builder: (context) => CustomDoubleAlert(
                                title: 'deylayComfirm'.tr,
                                leftButtonText: 'yes'.tr,
                                rightButtonText: 'no'.tr,
                                leftFunction: () => controller.onDelay(),
                                rightFunction: () =>
                                    Get.back(closeOverlays: true),
                              ));
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
                            const Icon(
                              Icons.copy,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('clone'.tr),
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
                            const SizedBox(width: 15,),
                            Text('deylayed'.tr)
                          ],
                        )
                        )
                    ])
          ],
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ConditionalBuilder(
          builder: (context) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.topLeft,
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
                                const Text(
                                  'Name',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.userName ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Phone',
                                  style: TextStyle(fontSize: 18),
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
                              const BoxDecoration(color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'Patient Information',
                              style: TextStyle(
                                  backgroundColor: AppColors.white,
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
                    alignment: Alignment.topLeft,
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
                                const Text(
                                  'Name',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.attendant ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Phone',
                                  style: TextStyle(fontSize: 18),
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
                                    style: const TextStyle(color: AppColors.gray),
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
                              const BoxDecoration(color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'Assistant Information',
                              style: TextStyle(
                                  backgroundColor: AppColors.white,
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
                    alignment: Alignment.topLeft,
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
                                const Text(
                                  'Address Type',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.getAddressType(
                                      controller.visit.value.addressType ?? -1),
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Zone',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.areaName ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Address',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.address ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Location',
                                  style: TextStyle(fontSize: 18),
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
                              const BoxDecoration(color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'Address',
                              style: TextStyle(
                                  backgroundColor: AppColors.white,
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
                    alignment: Alignment.topLeft,
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
                                const Text(
                                  'From',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.from ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'To',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.to ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Date',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.date ?? '',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Patient Number',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.patientNums.toString(),
                                  style:
                                      const TextStyle(color: AppColors.gray),
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
                              const BoxDecoration(color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'Visit Information',
                              style: TextStyle(
                                  backgroundColor: AppColors.white,
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
                    alignment: Alignment.topLeft,
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
                                const Text(
                                  'Father',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.fatherName ?? 'No Father',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Servant',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.servantName??'No Servant',
                                  style:
                                      const TextStyle(color: AppColors.gray),
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
                              const BoxDecoration(color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'Assign',
                              style: TextStyle(
                                  backgroundColor: AppColors.white,
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
                    alignment: Alignment.topLeft,
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
                                const Text(
                                  'Note',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.note ?? 'No Note',
                                  style: const TextStyle(color: AppColors.gray),
                                ),
                                const Divider(
                                  color: AppColors.trinidadColor,
                                ),
                                const Text(
                                  'Status',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  controller.visit.value.status?.name ?? '',
                                  style:  TextStyle(color: controller.statusColor(controller.visit.value.status?.value??-1),fontWeight: FontWeight.bold),
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
                              const BoxDecoration(color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              'Addtional Information',
                              style: TextStyle(
                                  backgroundColor: AppColors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => ConditionalBuilder(
                  condition: controller.visit.value.status?.value ==1,
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
                                      Get.toNamed(Routes.ASSIN_Father_VISIT,
                                          arguments: controller.visitId);
                                    },
                                    rightFunction: () {
                                      Get.back(closeOverlays: true);
                                      Get.toNamed(Routes.ASSIN_SERVANT_VISIT,
                                          arguments: controller.visitId)!;
                                    },
                                  ));
                        },
                      ),
                    );
                  }
                )
                ),
                const SizedBox(
                  height: 12,
                ),
                Obx(() =>ConditionalBuilder(
                  condition: controller.visit.value.status?.value ==2,
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
                  }
                )
                ),
                const SizedBox(
                  height: 12,
                ),
                Obx(() => ConditionalBuilder(
                  fallback: (context) => const SizedBox(),
                  condition: controller.visit.value.fatherName!=null&&controller.visit.value.status?.value==1,
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
                                    leftFunction: () => controller.onInprogress(),
                                    rightFunction: () =>
                                        Get.back(closeOverlays: true),
                                  ));
                        },
                      ),
                    );
                  }
                )
                ),
                const SizedBox(height: 12,)
              ],
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
