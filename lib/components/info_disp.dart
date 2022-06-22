// a widget that takes in a string and displays the string as information
// This widget is made for the profile page to display information

import 'package:building/shared/constants.dart';
import 'package:flutter/material.dart';

class InfoDisplay extends StatefulWidget {
  final String title;
  final String info;

  const InfoDisplay({required this.title, required this.info, Key? key})
      : super(key: key);

  @override
  State<InfoDisplay> createState() => _InfoDisplayState();
}

class _InfoDisplayState extends State<InfoDisplay> {
  Widget infoDisp(String title, String info) {
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
                  info,
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
                    onPressed: () {},
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
    return infoDisp(widget.title, widget.info);
  }
}
