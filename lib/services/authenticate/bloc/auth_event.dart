import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn({required this.email, required this.password});
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventGoToRegister extends AuthEvent {
  const AuthEventGoToRegister();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  final String department;
  final String name;
  const AuthEventRegister(
      {required this.email,
      required this.password,
      required this.name,
      required this.department});
}
