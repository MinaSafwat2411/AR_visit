import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/visits/visitsmodel.dart';

class VisitDetailsRetriever {
  static Future<Map<String, VisitModel>> retrieveVisits() async {
    final yesterday = DateTime.now().subtract(const Duration(days: 2));
    final start = DateTime(yesterday.year, yesterday.month, yesterday.day);

    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Visit");
    QuerySnapshot querySnapshot = await visits.get();

    Map<String, VisitModel> visitsData = {};

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      VisitModel visitModel = VisitModel.fromFirestore(doc);
      if(DateTime.parse(visitModel.visitDate).isAfter(start)){
        visitsData[doc.id] = visitModel;
      }
    }

    return visitsData;
  }
}