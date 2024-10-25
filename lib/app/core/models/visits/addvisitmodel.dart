class Visit {
  Visit({
    required this.area,
    required this.father,
    required this.patient,
    required this.assistant,
    required this.servant,
    required this.status,
    required this.visitDate,
    required this.visitTimeRangeFrom,
    required this.visitTimeRangeTo,
    required this.numberOfPeople,
    required this.note,
    required this.address,
    required this.googleLink,
  });
  Map<String, dynamic> area;
  Map<String, dynamic> father;
  Map<String, dynamic> patient;
  Map<String, dynamic> assistant;
  Map<String, dynamic> servant;
  Map<String, dynamic> address;
  String status;
  String googleLink;
  String visitDate;
  String visitTimeRangeFrom;
  String visitTimeRangeTo;
  String numberOfPeople;
  String note;
}