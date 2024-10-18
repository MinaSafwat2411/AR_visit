import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/visits/visitsmodel.dart';

class VisitDetailsRetriever {
  static Future<Map<String, VisitModel>> retrieveVisits() async {
    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Visit");
    QuerySnapshot querySnapshot = await visits.get();

    Map<String, VisitModel> visitsData = {};

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      VisitModel visitModel = VisitModel.fromFirestore(doc);

      visitsData[doc.id] = visitModel;
    }

    return visitsData;
  }
}