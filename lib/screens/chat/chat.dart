import 'package:flutter/material.dart';
import 'package:building/components/app_bar.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          screenAppBar("CHAT"),
        ],
      ),
    );
  }
}
