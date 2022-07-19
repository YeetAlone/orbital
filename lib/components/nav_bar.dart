import 'package:building/shared/nav_bar_constants.dart';
import 'package:building/services/navigation/bloc/navigation_cubit.dart';
import 'package:flutter/material.dart';
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

class AvailabilityDrawer extends StatefulWidget {
  const AvailabilityDrawer({Key? key}) : super(key: key);

  @override
  State<AvailabilityDrawer> createState() => _AvailabilityDrawerState();
}

class _AvailabilityDrawerState extends State<AvailabilityDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 350,
      child: Drawer(
        child: Container(
          color: const Color.fromRGBO(213, 233, 214, 1),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: [
              const SizedBox(height: 50),
              Material(
                child: ListTile(
                  onTap: () {},
                  hoverColor: const Color.fromRGBO(213, 250, 214, 1),
                  enabled: true,
                  title: const Text(
                    'Available',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(0, 77, 64, 1)),
                  ),
                  leading: const Icon(Icons.circle, color: Colors.green),
                ),
              ),
              const SizedBox(height: 30),
              Material(
                child: ListTile(
                  onTap: () {},
                  hoverColor: const Color.fromRGBO(213, 250, 214, 1),
                  enabled: true,
                  leading: const Icon(
                    Icons.circle,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'Busy',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 77, 64, 1), fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Material(
                child: ListTile(
                  hoverColor: const Color.fromRGBO(213, 250, 214, 1),
                  enabled: true,
                  onTap: () {},
                  leading: const Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Invisible',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 77, 64, 1), fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
