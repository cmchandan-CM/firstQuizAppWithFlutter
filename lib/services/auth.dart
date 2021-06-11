import 'package:firebase_auth/firebase_auth.dart';
import "package:quiz_app/models/user.dart";

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInEmailAndPass(String email, String password) async {
    try {
      print("sign in " + email + password);
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(authResult.user!.uid);
      return Users(uid: authResult.user!.uid);
    } catch (e) {
      print("Error during Sign in $e");
      return e;
    }
  }

  Future signUpEmailAndPass(String email, String password) async {
    try {
      print("sign up " + email + password);

      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(authResult.user!.uid);
      return Users(uid: authResult.user!.uid);
    } catch (e) {
      print("Error during Sign Up $e");
      return e;
    }
  }

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print("Error during Sign Out $e");
      return null;
    }
  }
}
