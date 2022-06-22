import 'package:building/shared/status_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/foundation.dart' show immutable;

import '../shared/chat_constants.dart';

// edit message functionality goes in the icebox, for now this is immutable
@immutable
class ChatMessage {
  final String senderEmail;
  final String imageUrl;
  final String senderName;
  final String message;
  final DateTime createdAt;
  final Status status;

  const ChatMessage({
    required this.senderEmail,
    required this.imageUrl,
    required this.senderName,
    required this.message,
    required this.createdAt,
    required this.status,
  });

  static ChatMessage fromJson(Map<String, dynamic> json) => ChatMessage(
        senderEmail: json[senderEmailName],
        imageUrl: json[imageUrlName],
        senderName: json[userName],
        message: json[messageName],
        createdAt: (json[createdAtName] as Timestamp).toDate(),
        status:
            Status.values.firstWhere((e) => e.toString() == json[userStatus]),
      );

  Map<String, dynamic> toJson() => {
        senderEmailName: senderEmail,
        imageUrlName: imageUrl,
        userName: senderName,
        messageName: message,
        createdAtName: createdAt.toUtc(),
        userStatus: status.toString(),
      };
}

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
