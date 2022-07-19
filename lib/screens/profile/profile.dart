import 'package:building/screens/profile/widgets.dart';
import 'package:building/services/profile_update/bloc/profile_bloc.dart';
import 'package:building/shared/extensions.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:developer' as devtools show log;
import '../../services/authenticate/bloc/auth_bloc.dart';
import '../../services/authenticate/bloc/auth_event.dart';
import '../../services/cloud/firebase_cloud_storage.dart';
import 'package:building/components/app_bar.dart';

/*
todo
try to create components for the switchtiles
 */

class Profile extends StatefulWidget {
  final String userAuthId;
  const Profile({required this.userAuthId, Key? key}) : super(key: key);

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

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // another temporary stopgap until the image upload feature is implemented
    // devtools.log("userAuthId: $context.userAuthId");

    return Scaffold(
      key: _key,
      backgroundColor: const Color.fromRGBO(0, 105, 92, 1),
      body: FutureBuilder<AppUserData>(
          future: _userService.getAppUserFromId(widget.userAuthId),
          builder: (context, snapshot) {
            // devtools.log(widget.userAuthId);
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final user = snapshot.data!;

                // devtools.log(snapshot.data.toString());
                context.read<ProfileBloc>();
                return BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                  if (state is ProfileInitial) {
                    final name = state.name == "" ? user.userName : state.name;
                    final department = state.department == ""
                        ? user.department
                        : state.department;
                    return ListView(
                      children: [
                        screenAppBar("PROFILE"),
                        const SizedBox(height: 40),

                        //profile picture circular avatar
                        Center(
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromRGBO(165, 214, 167, 100),
                            backgroundImage:
                                NetworkImage(user.profilePictureURL),
                            radius: 60.0,
                          ),
                        ),
                        const SizedBox(height: 50),
                        //display of name
                        InfoDisplayProfile(
                          title: "  NAME",
                          info: " ${name.toTitleCase()}",
                          email: user.email,
                        ),
                        const SizedBox(height: 30.0),

                        //display of department
                        InfoDisplayDepartment(
                          title: "  DEPARTMENT",
                          info: " $department",
                          email: user.email,
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
                            activeColor:
                                const Color.fromRGBO(165, 214, 167, 65),
                            activeTrackColor: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: const Color.fromRGBO(46, 136, 113, 1),
                          child: SwitchListTile(
                            hoverColor: const Color.fromRGBO(46, 136, 113, 1),
                            title: const Text('Sync with Outlook Calendar?',
                                style: TextStyle(color: Colors.white)),
                            value: switch2Value,
                            onChanged: (bool value) {
                              setState(() {
                                switch2Value = value;
                              });
                            },
                            activeColor:
                                const Color.fromRGBO(165, 214, 167, 65),
                            activeTrackColor: Colors.black,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthEventLogOut());
                            },
                            child: const Text("Log Out")),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                });
            }
          }),
    );
  }
}
