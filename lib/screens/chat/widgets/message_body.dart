import 'package:building/models/chat_message.dart';
import 'package:building/screens/chat/widgets/single_text.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

// List of messages shown when talking to a user

class MessageBody extends StatelessWidget {
  final String senderEmail;
  const MessageBody({required this.senderEmail, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<Iterable<TextMessage>>(
            // stream: FirebaseChatStorage().getChatsFromSender(
            //     senderEmail: senderEmail, receiverEmail: receiverEmail),
            stream: null,
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

                        return SingleText(text: message.text, isMe: false);
                        // message.userId ==  FirebaseChatAPI().currentUser.userId);
                      });
            })
      ],
    );
  }
}
