
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/visits/addvisitmodel.dart';

class VisitSubmission {
  static void submitVisit(Visit visit)async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Visit');
    await collectionReference.add({
      'area': visit.area,
      'father': visit.father,
      'patient': visit.patient,
      'assistant': visit.assistant,
      'servant': visit.servant,
      'status': visit.status,
      'address':visit.address,
      'googleLink':visit.googleLink,
      'visitDate': visit.visitDate,
      'visitTimeRangeFrom': visit.visitTimeRangeFrom,
      'visitTimeRangeTo': visit.visitTimeRangeTo,
      'numberOfPeople' :visit.numberOfPeople,
      'note':visit.note,
    });
  }
  static void updateVisit(String documentId, Visit visit) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('Visit');
    await collectionReference.doc(documentId).update(
        {
          'note':visit.note,
          'area': visit.area,
          'father': visit.father,
          'patient': visit.patient,
          'assistant': visit.assistant,
          'servant': visit.servant,
          'status': visit.status,
          'address':visit.address,
          'googleLink':visit.googleLink,
          'visitDate': visit.visitDate,
          'visitTimeRangeFrom': visit.visitTimeRangeFrom,
          'visitTimeRangeTo': visit.visitTimeRangeTo,
          'numberOfPeople' :visit.numberOfPeople
        }
    );
  }
}