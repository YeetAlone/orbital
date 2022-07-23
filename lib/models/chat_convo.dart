// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:building/models/chat_message.dart';
import 'package:building/models/user.dart';

// get the latest conversation to view
class ChatConversation {
  String chatId;
  AppUserData user;
  Message message;

  ChatConversation({
    required this.chatId,
    required this.user,
    required this.message,
  });

  ChatConversation copyWith({
    String? chatId,
    AppUserData? user,
    Message? message,
  }) {
    return ChatConversation(
      chatId: chatId ?? this.chatId,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'user': user.toJson(),
      'message': message.toJson(),
    };
  }

  factory ChatConversation.fromMap(Map<String, dynamic> map) {
    return ChatConversation(
      chatId: map['chatId'] as String,
      user: AppUserData.fromJson(map['user'] as Map<String, dynamic>),
      message: Message.fromJson(map['message'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatConversation.fromJson(String source) =>
      ChatConversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatConversation(chatId: $chatId, user: $user, message: $message)';

  @override
  bool operator ==(covariant ChatConversation other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId;
  }

  @override
  int get hashCode => chatId.hashCode;
}
