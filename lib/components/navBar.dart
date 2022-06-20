import 'package:building/shared/nav_bar_constants.dart';
import 'package:building/services/navigation/bloc/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:building/components/availabilityDrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/nav_bar_constants.dart';
// import 'dart:developer' as devtools show log;

class NavBar extends StatefulWidget {
  final int index;
  const NavBar({required this.index, Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var availabilityKey = GlobalKey<_NavBarState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
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
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavBarItem.profile);
                break;
              case 1:
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavBarItem.search);
                break;
              case 2:
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavBarItem.map);
                break;
              case 3:
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavBarItem.chat);
                break;
              case 4:
                const AvailabilityDrawer();
            }
          },
        );
      },
    );
  }
}
