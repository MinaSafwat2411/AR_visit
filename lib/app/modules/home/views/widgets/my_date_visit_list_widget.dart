import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'visit_card_item_order_widget.dart';
class MyDateVisitListWidget extends GetView<HomeController> {
  const MyDateVisitListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => RefreshIndicator(
      color: AppColors.trinidadColor,
      onRefresh: () async {
        controller.getVisitsData();
        controller.getArchivesData();
      },
      child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, visitsIndex) {
        return Column(
        children: [
          Row(
          children: [
            const SizedBox(width: 10),
            Text(
            controller.formatDate(controller.meSearchResults[visitsIndex].day),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ],
          ),
            ConstrainedBox(
        constraints: BoxConstraints(
        maxHeight: 110 * controller.meSearchResults[visitsIndex].visits.length.toDouble(),
        ),
          child: Obx(() => ReorderableListView(
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (oldIndex, newIndex) {
              controller.order=[];
              for (var element in controller.meSearchResults[visitsIndex].visits) {
                controller.order.add(element.id??-1);
              }
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final item = controller.meSearchResults[visitsIndex].visits.removeAt(oldIndex);
              controller.meSearchResults[visitsIndex].visits.insert(newIndex, item);
              final id = controller.order.removeAt(oldIndex);
              controller.order.insert(newIndex, id);
              controller.changeVisitOrder();
            },
          children: [
            for (int index = 0; index < controller.meSearchResults[visitsIndex].visits.length; index++)
               VisitCardItemOrderWidget(
                key: ValueKey(controller.meSearchResults[visitsIndex].visits[index].id),
                visit: controller.meSearchResults[visitsIndex].visits[index],
              ),

          ],
          )
          ),
        )

        ]
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: controller.meSearchResults.length,
      ),
    ));
  }
}