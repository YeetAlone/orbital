import 'package:building/screens/map/map.dart';
import 'package:building/screens/profile/profile.dart';
import 'package:building/screens/chat/chat.dart';
import 'package:building/screens/search/main_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class navBar extends StatefulWidget {
  late int index;
  navBar(this.index);

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  @override
  Widget build(BuildContext context) {
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
      currentIndex: widget.index,
      iconSize: 40,
      selectedItemColor: Colors.black,
      onTap: (int newIndex) {
        switch (newIndex) {
          case 0:
            Get.to(() => Profile());
            break;
          case 1:
            Get.to(() => MainSearch());
            break;
          case 2:
            Get.to(() => Map());
            break;
          case 3:
            Get.to(() => Chat());
            break;
          case 4:


        }
      },
    );
  }
}
