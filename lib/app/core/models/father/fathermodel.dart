

import 'package:cloud_firestore/cloud_firestore.dart';

class Father {
  Father({this.id, this.name, this.phone, this.isFather,this.nameAr});
  final String? id;
  final bool? isFather;
  final String? name;
  final String? nameAr;
  final String? phone;

  factory Father.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Father(
        name: data['name'] ?? "",
        nameAr: data['nameAr'] ?? "",
        isFather: data['isFather'] ?? true,
        id: data['id'] ?? "",
        phone: data['phoneNumber'] ?? ""
    );
  }
}
