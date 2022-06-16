import 'package:building/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:building/screens/search/main_search.dart';
import 'package:building/screens/chat/chat.dart';
import 'package:building/components/appBar.dart';

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
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        iconSize: 40,
        selectedItemColor: Colors.black,
        onTap: (int index) {
          setState(
            () => _selectedIndex = index,
          );
          if (_selectedIndex == 4) {}
          pageIndex = _selectedIndex;
        },
      ),
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
