import 'package:flutter/material.dart';
// import '../../shared/constants.dart';
import 'package:building/components/appBar.dart';
import 'package:building/components/searchMethodButton.dart';
import 'package:building/components/navBar.dart';

class MainSearch extends StatelessWidget {
  /// TODO: 1. navigate the buttons to the respective pages
  /// TODO: 2. try to put different colours for the borders.

  const MainSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: Column(children: <Widget>[
        appBar("SEARCH"),
        const SizedBox(height: 150),
        const Center(
            child: Text("How do you want to find your colleague?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, color: Color.fromRGBO(0, 77, 64, 1)))),
        const SizedBox(height: 50),
        SearchMethodButton("   Find by Name", "assets/name.png",
            const [225, 242, 226], () => {}),
        const SizedBox(height: 20),
        SearchMethodButton("  Find by Building", "assets/building.png",
            const [244, 250, 244], () => {}),
        const SizedBox(height: 20),
        SearchMethodButton(" Find by Availability", "assets/availability.png",
            const [255, 255, 255], () => {}),
      ]),
      bottomNavigationBar: navBar(1),
    );
  }
}
