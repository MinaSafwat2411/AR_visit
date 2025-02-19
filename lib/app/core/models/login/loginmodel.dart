class LoginModel {
  int? e1C1F;
  int? nR;
  String? password;
  LoginModel({this.e1C1F, this.nR, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['E1C1F'] = e1C1F;
    data['NR'] = nR;
    data['password'] = password;
    return data;
  }

}

class UserModel {
  String? token;
  User? user;

  UserModel({this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
  String? nameAr;
  int? statusValue;
  int? typeValue;

  User(
      {this.id,
        this.name,
        this.email,
        this.type,
        this.nameAr,
        this.status,
        this.phone,
        this.e1C1F,
        this.statusValue,
        this.typeValue,
        this.nR});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    status = json['status'] != null ? Type.fromJson(json['status']) : null;
    phone = json['phone'];
    e1C1F = json['E1C1F'];
    nR = json['NR'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'type': type!.toMap(),
      'status': status!.toMap(),
      'phone': phone,
      'E1C1F': e1C1F,
      'NR': nR,
    };
  }
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_en']= name;
    data['name_ar']=nameAr;
    data['E1C1F']=int.parse(e1C1F!);
    data['NR']=int.parse(nR!);
    data['email']=email;
    data['phone']=phone;
    data['status']=statusValue;

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

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'name': name,
    };
  }
}

class DropDown{
  int? id;
  Name? name;
  DropDown({this.id, this.name});
  DropDown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }
}
class Name {
  String? name;
  String? nameAr;
  Name({this.name, this.nameAr});
  Name.fromJson(Map<String, dynamic> json) {
    name = json['en'];
    nameAr = json['ar'];
  }

}
