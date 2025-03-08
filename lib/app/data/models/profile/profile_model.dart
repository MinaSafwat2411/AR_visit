class ProfileModel {
  int? id;
  String? name;
  String? email;
  Type? type;
  Type? status;
  String? phone;
  String? e1C1F;
  String? nR;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.status,
      this.phone,
      this.e1C1F,
      this.nR});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    status = json['status'] != null ? Type.fromJson(json['status']) : null;
    phone = json['phone'];
    e1C1F = json['E1C1F'];
    nR = json['NR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['phone'] = phone;
    data['E1C1F'] = e1C1F;
    data['NR'] = nR;
    return data;
  }
}

class Type {
  int? value;
  String? name;

  Type({this.value, this.name});

  Type.fromJson(Map<String, dynamic> json) {
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