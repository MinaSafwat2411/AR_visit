// ignore_for_file: file_names

import 'package:ar_visiting_app/app/core/models/visits/visitmodel.dart';

class DayVisits {
  final String day;
  final List<VisitModel> visits;

  DayVisits({required this.day, required this.visits});

  factory DayVisits.fromJson(Map<String, dynamic> json) {
    return DayVisits(
      day: json['day'],
      visits: (json['visits'] as List<dynamic>)
          .map((visitJson) => VisitModel.fromJson(visitJson as Map<String, dynamic>))
          .toList(),
    );
  }
}
