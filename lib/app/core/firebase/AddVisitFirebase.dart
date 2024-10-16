
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/addvisitmodel.dart';

class visitSubmission {
  static void submitVisit(Visit visit)async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Visit');
    await collectionReference.add({
      'area': visit.area,
      'father': visit.father,
      'patient': visit.patient,
      'servant': visit.servant,
      'status': visit.status,
      'visitDate': visit.visitDate,
      'visitTimeRangeFrom': visit.visitTimeRangeFrom,
      'visitTimeRangeTo': visit.visitTimeRangeTo,
    });
  }
}