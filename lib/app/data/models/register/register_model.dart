class RegisterModel {
  String? name;
  String? nameAr;
  int? e1C1F;
  int? nR;
  String? phone;
  String? email;
  String? password;

  RegisterModel({
    this.name,
    this.nR,
    this.e1C1F,
    this.nameAr,
    this.phone,
    this.email,
    this.password,
});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_en'] = name;
    data['name_ar'] = nameAr;
    data['E1C1F'] = e1C1F;
    data['NR'] = nR;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

}