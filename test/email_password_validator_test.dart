import 'package:building/screens/login/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email tests', () {
    test('empty email returns error string', () {
      expect(EmailFieldValidator.validate(""), "Enter a valid email");
    });

    test('invalid email returns error string', () {
      expect(EmailFieldValidator.validate("hello"), "Enter a valid email");
    });

    test('null email returns error string', () {
      expect(EmailFieldValidator.validate(null), "Enter a valid email");
    });

    test('valid email retuns null', () {
      expect(EmailFieldValidator.validate("q@w.com"), null);
    });

    test('valid email retuns null', () {
      expect(EmailFieldValidator.validate("ishita11@gmail.com"), null);
    });

    test('valid email retuns null', () {
      expect(EmailFieldValidator.validate("ishita@gmail.com"), null);
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
