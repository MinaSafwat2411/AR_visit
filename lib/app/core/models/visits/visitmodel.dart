import 'package:ar_visiting_app/app/core/models/visits/statusmodel.dart';

class VisitModel {
  final int? id;
  final String? userName;
  final String? fatherName;
  final String? servantName;
  final Status? status;
  final String? attendant;
  final String? attendantPhone;
  final int? addressType;
  final String? address;
  final String? addressUrl;
  final String? areaName;
  final int? patientNums;
  final String? from;
  final String? to;
  final String? date;
  final String? note;
  // ignore: non_constant_identifier_names
  final int? E1C1F;
  // ignore: non_constant_identifier_names
  final int? NR;
  // ignore: non_constant_identifier_names
  final int? area_id;
  final int? userId;

  VisitModel({
    this.id,
    this.userName,
    this.fatherName,
    this.servantName,
    this.status,
    this.attendant,
    this.attendantPhone,
    this.addressType,
    this.address,
    this.addressUrl,
    this.areaName,
    this.patientNums,
    this.from,
    this.to,
    this.date,
    this.note,
    // ignore: non_constant_identifier_names
    this.E1C1F,
    // ignore: non_constant_identifier_names
    this.NR,
    // ignore: non_constant_identifier_names
    this.area_id,
    this.userId
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
      E1C1F: json['E1C1F'],
      NR: json['NR'],
      area_id: json['area_id']
    );
  }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(userId!=null) data['user_id'] = userId;
    data['attendant'] = attendant;
    data['patient_nums'] = patientNums;
    data['attendant_phone'] = attendantPhone;
    data['address_type'] = addressType;
    data['address'] = address;
    data['address_url'] = addressUrl;
    data['from'] = from;
    data['to'] = to;
    data['date'] = date;
    if(note != null)data['note'] = note;
    if(E1C1F!=null) data['E1C1F'] = E1C1F;
    if(NR!=null)data['NR'] = NR;
    data['area_id'] = area_id;
    return data;
  }
}
