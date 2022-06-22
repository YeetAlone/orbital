import 'package:building/models/chat_message.dart';
import 'package:building/screens/chat/widgets/single_text.dart';
import 'package:building/services/chat/firebase_chat_storage.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

// List of messages shown when talking to a user

class MessageBody extends StatelessWidget {
  final String senderEmail;
  final String receiverEmail;
  const MessageBody(
      {required this.senderEmail, required this.receiverEmail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<Iterable<ChatMessage>>(
            stream: FirebaseChatStorage().getChatsFromSender(
                senderEmail: senderEmail, receiverEmail: receiverEmail),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                devtools.log(snapshot.error.toString());
                throw Exception();
              }
              final chatMessages = snapshot.data;
              return chatMessages == null || chatMessages.isEmpty
                  ? const Center(
                      child: Text(
                        "Say Hi",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListView.builder(
                      itemCount: chatMessages.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final message = chatMessages.elementAt(index);

                        return SingleText(
                            text: message.message,
                            isMe: message.senderEmail == receiverEmail);
                        // message.userId ==  FirebaseChatAPI().currentUser.userId);
                      });
            })
      ],
    );
  }
}
