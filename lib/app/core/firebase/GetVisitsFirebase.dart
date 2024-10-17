import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/login/visitsmodel.dart';

class VisitDetailsRetriever {
  static Future<Map<String, VisitModel>> retrieveVisits() async {
    // Fetch the documents from the "Visit" collection in Firestore
    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Visit");
    QuerySnapshot querySnapshot = await visits.get();

    Map<String, VisitModel> visitsData = {};

    // Loop through each document and map it to VisitModel
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      VisitModel visitModel = VisitModel.fromFirestore(doc);

      // Store each VisitModel instance under its document ID
      visitsData[doc.id] = visitModel;
    }

    return visitsData;
  }
}