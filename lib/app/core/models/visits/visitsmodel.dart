import 'package:cloud_firestore/cloud_firestore.dart';

class VisitModel {
  VisitModel({
    required this.id,
    required this.area,
    required this.father,
    required this.patient,
    required this.servant,
    required this.status,
    required this.visitDate,
    required this.visitTimeRangeFrom,
    required this.visitTimeRangeTo,
    required this.numberOfPeople,
    required this.note,
    required this.address,
    required this.assistant,
    required this.googleLink,
  });
  final String id;
  final Map<String, dynamic> area;
  final Map<String, dynamic> father;
  final Map<String, dynamic> patient;
  final Map<String, dynamic> assistant;
  final Map<String, dynamic> servant;
  final Map<String, dynamic> address;
  final String status;
  final String visitDate;
  final String visitTimeRangeFrom;
  final String visitTimeRangeTo;
  final String numberOfPeople;
  final String googleLink;
  final String note;

  factory VisitModel.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return VisitModel(
      id: doc.id,
      area: data['area'] ?? {},
      father: data['father'] ?? {},
      patient: data['patient'] ?? {},
      assistant: data['assistant'] ?? {},
      servant: data['servant'] ?? {},
      status: data['status'] ?? "Unknown",
      visitDate: data['visitDate'] ?? "",
      visitTimeRangeFrom: data['visitTimeRangeFrom'] ?? "",
      visitTimeRangeTo: data['visitTimeRangeTo'] ?? "",
      numberOfPeople: data['numberOfPeople']?? "",
      address: data['address']?? {},
      note: data['note']?? "",
      googleLink: data['googleLink']?? "",
    );
  }
}