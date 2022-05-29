import 'package:building/authenticate/app_auth.dart';
import 'package:building/models/user.dart';
import 'package:building/screens/wrapper.dart';
import 'package:building/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  /// Temporary for web app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "orbital_yeet-alone",
    options: const FirebaseOptions(
      apiKey: "AIzaSyCdLGklC7M0sVaXZR_UbgPyzGpQ9uOqYS4",
      authDomain: "orbital-yeetalone.firebaseapp.com",
      projectId: "orbital-yeetalone",
      storageBucket: "orbital-yeetalone.appspot.com",
      messagingSenderId: "106841316848",
      appId: "1:106841316848:web:3e21fc516d954a44dd1135",
      measurementId: "G-PS9MSTN4E2",
    )
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
        initialData: null,
        value: AppUserAuthenticator().user,
        child: GetMaterialApp(
          home: const Wrapper(),
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          // If you do not have a themeMode switch, uncomment this line
          // to let the device system mode control the theme mode:
          themeMode: ThemeMode.system,

        )
    );
  }
}
