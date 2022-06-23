import 'package:building/services/authenticate/bloc/auth_bloc.dart';
import 'package:building/services/authenticate/bloc/auth_event.dart';
import 'package:building/services/authenticate/bloc/auth_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import 'dart:developer' as devtools show log;
import '../../services/authenticate/auth_exceptions.dart';
import '../../services/authenticate/auth_service.dart';
import '../../shared/constants.dart';

// IceBox
// can modify auth service and exceptions to remove the need for a formKey

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService.firebase();
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _reEnterPassword;
  late final TextEditingController _name;
  late final TextEditingController _department;

  String error = "";

  String departmentValue = "Department";

  List items = [
    "Department",
    "Computing",
    "Engineering",
    "Science",
    "Arts and Social Sciences",
    "Business",
    "Medicine"
  ];

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _reEnterPassword = TextEditingController();
    _name = TextEditingController();
    _department = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _department.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateRegistering) {
            if (state.exception is WeakPasswordAuthException) {
              error = "Weak password";
            } else if (state.exception is EmailAlreadyInUseAuthException) {
              error = "Email is already in use";
            } else if (state.exception is InvalidEmailAuthException) {
              error = "Invalid email entered";
            } else if (state.exception is GenericAuthException) {
              error = 'Authentication Error';
            }
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Register",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5.0),
                  GestureDetector(
                    onTap: () {
                      devtools.log("Upload an image");
                    },
                    child: const CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Color.fromRGBO(242, 238, 238, 69),
                      child: Icon(
                        Icons.add,
                        color: Color.fromRGBO(89, 77, 77, 100),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          makeInput(
                            label: "NUS Email",
                            textFormField: TextFormField(
                              controller: _email,
                              validator: (val) => val!.isEmpty && !isEmail(val)
                                  ? "Enter a valid email"
                                  : null,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          makeInput(
                            label: "Password",
                            textFormField: TextFormField(
                              controller: _password,
                              obscureText: true,
                              validator: (val) => val!.length < 8
                                  ? "Password must be more than 8 characters"
                                  : null,
                              autocorrect: false,
                            ),
                          ),
                          makeInput(
                              label: "Re-enter password",
                              textFormField: TextFormField(
                                controller: _reEnterPassword,
                                obscureText: true,
                              )),
                          makeInput(
                            label: "Name",
                            textFormField: TextFormField(
                              controller: _name,
                              decoration: textInputDecoration.copyWith(
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.grey[600]),
                                hintText: "Name",
                              ),
                              validator: (val) =>
                                  val!.isEmpty ? "Enter your name" : null,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                              color: const Color.fromRGBO(242, 238, 238, 69),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: const Text("Department"),
                                  buttonPadding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87),
                                  dropdownDecoration: const BoxDecoration(
                                    color: Color.fromRGBO(210, 233, 227, 1),
                                  ),
                                  value: departmentValue,
                                  buttonWidth: 500,
                                  buttonHeight: 60,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black, size: 30),
                                  onChanged: (newValue) {
                                    setState(() {
                                      departmentValue = newValue as String;
                                    });
                                    for (int i = 0; i < items.length; i++) {
                                      if (departmentValue == items[i]) {
                                        _department.text = items[i];
                                        devtools.log(_department.text);
                                        devtools.log(items[i]);
                                      }
                                    }
                                  },
                                  items: items.map((var item) {
                                    return DropdownMenuItem(
                                        value: item, child: Text(item));
                                  }).toList(),
                                ),
                              )),
                          // makeInput(
                          //   label: "Department",
                          //   textFormField: TextFormField(
                          //     controller: _department,
                          //     decoration: textInputDecoration.copyWith(
                          //       hintText: "e.g. Computer Science",
                          //     ),
                          //     validator: (val) =>
                          //         val!.isEmpty ? "Enter your department" : null,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: buttonStyle.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF7DCEC4)),
                    ),
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      if (_formKey.currentState!.validate()) {
                        if (password == _reEnterPassword.text) {
                          /// NOTE: to be updated when the profile page service
                          ///       is finished.
                          context.read<AuthBloc>().add(AuthEventRegister(
                              email: email,
                              password: password,
                              name: _name.text,
                              department: _department.text));
                        }
                      }
                    },
                    child: const Text("Register"),
                  ),

                  /// Error
                  const SizedBox(height: 12.0),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text.rich(TextSpan(children: [
                          const TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: "Login",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context
                                  .read<AuthBloc>()
                                  .add(const AuthEventLogOut()),
                          )
                        ])),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput({required String label, required Widget textFormField}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        textFormField,
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
