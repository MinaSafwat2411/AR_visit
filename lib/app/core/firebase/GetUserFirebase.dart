import 'package:ar_visiting_app/app/core/models/users/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserData {
  static Future<Users?> retrieveUserData(String id) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where('username', isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userDoc = querySnapshot.docs.first;
      return Users.fromFireStore(userDoc);
    } else {
      return null;
    }
  }
}
