import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/visits/visitsmodel.dart';
import 'visit_card_item_widget.dart';
class MyDateVisitListWidget extends StatelessWidget {
  const MyDateVisitListWidget({
    super.key,
    required this.visitData,
    required this.visitsDates
  });
  final Map<String, VisitModel> visitData;
  final List<String> visitsDates;
  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<VisitModel>> groupedVisits = {};
    for (var item in visitData.values) {
      DateTime visitDate = DateTime.parse(item.visitDate);  // Accessing visitDate property
      if (!groupedVisits.containsKey(visitDate)) {
        groupedVisits[visitDate] = [];
      }
      groupedVisits[visitDate]!.add(item);
    }

    // Sort dates
    List<DateTime> sortedDates = groupedVisits.keys.toList()
      ..sort((a, b) => a.compareTo(b));
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        DateTime date = sortedDates[index];
        List<VisitModel> visitsForDate = groupedVisits[date]!;

        return Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  date.day == DateTime.now().day ? "Today" : date.day == DateTime.now().day + 1 ? "Tomorrow" : DateFormat('MMM-d').format(date),
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
      itemCount: sortedDates.length,
    );
  }
}