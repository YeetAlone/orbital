import 'package:building/models/user.dart';
import 'package:building/screens/chat/chat_home_page.dart';
import 'package:building/services/cloud/firebase_cloud_storage.dart';
import 'package:building/shared/nav_bar_constants.dart';
import 'package:building/screens/map/map.dart';
import 'package:building/screens/profile/profile.dart';
import 'package:building/screens/search/main_search.dart';
import 'package:building/services/navigation/bloc/navigation_cubit.dart';
import 'package:building/shared/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

class HomeScreen extends StatefulWidget {
  //* Passing user authentication ID throughout the app

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final user = FirebaseCloudStorage()
  //     .getAppUserFromId(AuthService.firebase().currentUser!.userAuthID);
  int index = 0;
  String status = "";
  final String userAuthId = SharedPrefs.userId;
  final AppUserData user = SharedPrefs.userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return FutureBuilder<AppUserData>(
            future: Future.value(user),
            builder: (context, snapshot) {
              final user = snapshot.data ?? AppUserData.empty();
              final email = user.email;
              status = user.status;
              devtools.log(SharedPrefs.userData.toString());
              return BottomNavigationBar(
                elevation: 0,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'profile'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'search'),
                  BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat), label: 'chat'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.access_time), label: 'availability'),
                ],
                type: BottomNavigationBarType.shifting,
                currentIndex: index,
                iconSize: 40,
                selectedItemColor: Colors.black,
                onTap: (newIndex) {
                  setState(() {
                    if (newIndex != 4) {
                      index = newIndex;
                    }
                  });
                  // devtools.log(index.toString());
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
                      showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(
                            1000.0, 1000.0, 0.0, 0.0),
                        items: [
                          PopupMenuItem(
                            child: ListTile(
                              onTap: () async {
                                await updateAvailability(email, "available");
                              },
                              tileColor: status == "available"
                                  ? const Color.fromRGBO(219, 232, 219, 1)
                                  : const Color.fromRGBO(255, 255, 255, 1),
                              hoverColor:
                                  const Color.fromRGBO(213, 250, 214, 1),
                              enabled: true,
                              title: const Text(
                                'Available',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 77, 64, 1)),
                              ),
                              leading:
                                  const Icon(Icons.circle, color: Colors.green),
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              onTap: () async {
                                await updateAvailability(email, "busy");
                              },
                              tileColor: status == "busy"
                                  ? const Color.fromRGBO(219, 232, 219, 1)
                                  : const Color.fromRGBO(255, 255, 255, 1),
                              hoverColor:
                                  const Color.fromRGBO(213, 250, 214, 1),
                              enabled: true,
                              leading: const Icon(
                                Icons.circle,
                                color: Colors.red,
                              ),
                              title: const Text(
                                'Busy',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 77, 64, 1),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              tileColor: status == "incognito"
                                  ? const Color.fromRGBO(219, 232, 219, 1)
                                  : const Color.fromRGBO(255, 255, 255, 1),
                              hoverColor:
                                  const Color.fromRGBO(213, 250, 214, 1),
                              enabled: true,
                              onTap: () async {
                                await updateAvailability(email, "incognito");
                              },
                              leading: const Icon(
                                Icons.circle,
                                color: Colors.grey,
                              ),
                              title: const Text(
                                'Invisible',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 77, 64, 1),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                      break;
                  }
                },
              );
            });
      }),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state.navbarItem == NavBarItem.profile) {
            return const Profile();
          } else if (state.navbarItem == NavBarItem.search) {
            return const MainSearch();
          } else if (state.navbarItem == NavBarItem.map) {
            return const MapPage();
          } else if (state.navbarItem == NavBarItem.chat) {
            return const ChatHome();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<void> updateAvailability(String email, String newStatus) async {
    await FirebaseCloudStorage().updateAppUser(email: email, status: newStatus);
    setState(() {
      status = newStatus;
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
