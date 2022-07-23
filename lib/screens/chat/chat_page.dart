import 'package:building/models/user.dart';
import 'package:building/screens/chat/widgets/message_body.dart';
import 'package:building/screens/chat/widgets/profile_header.dart';
import 'package:building/screens/chat/widgets/bottom_text_box.dart';

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final AppUserData sender;
  const ChatPage({required this.sender, Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(user: widget.sender),
            Expanded(
                child: MessageBody(
              senderEmail: widget.sender.email,
            )), // wrap with Stack if required
            NewTextWidget(senderEmail: widget.sender.email),
          ],
        ),
      ),
    );
  }
}
