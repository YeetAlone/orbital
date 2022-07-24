import 'package:building/models/chat_message.dart';
import 'package:building/screens/chat/widgets/single_text.dart';
import 'package:building/services/chat/firebase_chat_storage.dart';
import 'package:building/shared/shared_data.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

// List of messages shown when talking to a user

class MessageBody extends StatelessWidget {
  final String chatId;
  const MessageBody({required this.chatId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String receiver = SharedPrefs.userEmail;
    return Stack(
      children: [
        SingleChildScrollView(
          child: StreamBuilder<Iterable<TextMessage>>(
              // stream: FirebaseChatStorage().getChatsFromSender(
              //     senderEmail: senderEmail, receiverEmail: receiverEmail),
              stream: FirebaseChatStorage().getChatsFromSender(chatId: chatId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  devtools.log(snapshot.error.toString());
                  throw Exception();
                }
                final chatMessages = snapshot.data;
                return chatMessages == null || chatMessages.length == 1
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
                          if (index == 0) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          final message = chatMessages.elementAt(index);

                          return SingleText(
                              text: message.text,
                              isMe: message.sender.email == receiver);
                          // message.userId ==  FirebaseChatAPI().currentUser.userId);
                        });
              }),
        )
      ],
    );
  }
}
