//this is the custom buttons for the different search types

import 'package:flutter/material.dart';
import '../../shared/constants.dart';

class SearchMethodButton extends StatelessWidget {
  late String title;
  late String iconURL;
  List bg;

  var respond;

  SearchMethodButton(this.title, this.iconURL, this.bg, this.respond());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        respond;
      },
      style: searchButtonStyle.copyWith(
          backgroundColor: MaterialStateProperty.all(
              Color.fromRGBO(bg[0], bg[1], bg[2], 1))),
      label: Text(title,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(0, 105, 92, 1), fontSize: 24)),
      icon: ImageIcon(AssetImage(iconURL),
          color: const Color.fromRGBO(0, 77, 64, 1), size: 40),
    );
  }
}
