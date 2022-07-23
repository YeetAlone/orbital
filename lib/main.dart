import 'package:building/screens/home.dart';
import 'package:building/screens/login/login.dart';
import 'package:building/screens/login/register.dart';
import 'package:building/services/services.dart';

import 'package:building/shared/constants.dart';
import 'package:building/shared/shared_data.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: lightTheme,
    darkTheme: darkTheme,
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.system,
    home: MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuthProvider()),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
      ],
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
          return const HomeScreen();
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
