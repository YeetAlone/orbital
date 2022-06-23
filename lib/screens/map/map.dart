import 'package:flutter/material.dart';
import 'package:building/components/app_bar.dart';

class MapPage extends StatelessWidget {
  final String userAuthId;
  const MapPage({required this.userAuthId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      ScreenAppBar("MAP"),
      Expanded(flex: 9, child: Image.asset("assets/map.jpg", fit: BoxFit.fill)),
    ]));
  }
}
