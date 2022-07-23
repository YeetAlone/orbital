// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:building/models/chat_message.dart';
import 'package:building/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// get the latest conversation to view
class ChatConversation {
  String chatId;
  AppUserData userOne;
  AppUserData userTwo;
  Message message;

  ChatConversation({
    required this.chatId,
    required this.userOne,
    required this.userTwo,
    required this.message,
  });

  ChatConversation copyWith({
    String? chatId,
    AppUserData? userOne,
    AppUserData? userTwo,
    Message? message,
  }) {
    return ChatConversation(
      chatId: chatId ?? this.chatId,
      userOne: userOne ?? this.userOne,
      userTwo: userTwo ?? this.userTwo,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'userOne': userOne.toJson(),
      'userTwo': userTwo.toJson(),
      'message': message.toJson(),
    };
  }

  factory ChatConversation.fromMap(Map<String, dynamic> map) {
    return ChatConversation(
      chatId: map['chatId'] as String,
      userOne: AppUserData.fromJson(map['userOne'] as Map<String, dynamic>),
      userTwo: AppUserData.fromJson(map['userTwo'] as Map<String, dynamic>),
      message: Message.fromJson(map['message'] as Map<String, dynamic>),
    );
  }

  ChatConversation.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : chatId = snapshot.data()!['chatID'],
        userOne = AppUserData.fromDocumentSnapshot(snapshot.data()!['userOne']),
        userTwo = AppUserData.fromDocumentSnapshot(snapshot.data()!['userTwo']),
        message = TextMessage.fromDocumentSnapshot(snapshot.data()!['message']);

  String toJson() => json.encode(toMap());

  factory ChatConversation.fromJson(String source) =>
      ChatConversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatConversation(chatId: $chatId\n, userOne: $userOne\n, userTwo: $userTwo\n, message: $message\n)';

  @override
  bool operator ==(covariant ChatConversation other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId;
  }

  @override
  int get hashCode => chatId.hashCode;
}
