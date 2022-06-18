import 'package:building/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:building/screens/search/main_search.dart';
import 'package:building/screens/chat/chat.dart';
import 'package:building/components/appBar.dart';
import 'package:building/components/navBar.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  int pageIndex = 2;

  final pages = [
    const Profile(),
    const MainSearch(),
    const MapPage(),
    const Chat(),
  ];
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar:navBar(2)
    );
  }
}

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
