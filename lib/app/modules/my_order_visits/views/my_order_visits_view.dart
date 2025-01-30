import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/home/controllers/home_controller.dart';
import 'package:ar_visiting_app/app/modules/home/views/widgets/visit_card_item_widget.dart';
import 'package:ar_visiting_app/app/modules/my_order_visits/controllers/my_order_visits_controller.dart';
import 'package:ar_visiting_app/app/modules/my_order_visits/widgets/visit_card_item_order_widget.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderVisitsView extends GetView<MyOrderVisitsController> {
  const MyOrderVisitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(onPressed: ()async{
              controller.orderList.value=[];
              await CacheHelper.removeData(key: 'order');
            }, child:  Text('clear'.tr,style: const TextStyle(color: AppColors.trinidadColor),)),
          )
        ],
        leading: IconButton(onPressed: (){
            Get.back(result: controller.orderList);
        }, icon: const Icon(Icons.arrow_back)),
        title: Text('orderVisits'.tr),
      ),
      body: Obx(() => ConditionalBuilder(
        condition: !controller.isLoading.value,
        fallback: (context) => const Center(child: CircularProgressIndicator(color: AppColors.trinidadColor,)),
        builder: (context) {
            return Obx(() => ConditionalBuilder(
              fallback: (context) =>  Center(child: Text('emptyOrder'.tr),),
              condition: controller.orderList.isNotEmpty,
              builder: (context) {
                return Obx(() => ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                  newIndex -= 1;
                  }
                  final item = controller.visitList.removeAt(oldIndex);
                  controller.visitList.insert(newIndex, item);
                  final itemid = controller.orderList.removeAt(oldIndex);
                  controller.orderList.insert(newIndex, itemid);
                  CacheHelper.saveIntList(key: 'order', value: controller.orderList);
                },
                children: [
                  for (int index = 0; index < controller.visitList.length; index++)
                  VisitCardItemOrderWidget(
                    key: ValueKey(controller.visitList[index].id),
                    visit: controller.visitList[index],
                  ),
                ],
                )
                );
              }
            ));
          }
      )),
    );
  }
}
