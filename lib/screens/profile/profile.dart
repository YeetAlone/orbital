import 'package:flutter/material.dart';
import '../../models/user.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;
import '../../services/authenticate/auth_service.dart';
import '../../services/authenticate/bloc/auth_bloc.dart';
import '../../services/authenticate/bloc/auth_event.dart';
import '../../services/cloud/firebase_cloud_storage.dart';

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

  @override
  Widget build(BuildContext context) {
    // another temporary stopgap until the image upload feature is implemented
    devtools.log("userId: $userId");

    return Scaffold(
        // AppBar
        backgroundColor: const Color.fromRGBO(0, 105, 92, 1),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(0, 77, 64, 1),
            elevation: 0.0,
            title: const Text("PROFILE"),
          ),
        ),
        //Main body of profile page
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
                  const SizedBox(height: 40),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(165, 214, 167, 100),
                      backgroundImage: NetworkImage(user.profilePictureURL),
                      radius: 60.0,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "  NAME",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 2.0, fontSize: 16),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                    color: const Color.fromRGBO(165, 214, 167, 65),
                    height: 54.0,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        user.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    "  DEPARTMENT",
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 2.0, fontSize: 16),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                    color: const Color.fromRGBO(165, 214, 167, 65),
                    height: 54.0,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        " ${user.department}",
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
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
            }));
  }
}


// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// const SizedBox(height:40),
// Center(
// child: CircleAvatar(backgroundColor: const Color.fromRGBO(165, 214, 167, 100),backgroundImage: NetworkImage(user.profilePictureURL),radius: 40.0,),
// ),
// const SizedBox(height:40),
// Text("  NAME",textAlign: TextAlign.left,style: TextStyle(color: Colors.white,letterSpacing: 2.0,),),
// const SizedBox(height:10.0),
// Container(
// margin:EdgeInsets.fromLTRB(20, 3, 20, 3),
// color: const Color.fromRGBO(165, 214, 167, 65),height: 54.0, width: double.infinity,
// child: Padding(
// padding: const EdgeInsets.all(15.0),
// child: Text(" ${user.firstName} ${user.lastName}",style: const TextStyle(color: Colors.white,letterSpacing: 2.0,fontSize: 16.0,),),
// ),
// ),
// const SizedBox(height:30.0),
// Text("  DEPARTMENT",style: TextStyle(color: Colors.white,letterSpacing: 2.0,),),
// const SizedBox(height:10.0),
// Container(
// margin:EdgeInsets.fromLTRB(20, 3, 20, 3),
// color: const Color.fromRGBO(165, 214, 167, 65),height: 54.0,width:double.infinity,
// child: Padding(
// padding: const EdgeInsets.all(15.0),
// child: Text(" ${user.department}",style: TextStyle(color: Colors.white,letterSpacing: 2.0,fontSize: 16.0,),),
// ),
// ),
// const SizedBox(height:70.0),
// Container(
// margin:EdgeInsets.all(20),
// decoration: const BoxDecoration(color: Color.fromRGBO(165, 214, 167, 0.6),borderRadius: BorderRadius.all(Radius.circular(40.0))),
// height:47,width:double.infinity,
// child: Row(
// children: [
// Padding(
// padding: const EdgeInsets.all(2.0),
// child: const Text(" sync with google calendar?",style: TextStyle(color: Colors.white, letterSpacing: 2.0, fontSize: 16.0,)),
// ),
//
// ],)
// ),
// const SizedBox(height:20),
// Container(
// margin:EdgeInsets.all(20),
// decoration: const BoxDecoration(color: Color.fromRGBO(165, 214, 167, 0.6),borderRadius: BorderRadius.all(Radius.circular(40.0))),
// height:47,width:double.infinity,
// child: Row(
// children: const [
// Padding(
// padding: EdgeInsets.all(2.0),
// child: Text(" sync with outlook calendar?",style: TextStyle(color: Colors.white, letterSpacing: 2.0, fontSize: 16.0,)),
// ),
//
// ],)
// ),
//
//
// ]
// )