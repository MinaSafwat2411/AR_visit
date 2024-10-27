import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/visits/visitsmodel.dart';

class VisitsRetriever {
  static Future<VisitModel?> retrieveVisitDetails(String id) async {
    try {
      DocumentReference<Map<String, dynamic>> visitDoc = FirebaseFirestore.instance.collection("Visit").doc(id);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await visitDoc.get();

      if (documentSnapshot.exists) {
        VisitModel visitModel = VisitModel.fromFireStore(documentSnapshot);
        return visitModel;
      } else {
        return null;
      }
    } catch (e) {
      return null; // Return null in case of error
    }
  }
  static Future<Map<String, VisitModel>> retrieveVisits() async {
    final yesterday = DateTime.now().subtract(const Duration(days: 2));
    final start = DateTime(yesterday.year, yesterday.month, yesterday.day);

    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Visit");
    QuerySnapshot querySnapshot = await visits.get();

    Map<String, VisitModel> visitsData = {};

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      VisitModel visitModel = VisitModel.fromFireStore(doc);
      if(DateTime.parse(visitModel.visitDate).isAfter(start)){
        visitsData[doc.id] = visitModel;
      }
    }
    return visitsData;
  }
}