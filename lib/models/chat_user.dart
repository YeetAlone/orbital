// add userID and chatID to ChatUser class
import 'package:building/shared/chat_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

class ChatUser {
  String name;
  String email;
  String imageUrl;
  String lastMessageText;
  DateTime lastMessageTime;
  final bool isRead;

  ChatUser({
    required this.name,
    required this.imageUrl,
    required this.lastMessageTime,
    required this.email,
    this.lastMessageText = "",
    this.isRead = false,
  });

  ChatUser copyWith({
    String? name,
    String? urlAvatar,
    DateTime? lastMessageTime,
    String? lastMessageText,
    bool? isRead,
  }) =>
      ChatUser(
        email: email,
        name: name ?? this.name,
        imageUrl: urlAvatar ?? imageUrl,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        lastMessageText: lastMessageText ?? this.lastMessageText,
        isRead: isRead ?? this.isRead,
      );

  static ChatUser fromJson(Map<String, dynamic> json) => ChatUser(
        email: json[senderEmailName],
        name: json[userName],
        imageUrl: json[imageUrlName],
        lastMessageTime: (json[lastMessageTimeName] as Timestamp).toDate(),
        lastMessageText: json[lastTextName],
        isRead: (json[isReadName] == '0' ? false : true),
      );

  Map<String, dynamic> toJson() => {
        senderEmailName: email,
        userName: name,
        imageUrlName: imageUrl,
        lastMessageTimeName: lastMessageTime.toUtc(),
        lastTextName: lastMessageText,
        isReadName: isRead ? '1' : '0',
      };
}
