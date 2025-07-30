import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../appcontroller/app_controller.dart';
import '../../controllers/home_controller.dart';
import 'visit_card_item_widget.dart';

class DateVisitListWidget extends GetView<HomeController> {
  DateVisitListWidget({super.key});
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RefreshIndicator(
      color: AppColors.trinidadColor,
      onRefresh: () async {
        await controller.getData(); // Refresh logic
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (
          (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent)
              && !(controller.allLoadingMore.value)
              && !(controller.lastPageAll.value))
          {
            controller.getMoreDataAllVisits();
          }
          return false;
        },
        child: Obx(() => ListView.builder(
          controller: controller.allVisitsScrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.allVisitsFiltered.length, // +1 for loader
          itemBuilder: (context, visitsIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      controller.formatDate(
                          controller.allVisitsFiltered[visitsIndex].day,appController.lang.value),
                      style: textTheme.titleMedium,
                    ),
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, visitIndex) {
                      return VisitCardItemWidget(
                        visit: controller.allVisitsFiltered[visitsIndex]
                            .visits[visitIndex],
                      );
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                    itemCount: controller
                        .allVisitsFiltered[visitsIndex].visits.length,
                  ),
                ],
              );
          },
        )),
      ),
    );
  }
}
