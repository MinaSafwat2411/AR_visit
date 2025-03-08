import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'visit_card_item_order_widget.dart';

class MyDateVisitListWidget extends GetView<HomeController> {
  const MyDateVisitListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.trinidadColor,
      onRefresh: () async {
        await controller.getData();
      },
      child: Obx(
            () =>
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent &&
                    !controller.meLoadingMore.value && !controller.lastPageMe.value) {
                  controller.getMoreDataMyVisits();
                }
                return false;
              },
              child: ListView.separated(
                controller: controller.myVisitsScrollController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, visitsIndex) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            controller.formatDate(
                                controller.myVisitsGrouped[visitsIndex].day),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 107 *
                              controller.myVisitsGrouped[visitsIndex].visits
                                  .length
                                  .toDouble(),
                        ),
                        child: Obx(
                              () =>
                              ReorderableListView(
                                physics: const NeverScrollableScrollPhysics(),
                                onReorder: (oldIndex, newIndex) {
                                  controller.order =
                                      controller.myVisitsGrouped[visitsIndex]
                                          .visits
                                          .map((e) => e.id ?? -1)
                                          .toList();
                                  if (newIndex > oldIndex) {
                                    newIndex -= 1;
                                  }
                                  final item = controller
                                      .myVisitsGrouped[visitsIndex]
                                      .visits
                                      .removeAt(oldIndex);
                                  controller.myVisitsGrouped[visitsIndex].visits
                                      .insert(newIndex, item);
                                  final id = controller.order.removeAt(
                                      oldIndex);
                                  controller.order.insert(newIndex, id);
                                  controller.changeVisitOrder();
                                },
                                children: [
                                  for (int index = 0;
                                  index <
                                      controller.myVisitsGrouped[visitsIndex]
                                          .visits.length;
                                  index++)
                                    VisitCardItemOrderWidget(
                                      key: ValueKey(controller
                                          .myVisitsGrouped[visitsIndex]
                                          .visits[index].id),
                                      visit: controller
                                          .myVisitsGrouped[visitsIndex]
                                          .visits[index],
                                    ),
                                ],
                              ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: controller.myVisitsGrouped.length,
              ),
            ),
      ),
    );
  }
}
