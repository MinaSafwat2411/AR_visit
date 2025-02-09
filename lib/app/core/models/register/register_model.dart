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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_en'] = this.name;
    data['name_ar'] = this.nameAr;
    data['E1C1F'] = this.e1C1F;
    data['NR'] = this.nR;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

}