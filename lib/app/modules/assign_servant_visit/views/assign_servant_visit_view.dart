import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_alert.dart';
import '../controllers/assign_servant_visit_controller.dart';

class AssignServantVisitView extends GetView<AssignServantVisitController> {
  const AssignServantVisitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title:  Text(
            'servant'.tr,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ConditionalBuilder(
        condition: !controller.isLoading.value,
        fallback: (context) => const Center(
          child: CircularProgressIndicator(
            color: AppColors.trinidadColor,
          ),
        ),
        builder:(context) => ListView.separated(
            itemBuilder:(context, index) =>  SizedBox(
              height: 45,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) =>  CustomDoubleAlert(
                        title: '${'assignPerson'.tr} \n${controller.servantNames[index]}?',
                        leftButtonText: 'yes'.tr,
                        rightButtonText: 'no'.tr,
                        leftFunction: () {
                          Get.back(closeOverlays: true);
                          controller.onServantSelected(index);
                        },
                        rightFunction: () => Get.back(closeOverlays: true),
                      )
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(
                      controller.servantNames[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )
                  )],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const Divider(color: AppColors.black,),
            itemCount: controller.servantNames.length) ,
      )
    )
    );
  }
}
