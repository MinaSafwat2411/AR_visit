import 'package:cloud_firestore/cloud_firestore.dart';

class VisitModel {
  VisitModel({
    required this.area,
    required this.father,
    required this.patient,
    required this.servant,
    required this.status,
    required this.visitDate,
    required this.visitTimeRangeFrom,
    required this.visitTimeRangeTo,
  });

  final Map<String, dynamic> area;
  final Map<String, dynamic> father;
  final Map<String, dynamic> patient;
  final Map<String, dynamic> servant;
  final String status;
  final String visitDate;
  final String visitTimeRangeFrom;
  final String visitTimeRangeTo;

  factory VisitModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return VisitModel(
      area: data['area'] ?? {},
      father: data['father'] ?? {},
      patient: data['patient'] ?? {},
      servant: data['servant'] ?? {},
      status: data['status'] ?? "Unknown",
      visitDate: data['visitDate'] ?? "",
      visitTimeRangeFrom: data['visitTimeRangeFrom'] ?? "",
      visitTimeRangeTo: data['visitTimeRangeTo'] ?? "",
    );
  }
}