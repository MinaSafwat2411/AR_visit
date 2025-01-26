class EnumsModel {
  List<UserType>? userType;
  List<UserStatus>? userStatus;
  List<VisitsStatus>? visitsStatus;

  EnumsModel({this.userType, this.userStatus, this.visitsStatus});

  EnumsModel.fromJson(Map<String, dynamic> json) {
    if (json['user_type'] != null) {
      userType = <UserType>[];
      json['user_type'].forEach((v) {
        userType!.add(UserType.fromJson(v));
      });
    }
    if (json['user_status'] != null) {
      userStatus = <UserStatus>[];
      json['user_status'].forEach((v) {
        userStatus!.add(UserStatus.fromJson(v));
      });
    }
    if (json['visits_status'] != null) {
      visitsStatus = <VisitsStatus>[];
      json['visits_status'].forEach((v) {
        visitsStatus!.add(VisitsStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (userType != null) {
      data['user_type'] = userType!.map((v) => v.toJson()).toList();
    }
    if (userStatus != null) {
      data['user_status'] = userStatus!.map((v) => v.toJson()).toList();
    }
    if (visitsStatus != null) {
      data['visits_status'] =
          visitsStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'user_type': userType!.map((e) => e.toMap()).toList(),
      'user_status': userStatus!.map((e) => e.toMap()).toList(),
      'visits_status': visitsStatus!.map((e) => e.toMap()).toList(),
    };
  }
}

class UserType {
  String? name;
  int? value;

  UserType({this.name, this.value});

  UserType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class UserStatus {
  String? name;
  int? value;

  UserStatus({this.name, this.value});

  UserStatus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class VisitsStatus {
  String? name;
  int? value;

  VisitsStatus({this.name, this.value});

  VisitsStatus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }
}