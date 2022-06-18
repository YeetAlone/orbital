import 'package:flutter/material.dart';
import 'package:building/components/appBar.dart';
import 'package:building/components/navBar.dart';

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
          appBar("CHAT"),
        ],
      ),
      bottomNavigationBar: navBar(3),
    );
  }
}
