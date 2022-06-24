import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:building/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end testing", () {
    testWidgets("testing the integration of the app",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
    });
  });
}
