import 'package:building/screens/legal/privacy_policy.dart';
import 'package:building/screens/legal/tos.dart';
import 'package:building/services/authenticate/auth_service.dart';
import 'package:building/services/authenticate/bloc/auth_bloc.dart';
import 'package:building/services/authenticate/bloc/auth_event.dart';
import 'package:building/services/authenticate/bloc/auth_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';
import '../../services/authenticate/auth_exceptions.dart';
import '../../shared/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService.firebase();

  late final TextEditingController _email;
  late final TextEditingController _password;
  String error = "";

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.srcOver),
              image: const AssetImage("assets/loginpic.jpg"),
              fit: BoxFit.cover)),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateLoggedOut) {
            if (state.exception is UserNotFoundAuthException) {
              error = "Cannot find a user with the given credentials";
            } else if (state.exception is WrongPasswordAuthException) {
              error = "Wrong credentials";
            } else if (state.exception is GenericAuthException) {
              error = "Authentication Error";
            }
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 90),
                    Container(
                      height: 150.0,
                      width: 300.0, //NOTE: GET THE APPLOGO TO LOAD HERE
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.transparent,
                          width: 8,
                        ),
                      ),
                      child: Image.asset("assets/applogo.jpg"),
                    ),
                    const SizedBox(height: 40.0),
                    TextFormField(
                      controller: _email,
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.email, color: Colors.grey[600]),
                        hintText: "Email",
                      ),
                      validator: (val) => val!.isEmpty && !isEmail(val)
                          ? "Enter a valid email"
                          : null,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _password,
                      decoration: textInputDecoration.copyWith(
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.grey[600]),
                        hintText: "Password",
                      ),
                      obscureText: true,
                      validator: (val) => val!.length < 8
                          ? "Password must be more than 8 characters"
                          : null,
                      autocorrect: false,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        style: buttonStyle.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF00695C)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthEventLogIn(
                                    email: _email.text,
                                    password: _password.text,
                                  ),
                                );
                          }
                        },
                        child: const Text("Log In")),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: const Divider(
                            color: Colors.grey,
                            height: 36,
                          ),
                        )),
                        const Text(
                          "OR",
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 10.0),
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
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF7DCEC4)),
                      ),
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(const AuthEventGoToRegister()),
                      child: const Text("Sign up with Email"),
                    ),
                  ]),
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
                      child: Text.rich(TextSpan(

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
                                ..onTap =
                                    () => Get.to(() => const TermsOfService()),
                            ),
                            const TextSpan(
                              text: ' and ',
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => Get.to(() => const PrivacyPolicy()),
                            ),
                          ]))),
                ],
              )),
        ),
      ),
    );
  }
}
