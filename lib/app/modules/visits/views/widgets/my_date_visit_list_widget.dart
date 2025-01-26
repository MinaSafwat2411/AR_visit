import 'package:ar_visiting_app/app/core/models/visits/VisitsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/visits_controller.dart';
import 'visit_card_item_widget.dart';
class MyDateVisitListWidget extends GetView<VisitController> {
  const MyDateVisitListWidget({
    super.key,
    required this.visits
  });
  final List<DayVisits> visits;

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, visitsIndex) {
        return Column(
          children: [
             Row(
              children: [
                const SizedBox(width: 10),
                Text(controller.formatDate(visits[visitsIndex].day),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, visitIndex) {
                return  VisitCardItemWidget(visit: visits[visitsIndex].visits[visitIndex],);  // Pass the VisitModel object
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: visits[visitsIndex].visits.length,
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: visits.length,
    )
    );
  }
}