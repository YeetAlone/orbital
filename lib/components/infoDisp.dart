// a widget that takes in a string and displays the string as information
// This widget is made for the profile page to display information

import 'package:flutter/material.dart';

Widget infoDisp(String title, String info) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            info,
            style: const TextStyle(
              color: Colors.white,
              letterSpacing: 2.0,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    ]);
