import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/father/fathermodel.dart';

class GetFatherFirebase {
  static Future<List<Father>> retrieveFather() async {
    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Father");
    QuerySnapshot querySnapshot = await visits.get();

    List<Father> fathers = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Father father = Father.fromFireStore(doc);
      fathers.add(father);
    }
    return fathers;
  }
}