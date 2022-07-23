import 'package:building/models/chat_convo.dart';
import 'package:building/models/chat_message.dart';
import 'package:building/shared/shared_data.dart';
import 'package:flutter/material.dart';

import '../chat_page.dart';

// List of users shown in the main chat screen

class ChatBody extends StatelessWidget {
  final List<ChatConversation> users;
  const ChatBody({required this.users, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const isRead = true;
    final receiverEmail = SharedPrefs.userEmail;
    return ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final chatUser = users[index];
          final sender = chatUser.userOne.email == receiverEmail
              ? chatUser.userTwo
              : chatUser.userOne;
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(
                sender: sender,
              ),
            )),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(sender.profilePictureURL),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sender.userName,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            (chatUser.message as TextMessage).text,
                            style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                              fontWeight:
                                  isRead ? FontWeight.w300 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    chatUser.message.createdAt.toString(),
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      fontWeight: isRead ? FontWeight.w300 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
