import 'package:cloud_firestore/cloud_firestore.dart';

class Servant {
  Servant({this.id, this.name, this.phone, this.isFather,this.nameAr});
  final String? id;
  final bool? isFather;
  final String? name;
  final String? nameAr;
  final String? phone;

  factory Servant.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Servant(
        name: data['name'] ?? "",
        nameAr: data['nameAr'] ?? "",
        isFather: data['isFather'] ?? false,
        id: data['id'] ?? "",
        phone: data['phoneNumber'] ?? ""
    );
  }
}