// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:building/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, Timestamp;
import 'package:flutter/foundation.dart' show immutable;

import '../shared/chat_constants.dart';

@immutable
abstract class Message {
  final DateTime createdAt;
  final AppUserData sender;

  const Message({
    required this.createdAt,
    required this.sender,
  });

  @override
  String toString() {
    return 'Message(createdAt: $createdAt, senderName: $sender)';
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    final int messageType = json[messageTypeName];
    switch (messageType) {
      default:
        return TextMessage.fromJson(json);
    }
  }
  Message.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : sender = AppUserData.fromDocumentSnapshot(snapshot.data()![userName]),
        createdAt = snapshot.data()![createdAtName] as DateTime;

  Map<String, dynamic> toJson();
}

class TextMessage extends Message {
  final String text;

  const TextMessage(
      {required this.text, required super.createdAt, required super.sender});

  static TextMessage fromJson(Map<String, dynamic> json) => TextMessage(
        sender: json[userName],
        text: json[messageName],
        createdAt: (json[createdAtName] as Timestamp).toDate(),
      );

  @override
  Map<String, dynamic> toJson() => {
        userName: sender.toJson(),
        messageName: text,
        createdAtName: createdAt.toUtc(),
        messageTypeName: 0,
      };

  TextMessage.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : text = snapshot.data()![messageName],
        super(
            sender:
                AppUserData.fromDocumentSnapshot(snapshot.data()![userName]),
            createdAt: snapshot.data()![createdAtName] as DateTime);
}

// edit message functionality goes in the icebox, for now this is immutable
// @immutable
// class ChatMessage {
//   final String messageId;
//   final String imageUrl;
//   final String senderName;
//   final String message;
//   final DateTime createdAt;
//   final Status status;

//   const ChatMessage({
//     required this.messageId,
//     required this.imageUrl,
//     required this.senderName,
//     required this.message,
//     required this.createdAt,
//     required this.status,
//   });

//   static ChatMessage fromJson(Map<String, dynamic> json) => ChatMessage(
//         messageId: json[messageIdName],
//         imageUrl: json[imageUrlName],
//         senderName: json[userName],
//         message: json[messageName],
//         createdAt: (json[createdAtName] as Timestamp).toDate(),
//         status:
//             Status.values.firstWhere((e) => e.toString() == json[userStatus]),
//       );

//   Map<String, dynamic> toJson() => {
//         messageIdName: messageId,
//         imageUrlName: imageUrl,
//         userName: senderName,
//         messageName: message,
//         createdAtName: createdAt.toUtc(),
//         userStatus: status.toString(),
//       };
// }

// List<ChatMessage> get chatMessages => const [
//       ChatMessage(message: "Never gonna give you up", sender: false),
//       ChatMessage(message: "Never gonna let you down", sender: true),
//       ChatMessage(
//           message: "Never gonna run around and desert you", sender: true),
//       ChatMessage(message: "Never gonna make you cry", sender: false),
//       ChatMessage(message: "Never gonna say goodbye", sender: true),
//       ChatMessage(
//           message: "Never gonna tell a lie and hurt you", sender: false),
//     ];
