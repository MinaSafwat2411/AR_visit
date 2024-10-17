import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/login/visitsmodel.dart';
import 'visit_card_item_widget.dart';

Widget MyVisitList(Map<String, VisitModel> visitData, List<String> visitsDates) {
  Map<DateTime, List<VisitModel>> groupedVisits = {};

  // Group visits by date
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
  // Return the list view
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
                '${date.day == DateTime.now().day ? "Today" : date.day == DateTime.now().day + 1 ? "Tomorrow" : DateFormat('MMM-d').format(date)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, visitIndex) {
              return VisitCardItem(visitsForDate[visitIndex]);  // Pass the VisitModel object
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