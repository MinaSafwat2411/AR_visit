import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';  // Import the intl package for custom date format
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

  static Future<Map<String, VisitModel>> retrieveVisits(bool allVisits) async {
    final yesterday = DateTime.now().subtract(const Duration(days: 2));
    final start = DateTime(yesterday.year, yesterday.month, yesterday.day);

    Query<Map<String, dynamic>> visits = FirebaseFirestore.instance.collection("Visit");
    QuerySnapshot querySnapshot = await visits.get();

    // Extract and filter visit data
    Map<String, VisitModel> visitsData = {};
    List<VisitModel> visitModels = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      VisitModel visitModel = VisitModel.fromFireStore(doc);
      if(!allVisits){
        if (DateTime.parse(visitModel.visitDate).isAfter(start)) {
          visitsData[doc.id] = visitModel;
          visitModels.add(visitModel);
        }
      }else if(DateTime.parse(visitModel.visitDate).isBefore(start)){
        visitsData[doc.id] = visitModel;
        visitModels.add(visitModel);
      }
    }
    visitModels.sort((a, b) {

      DateFormat dateFormat = DateFormat("yyyy-MM-dd h:mm a");
      DateTime dateTimeA = dateFormat.parse("${a.visitDate} ${a.visitTimeRangeFrom}");
      DateTime dateTimeB = dateFormat.parse("${b.visitDate} ${b.visitTimeRangeFrom}");

      return dateTimeA.compareTo(dateTimeB);
    });

    visitsData = {
      for (VisitModel visit in visitModels) visit.id: visit,
    };

    return visitsData;
  }
}
