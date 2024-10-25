import 'package:ar_visiting_app/app/core/models/area/areamodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAreaFirebase {
  static Future<List<Area>> retrieveArea() async {
    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Area");
    QuerySnapshot querySnapshot = await visits.get();

    List<Area> areas = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Area area=Area.fromFireStore(doc);
      areas.add(area);
    }
    return areas;
  }
}