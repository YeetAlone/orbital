import 'package:building/authenticate/database.dart';
import 'package:building/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

class AppUserAuthenticator {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(userID: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      await DatabaseService(uid: user?.uid).updateUserData("", "", '');

      return _userFromFirebaseUser(user);
    } catch (e) {
      devtools.log(e.toString());
      return null;
    }
  }

  Future signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      devtools.log(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      devtools.log(e.toString());
      return null;
    }
  }

  Future forgotPassword(String email) async {
    _auth.sendPasswordResetEmail(email: email);
  }
}
