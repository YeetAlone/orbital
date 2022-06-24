import 'package:building/components/app_bar.dart';
import 'package:building/components/availability_drawer.dart';
import 'package:building/components/nav_bar.dart';
import 'package:building/components/search_method_button.dart';
import 'package:building/screens/login/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:building/components/info_disp.dart';

Widget navBar() {
  return BottomNavigationBar(
    elevation: 0,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
      BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
      BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
      BottomNavigationBarItem(
          icon: Icon(Icons.access_time), label: 'availability'),
    ],
    type: BottomNavigationBarType.shifting,
    currentIndex: 0,
    iconSize: 40,
    selectedItemColor: Colors.black,
  );
}

void main() {
  testWidgets("information display for profile page",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Container(
            child: InfoDisplay(
      title: "NAME",
      info: "DUMMY VALUE",
    ))));
    expect(find.text("DUMMY VALUE"), findsOneWidget);
    expect(find.text(""), findsNothing);
    expect(find.text("DEPARTMENT"), findsNothing);
  });

  testWidgets("app bar", (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Container(child: screenAppBar("APPBAR TITLE"))));
    expect(find.text("APPBAR TITLE"), findsOneWidget);
    expect(find.text("SOMETHING STUPID"), findsNothing);
  });

  testWidgets("availability_drawer", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AvailabilityDrawer()));
    expect(find.text("Busy"), findsOneWidget);
    expect(find.byIcon(Icons.circle), findsWidgets);
    expect(find.byIcon(Icons.access_time), findsNothing);
  });

  testWidgets("bottom navigation bar", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: navBar()));
    expect(find.text("Search"), findsNothing);
    expect(find.byIcon(Icons.map), findsOneWidget);
    expect(find.byIcon(Icons.bubble_chart), findsNothing);
  });

  testWidgets("search method button", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: SearchMethodButton(
      title: 'Find by Name',
      iconURL: 'assets/name.png',
      bg: const [244, 250, 244],
      onPressed: () {},
    )));
    expect(find.text("Find by Name"), findsOneWidget);
    expect(find.text(""), findsNothing);
  });
}
