import 'package:cloud_firestore/cloud_firestore.dart';

class areaRetriever {
  static Future<Map<String,String>> retrieveAreas() async {
    CollectionReference areas = FirebaseFirestore.instance.collection('Area');
    QuerySnapshot querySnapshot = await areas.get();

    Map<String, String> areasData = {};

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String name = doc['name'];
      areasData[name] = doc.id;
    }

    // List<Map> areasData = querySnapshot.docs.map((doc) {
    //   return doc['name'].toString();
    // }).toList();
    return areasData;
  }
}
