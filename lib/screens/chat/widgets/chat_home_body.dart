import 'package:building/models/chat_user.dart';
import 'package:flutter/material.dart';

import '../chat_page.dart';

// List of users shown in the main chat screen

class ChatBody extends StatelessWidget {
  final List<ChatUser> users;
  final String receiverEmail;
  const ChatBody({required this.users, required this.receiverEmail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final chatUser = users[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(
                sender: chatUser,
                receiverEmail: receiverEmail,
              ),
            )),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(chatUser.imageUrl),
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
                            chatUser.name,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            chatUser.lastMessageText,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                              fontWeight: chatUser.isRead
                                  ? FontWeight.w300
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    chatUser.lastMessageTime.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      fontWeight:
                          chatUser.isRead ? FontWeight.w300 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
