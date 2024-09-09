import 'package:cloud_firestore/cloud_firestore.dart';

class areaRetriever {
  static Future<List> retrieveAreas()async {
    CollectionReference areas = FirebaseFirestore.instance.collection('Area');
    QuerySnapshot querySnapshot = await areas.get();

    List<String> areasData = querySnapshot.docs.map((doc) {
      return doc['name'].toString();
    }).toList();
    return areasData;
  }
}
