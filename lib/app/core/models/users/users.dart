import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  Users({
    this.id,
    this.name,
    this.nameAr
});
  final String? id;
  final String? name;
  final String? nameAr;

  factory Users.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Users(
        name: data['name'] ?? "",
        nameAr: data['nameAr'] ?? "",
        id: data['username'] ?? "",
    );
  }
}