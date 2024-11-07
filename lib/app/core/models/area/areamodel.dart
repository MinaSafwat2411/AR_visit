import 'package:cloud_firestore/cloud_firestore.dart';

class Area{
  Area({
    this.area,
    this.areaAr,
});
  final String? area;
  final String? areaAr;

  factory Area.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Area(
      area: data['name'] ?? "",
      areaAr: data['nameAr'] ?? "",
    );
  }
}