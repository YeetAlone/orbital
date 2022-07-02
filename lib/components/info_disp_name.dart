// a widget that takes in a string and displays the string as information
// This widget is made for the profile page to display information

import 'package:building/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:building/shared/constants.dart';
import 'dart:developer' as devtools show log;
import '../services/cloud/firebase_cloud_storage.dart';

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
  late final FirebaseCloudStorage _userService;
  TextEditingController displayNameController = TextEditingController();

  @override
  void initState() {
    _userService = FirebaseCloudStorage();
    super.initState();
    displayNameController = TextEditingController();
  }

  void dispose() {
    displayNameController.dispose();
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
                              child: Icon(Icons.done),
                              onTap: () {
                                userFullName = displayNameController.text;
                                _userService.updateAppUser(
                                    fullName: displayNameController.text,
                                    email: email);
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
