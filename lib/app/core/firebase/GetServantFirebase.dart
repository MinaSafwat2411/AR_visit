import 'package:ar_visiting_app/app/core/models/servant/servantmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetServantFirebase {
  static Future<List<Servant>> retrieveServant() async {
    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Servant");
    QuerySnapshot querySnapshot = await visits.get();

    List<Servant> servants = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Servant father=Servant.fromFireStore(doc);
      servants.add(father);
    }
    return servants;
  }
}