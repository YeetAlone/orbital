// a widget that takes in a string and displays the string as information
// This widget is made for the profile page to display information

import 'package:building/shared/constants.dart';
import 'package:flutter/material.dart';

class infoDisp extends StatefulWidget {
  late String title;
  late String info;

  infoDisp(this.title, this.info);

  @override
  State<infoDisp> createState() => _infoDispState();
}

class _infoDispState extends State<infoDisp> {
  Widget InfoDisp(String title, String info) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.white, letterSpacing: 2.0, fontSize: 16),
      ),
      const SizedBox(height: 10.0),
      Container(
        margin: EdgeInsets.fromLTRB(20, 3, 20, 3),
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
                  info,
                  style: TextStyle(
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
                    onPressed: () {},
                    child: Icon(
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
    return InfoDisp(widget.title, widget.info);
  }
}
