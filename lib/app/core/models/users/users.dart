import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  Users({
    this.id,
    this.name
});
  final String? id;
  final String? name;

  factory Users.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Users(
        name: data['name'] ?? "",
        id: data['username'] ?? "",
    );
  }
}