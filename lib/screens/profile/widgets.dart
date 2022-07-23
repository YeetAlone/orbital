// a widget that takes in a string and displays the string as information
// This widget is made for the profile page to display information

import 'package:building/services/profile_update/bloc/profile_bloc.dart';
import 'package:building/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as devtools show log;

class InfoDisplayProfile extends StatefulWidget {
  final String title;
  final String info;
  final String email;

  const InfoDisplayProfile(
      {required this.title, required this.email, required this.info, Key? key})
      : super(key: key);

  @override
  State<InfoDisplayProfile> createState() => _InfoDisplayProfileState();
}

class _InfoDisplayProfileState extends State<InfoDisplayProfile> {
  TextEditingController displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayNameController = TextEditingController();
    displayNameController.text = widget.info;
  }

  @override
  void dispose() {
    displayNameController.dispose();
    super.dispose();
  }

  Widget infoDisp(String title, String info, String email) {
    String userFullName = info;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
            color: Colors.white, letterSpacing: 2.0, fontSize: 16),
      ),
      const SizedBox(height: 10.0),
      Container(
        margin: const EdgeInsets.fromLTRB(20, 3, 20, 3),
        color: const Color.fromRGBO(165, 214, 167, 65),
        height: 54.0,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  userFullName,
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: editButtonStyle,
                    onPressed: () async {
                      showMenu(
                          items: [
                            PopupMenuItem(
                                child: TextFormField(
                              controller: displayNameController,
                              decoration: textInputDecoration.copyWith(
                                hintText: "Enter new name",
                              ),
                            )),
                            PopupMenuItem(
                              child: const Icon(Icons.done),
                              onTap: () {
                                if (displayNameController.text.isNotEmpty) {
                                  context.read<ProfileBloc>().add(
                                      UpdateNameEvent(
                                          displayNameController.text
                                              .trim()
                                              .toLowerCase(),
                                          email));
                                }
                              },
                            )
                          ],
                          position: const RelativeRect.fromLTRB(
                              100.0, 300.0, 500.0, 700.0),
                          context: context);
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Color.fromRGBO(0, 77, 64, 1),
                    )))
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return infoDisp(widget.title, widget.info, widget.email);
  }
}

// a widget that takes in a string and displays the string as information
// This widget is made for the profile page to display information

class InfoDisplayDepartment extends StatefulWidget {
  final String title;
  final String info;
  final String email;

  const InfoDisplayDepartment(
      {required this.title, required this.email, required this.info, Key? key})
      : super(key: key);

  @override
  State<InfoDisplayDepartment> createState() => _InfoDisplayStateDepartment();
}

class _InfoDisplayStateDepartment extends State<InfoDisplayDepartment> {
  String departmentValue = "Select Department from menu";

  List items = [
    "Select Department from menu",
    "Computing",
    "Engineering",
    "Science",
    "Arts and Social Sciences",
    "Business",
    "Medicine"
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget infoDisp(String title, String info, String email) {
    String userDepartment = info;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
            color: Colors.white, letterSpacing: 2.0, fontSize: 16),
      ),
      const SizedBox(height: 10.0),
      Container(
        margin: const EdgeInsets.fromLTRB(20, 3, 20, 3),
        color: const Color.fromRGBO(165, 214, 167, 65),
        height: 54.0,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  userDepartment,
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: editButtonStyle,
                    onPressed: () async {
                      showMenu(
                          items: [
                            PopupMenuItem(
                              child: Container(
                                  color:
                                      const Color.fromRGBO(242, 238, 238, 69),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      hint: const Text("Department"),
                                      buttonPadding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                      dropdownDecoration: const BoxDecoration(
                                        color: Color.fromRGBO(210, 233, 227, 1),
                                      ),
                                      value: departmentValue,
                                      buttonWidth: 500,
                                      buttonHeight: 60,
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: Colors.black, size: 30),
                                      onChanged: (newValue) {
                                        if (mounted) {
                                          setState(() {
                                            departmentValue =
                                                newValue as String;
                                          });
                                        }
                                      },
                                      items: items.map((var item) {
                                        return DropdownMenuItem(
                                            value: item, child: Text(item));
                                      }).toList(),
                                    ),
                                  )),
                            ),
                            PopupMenuItem(
                                child: const Icon(Icons.done),
                                onTap: () {
                                  if (departmentValue != items[0]) {
                                    context.read<ProfileBloc>().add(
                                        UpdateDepartmentEvent(
                                            departmentValue, email));
                                  }
                                })
                          ],
                          position: const RelativeRect.fromLTRB(
                              60.0, 400.0, 500.0, 700.0),
                          context: context);
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Color.fromRGBO(0, 77, 64, 1),
                    )))
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return infoDisp(widget.title, widget.info, widget.email);
  }
}

class InfoDispLocation extends StatefulWidget {
  final String title;
  final String info;
  final String email;
  const InfoDispLocation(
      {Key? key, required this.title, required this.info, required this.email})
      : super(key: key);

  @override
  State<InfoDispLocation> createState() => _InfoDispLocationState();
}

class _InfoDispLocationState extends State<InfoDispLocation> {
  Position? _position;
  late String location;
  List buildings = [
    ["School of Medicine", 1.29591, 103.78233, 100.65],
    ["University Hall", 1.29713, 103.77765, 51.75],
    ["COM", 1.29518, 103.77417, 66.85],
    ["Engineering", 1.29892, 103.77158, 166.96],
    ["Science", 1.29623, 103.77988, 151.06],
    ["FASS", 1.29504, 103.77161, 187.3],
    ["Biz", 1.29359, 103.77460, 100.81],
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

  void _getCurrentLocation() async {
    GeolocatorAndroid.registerWith();
    await Geolocator.requestPermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    devtools.log(serviceEnabled.toString());
    if (!serviceEnabled) {}
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    devtools.log(position.toString());
    int locationPos = -1;
    for (int i = 0; i < buildings.length; i++) {
      double distanceInMeters = Geolocator.distanceBetween(position.latitude,
          position.longitude, buildings[i][1], buildings[i][2]);
      //devtools.log(buildings[i][0] + " " + distanceInMeters.toString());
      if (distanceInMeters < buildings[i][3]) {
        locationPos = i;
        //devtools.log("min is " + buildings[i][0]);
      }
    }

    setState(() {
      _position = position;
      //devtools.log(locationPos.toString());
      if (locationPos > -1) {
        location = buildings[locationPos][0];
      } else {
        location = "Not in any building currently";
      }
    });
  }

  Widget infoDisp(String title, String info, String email) {
    String userFullName = info;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
            color: Colors.white, letterSpacing: 2.0, fontSize: 16),
      ),
      const SizedBox(height: 10.0),
      Container(
        margin: const EdgeInsets.fromLTRB(20, 3, 20, 3),
        color: const Color.fromRGBO(165, 214, 167, 65),
        height: 54.0,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  userFullName,
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: editButtonStyle,
                    onPressed: () async {
                      devtools.log("buttonpressed");
                      GeolocatorAndroid.registerWith();
                      _getCurrentLocation();
                      if (_position != null) {
                        devtools.log(location);
                        context
                            .read<ProfileBloc>()
                            .add(UpdateLocationEvent(location, email));
                      }
                    },
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Color.fromRGBO(0, 77, 64, 1),
                    )))
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return infoDisp(widget.title, widget.info, widget.email);
  }
}
