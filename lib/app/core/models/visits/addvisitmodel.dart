class Visit {
  Visit({
    required this.area,
    required this.father,
    required this.patient,
    required this.servant,
    required this.status,
    required this.visitDate,
    required this.visitTimeRangeFrom,
    required this.visitTimeRangeTo,
  });
  Map<String, dynamic> area;
  Map<String, dynamic> father;
  Map<String, dynamic> patient;
  Map<String, dynamic> servant;
  String status;
  String visitDate;
  String visitTimeRangeFrom;
  String visitTimeRangeTo;
}