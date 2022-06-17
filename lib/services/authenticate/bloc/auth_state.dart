import 'package:building/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {
  const AuthState();
}

// Initial state
class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

// Authenticated state
class AuthStateLoggedIn extends AuthState {
  final AppUser user;
  const AuthStateLoggedIn({required this.user});
}

// Exceptions can be thrown going from LoggedOut to LoggedIn and Registering to LoggedOut

// Unauthenticated state
class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;

  const AuthStateLoggedOut({required this.exception});

  @override
  List<Object?> get props => [exception];
}

// Registration state
class AuthStateRegistering extends AuthState {
  final Exception? exception;

  const AuthStateRegistering({required this.exception});
}
