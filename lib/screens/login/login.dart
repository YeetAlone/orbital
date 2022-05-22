import 'package:building/screens/legal/privacy_policy.dart';
import 'package:building/screens/legal/tos.dart';
import 'package:building/screens/login/forgot_password.dart';
import 'package:building/screens/login/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';
import '../../shared/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// TODO: 1. Set up form decoration for consistency
  /// TODO: 2. Photo resizing to proper phone dimensions (or close)
  /// TODO: 3. Place app logo on screen
  /// TODO: 4. Set placement of everything properly

  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/loginpic.jpg"), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val) => val!.isEmpty && !isEmail(val) ? "Enter a valid email": null,
                  /// TODO: Unsure if update to be done on onChanged or onPress of Login
                  onChanged: (val) {
                    setState(() => email = val);
                  }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Password"),
                  obscureText: true,
                  validator: (val) => val!.length < 8 ? "Password must be more than 8 characters": null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                const SizedBox(height: 20.0),
                TextButton(
                    onPressed: () => Get.to(() => const ForgotPassword()),
                    child: const Text(
                        "Forgot your password?",
                      /// TODO: Set TextStyle to underline
                      style: TextStyle(),
                    )
                ),
                ElevatedButton(
                  onPressed: () async {
                    ///TODO: Login Validation - Firebase Auth
                    if (_formKey.currentState!.validate()) {}
                    },
                  child: const Text("Log In")
                ),
                ///TODO: Line with OR
                const SizedBox(height: 20.0),
                const Text("OR"),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () => Get.to(() => const Register()),
                    child: const Text("Sign up with Email"),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      TextButton(
                        /// TODO: Set up underline style
                          onPressed: () => Get.to(() => const TermsOfService()),
                          child: const Text(
                              "Terms of Service",
                            style: TextStyle(fontSize: 10.0),
                          ),
                      ),
                      const Text(" and ", style: TextStyle(fontSize: 10.0),),
                      TextButton(
                        onPressed: () => Get.to(() => const PrivacyPolicy()),
                        child: const Text("Privacy Policy",
                          style: TextStyle(fontSize: 10.0),
                        ),
                      )
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),

    );
  }
}
