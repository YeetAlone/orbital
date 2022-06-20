import 'package:flutter/material.dart';
import 'package:building/components/appBar.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      appBar("MAP"),
      Expanded(flex: 9, child: Image.asset("assets/map.jpg", fit: BoxFit.fill)),
    ]));
  }
}
