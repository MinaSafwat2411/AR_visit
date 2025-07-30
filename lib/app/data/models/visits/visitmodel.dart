
import '../area/areamodel.dart';

class VisitModel {
  int? id;
  String? userName;
  String? userPhone;
  String? fatherName;
  String? servantName;
  Status? status;
  String? attendant;
  String? attendantPhone;
  AddressType? addressType;
  String? address;
  String? addressUrl;
  AreaModel? area;
  int? patientNums;
  String? from;
  String? to;
  String? date;
  String? note;
  int? areaId;
  int? userId;
  int? addressTypeId;

  VisitModel(
      {this.id,
      this.userId,
      this.userName,
      this.userPhone,
      this.fatherName,
      this.servantName,
      this.status,
      this.attendant,
      this.attendantPhone,
      this.addressType,
      this.address,
      this.addressUrl,
      this.area,
      this.areaId,
      this.patientNums,
      this.from,
      this.to,
      this.date,
        this.addressTypeId,
      this.note});

  VisitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    fatherName = json['father_name'];
    servantName = json['servant_name'];
    status =
        json['status'] != null ? Status.fromJson(json['status']) : null;
    attendant = json['attendant'];
    attendantPhone = json['attendant_phone'];
    address = json['address'];
    addressUrl = json['address_url'];
    areaId = json['area_id'];
    area = json['area'] != null ? AreaModel.fromJson(json['area']) : null;
    patientNums = json['patient_nums'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    note = json['note'];
    addressType = json['address_type'] != null
        ? AddressType.fromJson(json['address_type'])
        : null;
  }

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area_id'] = areaId;
    data['attendant'] = attendant;
    data['attendant_phone'] = attendantPhone;
    data['address_type'] = addressTypeId;
    data['address'] = address;
    data['address_url'] = addressUrl;
    data['patient_nums'] = patientNums;
    data['from'] = from;
    data['to'] = to;
    data['date'] = date;
    data['note'] = note;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id']=userId;
    data['area_id'] = areaId;
    data['attendant'] = attendant;
    data['attendant_phone'] = attendantPhone;
    data['address_type'] = addressTypeId;
    data['address'] = address;
    data['address_url'] = addressUrl;
    data['patient_nums'] = patientNums;
    data['from'] = from;
    data['to'] = to;
    data['date'] = date;
    data['note'] = note;
    return data;
  }
}

class Status {
  int? value;
  String? name;

  Status({this.value, this.name});

  Status.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['name'] = name;
    return data;
  }
}
class AddressType{
  int? value;
  String? name;
  AddressType({this.value,this.name});
  AddressType.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    name = json['name'];
  }
}
