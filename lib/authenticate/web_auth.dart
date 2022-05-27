import 'package:building/models/user.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class AuthService {

  final FirebaseAuthWeb _auth = FirebaseAuthWeb.instance;

  AppUser? _userFromFirebaseUser(UserPlatform? user) {
    return user != null ? AppUser(
        userID: user.uid,
    ) : null;
  }

  Stream<AppUser?> get user => _auth.authStateChanges().map(_userFromFirebaseUser);

  Future signIn(String email, String password) async{
    try {
      UserCredentialPlatform userCredential = await _auth.signInWithEmailAndPassword(email, password);
      UserPlatform? user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password) async {
    try {
      /// TODO: Checks with NUS VAFS
      /// Procedure: Check user email if it is a valid NUS email,
      /// run NUS-VAFS in the background and check for authentication call
      UserCredentialPlatform userCredential = await _auth.createUserWithEmailAndPassword(email, password);
      UserPlatform? user = userCredential.user;

      /// TODO: Create new account - AppUserData

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future logout() async{
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}