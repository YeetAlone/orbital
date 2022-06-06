import 'package:building/authenticate/app_auth.dart';
import 'package:building/screens/legal/privacy_policy.dart';
import 'package:building/screens/legal/tos.dart';
import 'package:building/screens/login/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';
import 'package:building/screens/profile/profile.dart';
import 'package:building/screens/map/map.dart';
import '../../shared/constants.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// TODO: 1. Set up form decoration for consistency
  /// TODO: 2. Photo resizing to proper phone dimensions (or close)
  /// TODO: 3. Place app logo on screen
  /// TODO: 4. Set placement of everything properly

  final _formKey = GlobalKey<FormState>();
  final AppUserAuthenticator _auth = AppUserAuthenticator();

  String email = "";
  String password = "";
  String error = "";


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
            image: const AssetImage("assets/loginpic.jpg"), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height:90),
                Container(
                  height: 150.0,
                  width: 300.0,   //NOTE: GET THE APPLOGO TO LOAD HERE
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.transparent,             //CHANGED BORDER TO TRANSPARENT FROM WHITE. NO WHITE BORDER LAH
                      width: 8,
                    ),
                ),
                  child: Image.asset("assets/applogo.jpg"),
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(prefixIcon: Icon(Icons.email,color:Colors.grey[600]),hintText: "Email"),
                  validator: (val) => val!.isEmpty && !isEmail(val) ? "Enter a valid email": null,
                  /// TODO: Unsure if update to be done on onChanged or onPress of Login
                  onChanged: (val) {
                    setState(() => email = val);
                  }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(prefixIcon:Icon(Icons.lock_outline, color: Colors.grey[600]),hintText: "Password"),
                  obscureText: true,
                  validator: (val) => val!.length < 8 ? "Password must be more than 8 characters": null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                const SizedBox(height: 20.0),

                ElevatedButton(
                  style: buttonStyle.copyWith(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF00695C)),
                  ),
                  onPressed: () async {
                    ///TODO: Login Validation - Firebase Auth
                    Get.to(() => Map());
                    // if (_formKey.currentState!.validate()) {}

                    // Get.to(() => Profile());
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.signIn(email, password);
                      if (result == null) {
                        error = "Could not sign in with given credentials";
                      }
                    }

                    },
                  child: const Text("Log In")
                ),
                const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.grey,
                        height: 36,
                      ),
                    )),
                    const Text("OR", style: TextStyle(color: Colors.white),),
                    Expanded(child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.grey,
                        height: 36,
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: buttonStyle.copyWith(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF7DCEC4)),
                  ),
                  onPressed: () => Get.to(() => Register(toggleView: widget.toggleView,)),
                  child: const Text("Sign up with Email"),
                ),
              ]
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text.rich(
                    TextSpan(
                      /// Set global style for TOS line here
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => TermsOfService()),
                        ),

                        const TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            decoration: TextDecoration.underline
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => const PrivacyPolicy()),
                        ),
                      ]
                    )
                  )
                ),
            ],
          )
          ),
        ),
    );
  }
}
