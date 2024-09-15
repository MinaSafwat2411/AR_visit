import 'package:firebase_auth/firebase_auth.dart';

class authentication {
  static Future<bool> login(String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
}
