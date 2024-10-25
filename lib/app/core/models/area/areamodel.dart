import 'package:cloud_firestore/cloud_firestore.dart';

class Area{
  Area({
    this.area,
    this.areaID,
});
  final String? areaID;
  final String? area;

  factory Area.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Area(
      area: data['name'] ?? "",
      areaID: data['visitId'] ?? ""
    );
  }
}