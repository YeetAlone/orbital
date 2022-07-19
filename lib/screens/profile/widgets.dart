// a widget that takes in a string and displays the string as information
// This widget is made for the profile page to display information

import 'package:building/services/profile_update/bloc/profile_bloc.dart';
import 'package:building/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
