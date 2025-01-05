import 'package:ar_visiting_app/app/core/models/visits/statusmodel.dart';

class VisitModel {
  final int id;
  final String userName;
  final String? fatherName;
  final String? servantName;
  final Status status;
  final String attendant;
  final String attendantPhone;
  final int addressType;
  final String address;
  final String addressUrl;
  final String areaName;
  final int patientNums;
  final String from;
  final String to;
  final String date;
  final String? note;

  VisitModel({
    required this.id,
    required this.userName,
    this.fatherName,
    this.servantName,
    required this.status,
    required this.attendant,
    required this.attendantPhone,
    required this.addressType,
    required this.address,
    required this.addressUrl,
    required this.areaName,
    required this.patientNums,
    required this.from,
    required this.to,
    required this.date,
    this.note,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'],
      userName: json['user_name'],
      fatherName: json['father_name'] ?? '',
      servantName: json['servant_name'] ?? '',
      status: Status.fromJson(json['status']),
      attendant: json['attendant'],
      attendantPhone: json['attendant_phone'],
      addressType: json['address_type'],
      address: json['address'],
      addressUrl: json['address_url'],
      areaName: json['area_name'],
      patientNums: json['patient_nums'],
      from: json['from'],
      to: json['to'],
      date: json['date'],
      note: json['note'],
    );
  }
}
