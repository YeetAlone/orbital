// a widget that takes in a string and displays the string as information
// This widget is made for the profile page to display information

import 'package:building/shared/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;
import '../services/cloud/firebase_cloud_storage.dart';

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
  late final FirebaseCloudStorage _userService;

  @override
  void initState() {
    _userService = FirebaseCloudStorage();
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
                                        setState(() {
                                          departmentValue = newValue as String;
                                        });
                                        for (int i = 0; i < items.length; i++) {
                                          if (departmentValue == items[i]) {
                                            userDepartment = items[i];
                                          }
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
                              child: Icon(Icons.done),
                              onTap: () {
                                _userService.updateAppUser(
                                    department: userDepartment, email: email);
                              },
                            )
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
