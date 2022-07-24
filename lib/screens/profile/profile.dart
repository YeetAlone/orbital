import 'package:building/screens/profile/widgets.dart';
import 'package:building/services/profile_update/bloc/profile_bloc.dart';
import 'package:building/shared/extensions.dart';
import 'package:building/shared/shared_data.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:developer' as devtools show log;
import '../../services/authenticate/bloc/auth_bloc.dart';
import '../../services/authenticate/bloc/auth_event.dart';
import 'package:building/components/app_bar.dart';

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
  late String location;
  List buildings = [
    ["School of Medicine", 1.29591, 103.78233, 100.65],
    ["University Hall", 1.29713, 103.77765, 51.75],
    ["COM", 1.29518, 103.77417, 66.85],
    ["Engineering", 1.29892, 103.77158, 166.96],
    ["Science", 1.29623, 103.77988, 151.06],
    ["FASS", 1.29504, 103.77161, 187.3],
    ["Biz", 1.29359, 103.77460, 87.81],
    ["YIH", 1.29846, 103.77486, 90.48],
    ["SDE", 1.29717, 103.77064, 65.32],
    ["UTown", 1.30559, 103.77305, 168.83],
    ["PGPR", 1.29088, 103.78043, 108.86],
    ["I4", 1.29462, 103.77583, 48.20],
    ["I3", 1.29245, 103.77566, 64.94],
    ["CLB", 1.29672, 103.77353, 76.16],
    ["USC", 1.29976, 103.77536, 84.98],
    ["Museum", 1.30188, 103.77269, 75.20],
    ["NUH", 1.29387, 103.78342, 193.17]
  ];

  @override
  void initState() {
    // context.read<AuthBloc>().add(const AuthEventLogOut());
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
          future: Future.value(SharedPrefs.userData),
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
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      if (state is ProfileInitial) {
                        final name =
                            state.name == "" ? user.userName : state.name;
                        final department = state.department == ""
                            ? user.department
                            : state.department;
                        final location = state.location == ""
                            ? user.location
                            : state.location;

                        return ListView(
                          children: [
                            screenAppBar("PROFILE"),
                            const SizedBox(height: 20),

                            //profile picture circular avatar
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromRGBO(165, 214, 167, 100),
                                  backgroundImage:
                                      NetworkImage(user.profilePictureURL),
                                  radius: 60.0,
                                ),
                              ),
                            ),
                            const Expanded(
                                flex: 4, child: SizedBox(height: 20)),
                            //display of name
                            Expanded(
                              flex: 1,
                              child: InfoDisplayProfile(
                                title: "  NAME",
                                info: " ${name.toTitleCase()}",
                                email: user.email,
                              ),
                            ),
                            const Expanded(
                                flex: 2, child: SizedBox(height: 20)),
                            //display of department
                            Expanded(
                              flex: 1,
                              child: InfoDisplayDepartment(
                                title: "  DEPARTMENT",
                                info: " $department",
                                email: user.email,
                              ),
                            ),
                            const Expanded(
                                flex: 2, child: SizedBox(height: 20)),

                            Expanded(
                              flex: 1,
                              child: InfoDispLocation(
                                title: "  LOCATION",
                                info: " ${location.toTitleCase()}",
                                email: user.email,
                              ),
                            ),
                            const Expanded(
                                flex: 3, child: SizedBox(height: 40)),

                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  color:
                                      const Color.fromRGBO(165, 214, 167, 65),
                                  child: TextButton(
                                      onPressed: () {
                                        context
                                            .read<AuthBloc>()
                                            .add(const AuthEventLogOut());
                                      },
                                      child: const Text("Log Out",
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                              ),
                            ),
                            const Expanded(
                                flex: 1, child: SizedBox(height: 10)),
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
