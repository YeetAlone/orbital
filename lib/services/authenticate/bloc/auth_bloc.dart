import 'package:bloc/bloc.dart';
import 'package:building/services/authenticate/auth_exceptions.dart';
import 'package:building/services/authenticate/auth_provider.dart';
import 'package:building/services/authenticate/bloc/auth_event.dart';
import 'package:building/services/cloud/firebase_cloud_storage.dart';
// import 'dart:developer' as devtools show log;

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    // initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      // devtools.log(user.toString());
      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null));
      } else {
        emit(AuthStateLoggedIn(user: user));
      }
    });

    // log in
    on<AuthEventLogIn>((event, emit) async {
      try {
        final user =
            await provider.logIn(email: event.email, password: event.password);
        emit(AuthStateLoggedIn(user: user));
      } on Exception catch (exception) {
        emit(AuthStateLoggedOut(exception: exception));
      }
    });

    // log out
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null));
      } on Exception catch (exception) {
        emit(AuthStateLoggedOut(exception: exception));
      }
    });

    // register
    on<AuthEventRegister>((event, emit) async {
      try {
        final user = await provider.createUser(
            email: event.email, password: event.password);
        await FirebaseCloudStorage().createNewAppUser(
            userAuthId: user.userAuthID,
            fullName: event.name,
            email: event.email,
            department: event.department);
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null));
      } on UserNotLoggedInAuthException catch (_) {
        emit(const AuthStateLoggedOut(exception: null));
      } on Exception catch (exception) {
        emit(AuthStateRegistering(exception: exception));
      }
    });

    // go to register
    on<AuthEventGoToRegister>((event, emit) async {
      emit(const AuthStateRegistering(exception: null));
    });
  }
}
