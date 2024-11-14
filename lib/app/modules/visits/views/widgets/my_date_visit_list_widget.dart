import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/visits/visitsmodel.dart';
import '../../controllers/visits_controller.dart';
import 'visit_card_item_widget.dart';
class MyDateVisitListWidget extends GetView<VisitController> {
  const MyDateVisitListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        DateTime date = controller.sortedDates[index];
        List<VisitModel> visitsForDate = controller.groupedVisits[date]!;
        return Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  date.day == DateTime.now().day-1 ? 'yesterday'.tr :date.day == DateTime.now().day ? 'today'.tr : date.day == DateTime.now().day + 1 ? 'tomorrow'.tr : DateFormat('MMM-d',controller.lang).format(date),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, visitIndex) {
                return VisitCardItemWidget(visitData: visitsForDate[visitIndex],);  // Pass the VisitModel object
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: visitsForDate.length,
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: controller.sortedDates.length,
    );
  }
}