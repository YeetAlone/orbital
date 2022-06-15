import 'package:building/models/user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AppUser? get currentUser;
  Future<AppUser> logIn({required String email, required String password});
  Future<AppUser> createUser({required String email, required String password});
  Future<void> logOut();
}
