import 'package:ar_visiting_app/app/modules/all_visits/controllers/all_visits_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/visits/visitsmodel.dart';
import '../../../visits/views/widgets/visit_card_item_widget.dart';

class AllMyDateVisitListWidget extends GetView<AllVisitController> {
  const AllMyDateVisitListWidget({
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
                  date.day == DateTime.now().day-1 ? controller.getYesterday() :date.day == DateTime.now().day ? controller.getToday() : date.day == DateTime.now().day + 1 ? controller.getTomorrow() : DateFormat('MMM-d',controller.lang).format(date),
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