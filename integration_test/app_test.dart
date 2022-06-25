import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';

import 'package:integration_test/integration_test.dart';

import 'package:building/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }
  group("end-to-end testing", () {
    testWidgets("testing the integration of the app",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
    });
    testWidgets("authentication testing", (WidgetTester tester) async {
      await Firebase.initializeApp();
      await tester.pumpWidget(const MaterialApp());
      await tester.pumpAndSettle();
      // await tester.tap(find.byWidget(TextFormField()));
      // tester.printToConsole('SignUp screen opens');
      // await tester.pumpAndSettle();
      // await tester.enterText(
      //     find.byKey(const ValueKey('emailSignUpField')), "test1234@gmail.com");
    });
  });
}
