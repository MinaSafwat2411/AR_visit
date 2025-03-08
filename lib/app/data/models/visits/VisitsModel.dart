import 'package:ar_visiting_app/app/data/models/visits/visitmodel.dart';
import 'package:get/get.dart';

class DayVisits {
  final String day;
  final RxList<VisitModel> visits;

  DayVisits({required this.day, required this.visits});

  factory DayVisits.fromJson(Map<String, dynamic> json) {
    return DayVisits(
      day: json['day'],
      visits: (json['visits'] as List<dynamic>)
          .map((visitJson) => VisitModel.fromJson(visitJson as Map<String, dynamic>))
          .toList().obs,
    );
  }
}
