import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({required this.text, Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.red, fontSize: 14.0),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({required this.label, required this.textFormField, Key? key})
      : super(key: key);
  final String label;
  final Widget textFormField;
  @override
  Widget build(BuildContext context) {
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

class EmailFieldValidator {
  static String? validate(String? value) {
    return (value?.isNotEmpty ?? false) &&
            isEmail(value.toString()) &&
            value!.endsWith("u.nus.edu")
        ? null
        : "Enter a valid NUS email";
  }
}

class PasswordFieldValidator {
  static String? validate(String? value) {
    return (value ?? "").length < 8
        ? "Password must be more than 8 characters"
        : null;
  }
}
