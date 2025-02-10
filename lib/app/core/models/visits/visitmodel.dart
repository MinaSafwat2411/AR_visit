class VisitModel {
  int? id;
  String? userName;
  String? userPhone;
  String? fatherName;
  String? servantName;
  Status? status;
  String? attendant;
  String? attendantPhone;
  int? addressType;
  String? address;
  String? addressUrl;
  String? areaName;
  int? patientNums;
  String? from;
  String? to;
  String? date;
  String? note;
  int? areaId;
  int? userId;
  int? e1C1F;
  int? nR;

  VisitModel(
      {this.id,
      this.e1C1F,
      this.nR,
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
      this.areaName,
      this.areaId,
      this.patientNums,
      this.from,
      this.to,
      this.date,
      this.note});

  VisitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    e1C1F = json['E1C1F'];
    nR = json['NR'];
    userId = json['user_id'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    fatherName = json['father_name'];
    servantName = json['servant_name'];
    status =
        json['status'] != null ? Status.fromJson(json['status']) : null;
    attendant = json['attendant'];
    attendantPhone = json['attendant_phone'];
    addressType = json['address_type'];
    address = json['address'];
    addressUrl = json['address_url'];
    areaId = json['area_id'];
    areaName = json['area_name'];
    patientNums = json['patient_nums'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    note = json['note'];
  }

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area_id'] = areaId;
    data['attendant'] = attendant;
    data['attendant_phone'] = attendantPhone;
    data['address_type'] = addressType;
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
    if(e1C1F!=null) data['E1C1F']=e1C1F;
    if(nR!=null) data['NR']=nR;
    data['user_id']=userId;
    data['area_id'] = areaId;
    data['attendant'] = attendant;
    data['attendant_phone'] = attendantPhone;
    data['address_type'] = addressType;
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