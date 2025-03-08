class LogoutModel {
  int? id;
  Name? name;
  String? e1C1F;
  String? nR;
  String? email;
  String? phone;
  int? type;
  int? status;
  String? fcmToken;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  LogoutModel(
      {this.id,
        this.name,
        this.e1C1F,
        this.nR,
        this.email,
        this.phone,
        this.type,
        this.status,
        this.fcmToken,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    e1C1F = json['E1C1F'];
    nR = json['NR'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    status = json['status'];
    fcmToken = json['fcm_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['E1C1F'] = e1C1F;
    data['NR'] = nR;
    data['email'] = email;
    data['phone'] = phone;
    data['type'] = type;
    data['status'] = status;
    data['fcm_token'] = fcmToken;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}