import 'package:building/screens/login/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Register",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                const SizedBox(height: 5.0),
                GestureDetector(
                  onTap: () {
                    /// TODO: On-tap upload image
                    print("Upload an image");
                  },
                  /// TODO: Color of icon
                  child: const CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Color.fromRGBO(242, 238, 238, 69),
                    child: Icon(Icons.add, color: Color.fromRGBO(89, 77, 77, 100),),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        makeInput(label: "NUS Email"),
                        makeInput(label: "Name"),
                        makeInput(label: "Department"),
                      ],
                    ),
                ),
                const SizedBox(height: 20.0,),
                ElevatedButton(
                  /// TODO: Registration
                    style: buttonStyle.copyWith(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF7DCEC4)),
                    ),
                    onPressed: () => Get.to(() => const Login()),
                    child: const Text("Register"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Already have an account? "
                              ),
                              TextSpan(
                                text: "Login",
                                style: const TextStyle( fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pop(context),
                              )
                            ]
                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget makeInput({label}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        const SizedBox(height: 5,),
        const TextField(decoration: textInputDecoration,),
        const SizedBox(height: 10,)
      ],
    );
  }
}
