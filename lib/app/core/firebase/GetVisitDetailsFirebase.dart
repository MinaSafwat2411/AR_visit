import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/visits/visitsmodel.dart';

class VisitDetailRetriever {
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
}