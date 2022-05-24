import 'package:building/screens/login/login.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showLogin = true;

  void toggleView() => setState(() => showLogin = !showLogin);

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return const Login(); //(toggleView: toggleView);
    } else {
      return Container(); /// TODO: Route to Main page
    }
  }
}
