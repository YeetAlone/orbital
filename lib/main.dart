import 'package:building/screens/login/login.dart';
import 'package:building/screens/login/register.dart';
import 'package:building/screens/profile/profile.dart';
import 'package:building/services/authenticate/bloc/auth_bloc.dart';
import 'package:building/services/authenticate/bloc/auth_event.dart';
import 'package:building/services/authenticate/bloc/auth_state.dart';
import 'package:building/services/authenticate/firebase_auth_provider.dart';
import 'package:building/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:building/screens/map/map.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void main() {
  /// Temporary for web app
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: ThemeMode.system,
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const Wrapper(),
    ),
  ));
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // AuthService.firebase().initialize();
        // AuthService.firebase().logOut();
        if (state is AuthStateLoggedIn) {
          // page a logged in user should see
          return const Map();
        } else if (state is AuthStateRegistering) {
          return const Register();
        } else if (state is AuthStateLoggedOut) {
          return const Login();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
