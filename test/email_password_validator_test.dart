import 'package:building/screens/login/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email tests', () {
    test('empty email returns error string', () {
      expect(EmailFieldValidator.validate(""), "Enter a valid NUS email");
    });

    test('invalid email returns error string', () {
      expect(EmailFieldValidator.validate("hello"), "Enter a valid NUS email");
    });

    test('null email returns error string', () {
      expect(EmailFieldValidator.validate(null), "Enter a valid NUS email");
    });
  });

  group('Password tests', () {
    test('short password returns error string', () {
      expect(PasswordFieldValidator.validate("badpass"),
          "Password must be more than 8 characters");
    });

    test('empty password returns error string', () {
      expect(PasswordFieldValidator.validate(""),
          "Password must be more than 8 characters");
    });

    test('proper password returns null', () {
      expect(PasswordFieldValidator.validate("badpassword"), null);
    });
  });
}
