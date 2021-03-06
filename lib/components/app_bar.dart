// A widget that takes in a string and displays the application bar on every screen with the string as the title

import 'package:flutter/material.dart';

Widget screenAppBar(String s) => PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 77, 64, 1),
        elevation: 0.0,
        title: Text(s),
      ),
    );
