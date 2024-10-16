import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/login/visitsmodel.dart';

class VisitDetailsRetriever {
  static Future<List<VisitModel>> retrieveVisits() async {
    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Visit");
    QuerySnapshot querySnapshot = await visits.get();

    List<VisitModel> visitsList = [];
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      visitsList.add(VisitModel.fromFirestore(doc));
    }
    return visitsList;
  }
}