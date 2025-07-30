import 'package:ar_visiting_app/app/appcontroller/app_controller.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_alert.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_loading.dart';
import 'package:ar_visiting_app/app/presentation/visit_details/views/widgets/custom_visit_details.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../routes/app_pages.dart';
import '../controllers/visit_details_controllers.dart';
import '../di/bottom_sheet_type.dart';
import '../di/operation_type.dart';

class VisitDetailsViews extends GetView<VisitDetailsControllers> {
  VisitDetailsViews({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future.value(false);
      },
      child: Obx(() => Scaffold(
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
                      if (controller.visit.value.status?.value != 5 &&
                          controller.visit.value.status?.value != 5) {
                        Get.toNamed(Routes.ADD_EDIT_VISIT, arguments: [
                          OperationType.EDIT,
                          controller.visit.value
                        ]);
                      } else {
                        Get.snackbar('Visit', 'can\'t edit this visit');
                      }
                    } else if (value == OperationType.CLONE) {
                      Get.toNamed(Routes.ADD_EDIT_VISIT, arguments: [
                        OperationType.CLONE,
                        controller.visit.value
                      ]);
                    } else if (value == OperationType.DELAYED) {
                      showDialog(
                          context: context,
                          builder: (context) => CustomDoubleAlert(
                                title: 'delayComfirm'.tr,
                                leftButtonText: 'yes'.tr,
                                rightButtonText: 'no'.tr,
                                leftFunction: () {
                                  if (controller.visit.value.status?.value != 5 &&
                                      controller.visit.value.status?.value != 5) {
                                    controller.onDelay();
                                  } else {
                                    Get.back(closeOverlays: true);
                                    Get.snackbar(
                                        'Visit', 'can\'t delay this visit');
                                  }
                                },
                                rightFunction: () =>
                                    Get.back(closeOverlays: true),
                              ));
                    } else if (value == OperationType.CANCELED) {
                      showDialog(
                          context: context,
                          builder: (context) => CustomDoubleAlert(
                                title: 'cancelComfirm'.tr,
                                leftButtonText: 'yes'.tr,
                                rightButtonText: 'no'.tr,
                                leftFunction: () {
                                  if (controller.visit.value.status?.value != 5 &&
                                      controller.visit.value.status?.value != 5) {
                                    controller.onCanceled();
                                  } else {
                                    Get.back(closeOverlays: true);
                                    Get.snackbar(
                                        'Visit', 'can\'t cancel this visit');
                                  }
                                },
                                rightFunction: () =>
                                    Get.back(closeOverlays: true),
                              ));
                    }
                  },
                  position: PopupMenuPosition.under,
                  color: appController.isDark.value
                      ? AppColors.black
                      : AppColors.white,
                  itemBuilder: (context) => <PopupMenuEntry<OperationType>>[
                        if (controller.visit.value.status?.value != 6 &&
                            controller.visit.value.status?.value != 5)
                          PopupMenuItem<OperationType>(
                            value: OperationType.EDIT,
                            child: Row(
                              children: [
                                const Icon(Icons.edit),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'edit'.tr,
                                  style: TextStyle(
                                    color: appController.isDark.value
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (controller.visit.value.status?.value != 6 &&
                            controller.visit.value.status?.value != 5)
                          const PopupMenuDivider(
                            height: 1,
                          ),
                        if (controller.visit.value.status?.value != 6 &&
                            controller.visit.value.status?.value != 5)
                          PopupMenuItem<OperationType>(
                            value: OperationType.CANCELED,
                            child: Row(
                              children: [
                                const Icon(Icons.cancel_outlined),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'cancel'.tr,
                                  style: TextStyle(
                                    color: appController.isDark.value
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (controller.visit.value.status?.value != 6 &&
                            controller.visit.value.status?.value != 5)
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
                              Text(
                                'clone'.tr,
                                style: TextStyle(
                                  color: appController.isDark.value
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (controller.visit.value.status?.value != 6 &&
                            controller.visit.value.status?.value != 5)
                          const PopupMenuDivider(
                            height: 1,
                          ),
                        if (controller.visit.value.status?.value != 6 &&
                            controller.visit.value.status?.value != 5)
                          PopupMenuItem<OperationType>(
                              value: OperationType.DELAYED,
                              child: Row(
                                children: [
                                  const Icon(Icons.watch_off_outlined),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'deylayed'.tr,
                                    style: TextStyle(
                                      color: appController.isDark.value
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  )
                                ],
                              ))
                      ])
            ],
            leading: IconButton(
              onPressed: () {
                Get.back(result: true);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          body: ConditionalBuilder(
            builder: (context) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
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
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.userName ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'patientPhone'.tr,
                                    style: textTheme.titleMedium,
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
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            'patientInformation'.tr,
                            style: textTheme.titleSmall?.copyWith(
                              backgroundColor: appController.isDark.value
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
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
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.attendant ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'assistantPhoneNumber'.tr,
                                    style: textTheme.titleMedium,
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
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            'assistantInformation'.tr,
                            style: textTheme.titleSmall?.copyWith(
                              backgroundColor: appController.isDark.value
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
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
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.addressType?.name ??
                                        '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'zone'.tr,
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.area?.name ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'address'.tr,
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.address ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'googleMapsLink'.tr,
                                    style: textTheme.titleMedium,
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
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            'address'.tr,
                            style: textTheme.titleSmall?.copyWith(
                              backgroundColor: appController.isDark.value
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
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
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.from ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'to'.tr,
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.to ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'date'.tr,
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.date ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'noOfPeople'.tr,
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.patientNums.toString(),
                                    style: textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            'visitInformation'.tr,
                            style: textTheme.titleSmall?.copyWith(
                              backgroundColor: appController.isDark.value
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
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
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.fatherName ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'servant'.tr,
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.servantName ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            'assign'.tr,
                            style: textTheme.titleSmall?.copyWith(
                              backgroundColor: appController.isDark.value
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
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
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.note ?? 'No Note',
                                    style: textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: AppColors.trinidadColor,
                                  ),
                                  Text(
                                    'status'.tr,
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.visit.value.status?.name ?? '',
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: controller.statusColor(controller
                                                .visit.value.status?.value ??
                                            -1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            'addtionalInformation'.tr,
                            style: textTheme.titleSmall?.copyWith(
                              backgroundColor: appController.isDark.value
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CustomVisitDetails(
                            function:() => controller.onDone(),
                            isEnd: appController.lang.value=='en'? true:false,
                            isStart: appController.lang.value=='en'?false:true,
                            text: 'done'.tr,
                            color: AppColors.green,
                          ),
                        ),
                        Expanded(
                          child: CustomVisitDetails(
                            function:() {
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
                                            isDark: appController.isDark.value,
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
                                            isDark: appController.isDark.value,
                                          );
                                        },
                                      );
                                    },
                                  ));
                            },
                            isEnd: false,
                            isStart: false,
                            text: 'assign'.tr,
                            color: AppColors.trinidadColor,
                          ),
                        ),
                        Expanded(
                          child: CustomVisitDetails(
                            function:() => controller.onInProgress(),
                            isEnd: appController.lang.value=='en'? false:true,
                            isStart: appController.lang.value=='en'?true:false,
                            text: 'inProgress'.tr,
                            color: AppColors.blue,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            condition: !controller.isLoading.value,
            fallback: (context) => const CustomLoading(),
          ))),
    );
  }
}
