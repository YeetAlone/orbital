// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:building/services/cloud/cloud_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/foundation.dart' show immutable;

import '../shared/chat_constants.dart';

@immutable
abstract class Message {
  final DateTime createdAt;
  final String senderName;
  final String senderEmail;
  final String messageId;

  const Message({
    required this.createdAt,
    required this.senderName,
    required this.senderEmail,
    required this.messageId,
  });

  @override
  String toString() {
    return 'Message(createdAt: $createdAt, senderName: $senderName, senderEmail: $senderEmail, messageId: $messageId)';
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    final int messageType = json[messageTypeName];
    switch (messageType) {
      default:
        return TextMessage.fromJson(json);
    }
  }
  Map<String, dynamic> toJson();
}

class TextMessage extends Message {
  final String text;

  const TextMessage(
      {required this.text,
      required super.createdAt,
      required super.senderName,
      required super.senderEmail,
      required super.messageId});

  static TextMessage fromJson(Map<String, dynamic> json) => TextMessage(
        messageId: json[messageIdName],
        senderName: json[userName],
        senderEmail: json[userEmailName],
        text: json['text'],
        createdAt: (json[createdAtName] as Timestamp).toDate(),
      );

  @override
  Map<String, dynamic> toJson() => {
        messageIdName: messageId,
        senderName: userName,
        userName: senderName,
        messageName: text,
        createdAtName: createdAt.toUtc(),
        messageTypeName: 0,
      };
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
