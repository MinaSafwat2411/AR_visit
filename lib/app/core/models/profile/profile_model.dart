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
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    status = json['status'] != null ? new Type.fromJson(json['status']) : null;
    phone = json['phone'];
    e1C1F = json['E1C1F'];
    nR = json['NR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['phone'] = this.phone;
    data['E1C1F'] = this.e1C1F;
    data['NR'] = this.nR;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['name'] = this.name;
    return data;
  }
}