import '../../models/chat_user.dart';
import 'package:flutter/material.dart';

const String imageLink =
    "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg";

List<ChatUser> get chatUsers => [
      ChatUser(
          name: "Rick Astley",
          messageText: "We're no strangers to love",
          imageUrl: imageLink,
          time: "Now"),
      ChatUser(
          name: "Person 2",
          messageText: "That's Great",
          imageUrl: imageLink,
          time: "Yesterday"),
      ChatUser(
          name: "Person 3",
          messageText: "That's greater",
          imageUrl: imageLink,
          time: "31 Mar"),
      ChatUser(
          name: "Person 4",
          messageText: "More Text",
          imageUrl: imageLink,
          time: "28 Mar"),
      ChatUser(
          name: "Person 5",
          messageText: "Even more text",
          imageUrl: imageLink,
          time: "23 Mar"),
      ChatUser(
          name: "Person 6",
          messageText: "Backend has to be done by tomorrow Ishita",
          imageUrl: imageLink,
          time: "17 Mar"),
      ChatUser(
          name: "Person 7",
          messageText: "Don't stop pulling.",
          imageUrl: imageLink,
          time: "24 Feb"),
      ChatUser(
          name: "Varun Kohli",
          messageText: "Ayushi's smile is so gentle. Sweet. Have fun guys",
          imageUrl: imageLink,
          time: "18 Feb"),
    ];

Widget getChatBox(
    {required ChatUser chatUser,
    required bool isRead,
    required Function onTap}) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
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
                    chatUser.messageText,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                      fontWeight: isRead ? FontWeight.w300 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            chatUser.time,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
              fontWeight: isRead ? FontWeight.w300 : FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
