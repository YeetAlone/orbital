import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../models/user.dart';
import 'package:building/components/appBar.dart';
import 'package:building/components/infoDisp.dart';

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
  AppUserData user = AppUserData(
      email: "Dummy@gmail.com",
      firstName: "Dummy",
      lastName: "Dummy",
      userID: "Dummy",
      department: "Dummy",
      profilePictureURL:
          "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 105, 92, 1),
        body: ListView(
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
            infoDisp("  NAME", " ${user.firstName} ${user.lastName}"),
            const SizedBox(height: 30.0),

            //display of department
            infoDisp("  DEPARTMENT", " ${user.department}"),
            SizedBox(height: 50),

            Container(
              color: Color.fromRGBO(46, 136, 113, 1),
              child: SwitchListTile(
                hoverColor: Color.fromRGBO(46, 136, 113, 1),
                title: Text("Sync with Google Calendar?",
                    style: TextStyle(color: Colors.white)),
                value: switch1Value,
                onChanged: (bool value) {
                  setState(() {
                    switch1Value = value;
                  });
                },
                activeColor: Color.fromRGBO(165, 214, 167, 65),
                activeTrackColor: Colors.black,
              ),
            ),

            SizedBox(height: 10),

            Container(
              color: Color.fromRGBO(46, 136, 113, 1),
              child: SwitchListTile(
                hoverColor: Color.fromRGBO(46, 136, 113, 1),
                title: Text("Sync with Google Calendar?",
                    style: TextStyle(color: Colors.white)),
                value: switch2Value,
                onChanged: (bool value) {
                  setState(() {
                    switch2Value = value;
                  });
                },
                activeColor: Color.fromRGBO(165, 214, 167, 65),
                activeTrackColor: Colors.black,
              ),
            ),
          ],
        ));
  }
}
