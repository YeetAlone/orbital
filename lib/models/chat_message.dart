import 'package:flutter/foundation.dart' show immutable;

// edit message functionality goes in the icebox, for now this is immutable
@immutable
class ChatMessage {
  final String message;
  // true if the message is from the current user
  final bool sender;

  const ChatMessage({required this.message, required this.sender});
}

List<ChatMessage> get chatMessages => const [
      ChatMessage(message: "Never gonna give you up", sender: false),
      ChatMessage(message: "Never gonna let you down", sender: true),
      ChatMessage(
          message: "Never gonna run around and desert you", sender: true),
      ChatMessage(message: "Never gonna make you cry", sender: false),
      ChatMessage(message: "Never gonna say goodbye", sender: true),
      ChatMessage(
          message: "Never gonna tell a lie and hurt you", sender: false),
    ];
