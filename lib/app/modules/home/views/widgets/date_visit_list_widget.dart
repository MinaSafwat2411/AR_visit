import 'package:ar_visiting_app/app/core/models/visits/VisitsModel.dart';
import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'visit_card_item_order_widget.dart';
import 'visit_card_item_widget.dart';
class DateVisitListWidget extends GetView<HomeController> {
  const DateVisitListWidget({
    super.key,
    required this.visits
  });
  final List<DayVisits> visits;

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
            controller.formatDate(visits[visitsIndex].day),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ],
          ),
          ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, visitIndex) {
            return VisitCardItemWidget(visit: visits[visitsIndex].visits[visitIndex]);  // Pass the VisitModel object
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: visits[visitsIndex].visits.length,
          )

        ]
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: visits.length,
      ),
    ));
  }
}