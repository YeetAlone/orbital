import 'package:building/components/navBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../components/availabilityDrawer.dart';
import '../../models/user.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;
import '../../services/authenticate/auth_service.dart';
import '../../services/authenticate/bloc/auth_bloc.dart';
import '../../services/authenticate/bloc/auth_event.dart';
import '../../services/cloud/firebase_cloud_storage.dart';
import 'package:building/components/appBar.dart';
import 'package:building/components/infoDisp.dart';

import '../chat/chat.dart';
import '../search/main_search.dart';

/*
todo
try to create components for the switchtiles
 */

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool switch1Value = false;
  bool switch2Value = false;
  late final FirebaseCloudStorage _userService;

  @override
  void initState() {
    _userService = FirebaseCloudStorage();
    super.initState();
  }

  String get userId => AuthService.firebase().currentUser!.userID;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // another temporary stopgap until the image upload feature is implemented
    devtools.log("userId: $userId");

    return Scaffold(
        key: _key,
        backgroundColor: const Color.fromRGBO(0, 105, 92, 1),
        body: StreamBuilder<Iterable<AppUserData>>(
            stream: _userService.getAppUser(userId),
            builder: (context, snapshot) {
              devtools.log(userId);
              AppUserData user = AppUserData.empty();
              if (snapshot.data != null) {
                user = snapshot.data!.first;
                _userService.updateAppUser(
                  docID: user.docID,
                  profilePictureUrl:
                      "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                );
              } else {
                devtools.log(snapshot.data.toString());
              }
              return ListView(
                children: [
                  appBar("PROFILE"),
                  const SizedBox(height: 40),

                  //profile picture circular avatar
                  Center(
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(165, 214, 167, 100),
                      backgroundImage: NetworkImage(user.profilePictureURL),
                      radius: 60.0,
                    ),
                  ),
                  const SizedBox(height: 50),
                  //display of name
                  infoDisp("  NAME", " ${user.userName}"),
                  const SizedBox(height: 30.0),

                  //display of department
                  infoDisp("  DEPARTMENT", " ${user.department}"),
                  const SizedBox(height: 50),
                  Container(
                    color: const Color.fromRGBO(46, 136, 113, 1),
                    child: SwitchListTile(
                      hoverColor: const Color.fromRGBO(46, 136, 113, 1),
                      title: const Text('Sync with Google Calendar?',
                          style: TextStyle(color: Colors.white)),
                      value: switch1Value,
                      onChanged: (bool value) {
                        setState(() {
                          switch1Value = value;
                        });
                      },
                      activeColor: const Color.fromRGBO(165, 214, 167, 65),
                      activeTrackColor: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: const Color.fromRGBO(46, 136, 113, 1),
                    child: SwitchListTile(
                      hoverColor: const Color.fromRGBO(46, 136, 113, 1),
                      title: const Text('Sync with Google Calendar?',
                          style: TextStyle(color: Colors.white)),
                      value: switch2Value,
                      onChanged: (bool value) {
                        setState(() {
                          switch2Value = value;
                        });
                      },
                      activeColor: const Color.fromRGBO(165, 214, 167, 65),
                      activeTrackColor: Colors.black,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(const AuthEventLogOut());
                      },
                      child: const Text("Log Out")),
                ],
              );
            }),
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
          currentIndex: 0,
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
                _key.currentState!.openEndDrawer();
            }
          },
        ),
        endDrawer: AppDrawer());
  }
}
