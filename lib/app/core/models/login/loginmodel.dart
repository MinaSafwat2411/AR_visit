class LoginModel {
  int? e1C1F;
  int? nR;
  String? password;
  LoginModel({this.e1C1F, this.nR, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['E1C1F'] = this.e1C1F;
    data['NR'] = this.nR;
    data['password'] = this.password;
    return data;
  }

}

class UserModel {
  String? token;
  User? user;

  UserModel({this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  Type? type;
  Type? status;
  String? phone;
  String? e1C1F;
  String? nR;

  User(
      {this.id,
        this.name,
        this.email,
        this.type,
        this.status,
        this.phone,
        this.e1C1F,
        this.nR});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    status = json['status'] != null ? new Type.fromJson(json['status']) : null;
    phone = json['phone'];
    e1C1F = json['E1C1F'];
    nR = json['NR'];
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
