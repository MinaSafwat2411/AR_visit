import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/assign_father_visit/controllers/assign_father_visit_controller.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_alert.dart';

class AssignFatherVisitView extends GetView<AssignFatherVisitController> {
  const AssignFatherVisitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(
            'father'.tr,
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
        actions: [
          // controller.visitData.value.status=="Assigned"? Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextButton(onPressed: (){
          //     controller.onCanceledAssign();
          //   }, child: Text(
          //     'cancel'.tr,
          //     style: const TextStyle(
          //     color: AppColors.trinidadColor
          //   ),),),
          // ):const SizedBox(height: 0,)
        ],
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
                        title: '${'assignPerson'.tr} \n${
                            controller.lang =='en'?controller.fatherList[index].name:
                        controller.fatherList[index].nameAr}?',
                        leftButtonText: 'yes'.tr,
                        rightButtonText: 'no'.tr,
                        leftFunction: () {
                          Get.back(closeOverlays: true);
                          controller.onFatherSelected(controller.fatherList[index]);
                        },
                        rightFunction: () => Get.back(closeOverlays: true),
                      )
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(
                      '${
                          controller.lang =='en'?controller.fatherList[index].name:
                      controller.fatherList[index].nameAr}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )
                  )],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const Divider(color: AppColors.black,),
            itemCount: controller.fatherList.length) ,
      )
    )
    );
  }
}
