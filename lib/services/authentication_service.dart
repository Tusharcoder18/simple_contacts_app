import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
The authentication service contains functional features required for 
authentication such as sign in, sign up, sign out, etc.
Note: Provider is used as the primary state management tool to provide
authentication service to the app.
*/

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  // Notifies about changes to the user's sign-in state
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Returns the current User if they are currently signed-in, or null if not.
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign in a user with a given phone or email and password
  Future<bool> signIn({String? email, String? password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  // Signs out the current user who is signed is using phone and password
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
    debugPrint("User signed out");
  }

  // Sign up a user with a given phone or email and password
  Future<String> signUp({String? email, String? password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      notifyListeners();
      return "Signed Up";
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_MAIL_ALREADY_IN_USE') {
          return "Email Already exists";
        }
      }
    }
    return "";
  }

  // Returns the current user email Id
  String? returnCurrentEmailId() {
    return _firebaseAuth.currentUser?.email;
  }
}
