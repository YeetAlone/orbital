import 'package:flutter/material.dart';
// import '../../shared/constants.dart';
import 'package:building/components/app_bar.dart';
import 'package:building/components/search_method_button.dart';

class MainSearch extends StatelessWidget {
  /// TODO: 1. navigate the buttons to the respective pages
  /// TODO: 2. try to put different colours for the borders.

  final String userAuthId;
  const MainSearch({required this.userAuthId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: Column(children: <Widget>[
        ScreenAppBar("SEARCH"),
        const SizedBox(height: 150),
        const Center(
            child: Text("How do you want to find your colleague?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, color: Color.fromRGBO(0, 77, 64, 1)))),
        const SizedBox(height: 50),
        SearchMethodButton(
            title: "   Find by Name",
            iconURL: "assets/name.png",
            bg: const [225, 242, 226],
            respond: () => {}),
        const SizedBox(height: 20),
        SearchMethodButton(
            title: "  Find by Building",
            iconURL: "assets/building.png",
            bg: const [244, 250, 244],
            respond: () => {}),
        const SizedBox(height: 20),
        SearchMethodButton(
            title: " Find by Availability",
            iconURL: "assets/availability.png",
            bg: const [255, 255, 255],
            respond: () => {}),
      ]),
    );
  }
}
