import 'package:ar_visiting_app/models/visit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class visitSubmission {
  static void submitVisit(Visit visit) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Visit');
    collectionReference.add({
      'area': visit.area,
      'father': visit.father,
      'patient': visit.patient,
      'servnt': visit.servant,
      'status': visit.status,
      'visitDate': visit.visitDate,
      'visitTimeRangeFrom': visit.visitTimeRangeFrom,
      'visitTimeRangeTo': visit.visitTimeRangeTo,
    });
  }
}
