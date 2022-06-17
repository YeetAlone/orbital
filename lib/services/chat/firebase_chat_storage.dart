import 'package:building/firebase_options.dart';
import 'package:building/screens/chat/chat_list.dart';
import 'package:building/services/cloud/cloud_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:building/models/chat_message.dart';
import 'package:building/models/chat_user.dart';
import 'package:building/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../cloud/firebase_cloud_storage.dart';

class FirebaseChatStorage {
  static final FirebaseChatStorage _instance = FirebaseChatStorage._internal();

  FirebaseChatStorage._internal();

  factory FirebaseChatStorage() => _instance;
  final chatUsers = FirebaseFirestore.instance.collection('chatUsers');

  Future<ChatUser> createChatList({required AppUserData data}) async {
    // TODO: implement createChatList

    final user = await chatUsers.add({
      "fullName": data.userName,
      "imageURL": data.profilePictureURL,
      "userId": data.userID,
      "chatList": [],
    });

    final fetchedUser = await user.get();

    return ChatUser(
        name: data.userName,
        messageText: "",
        imageUrl: data.profilePictureURL,
        time: "",
        chatId: data.docID,
        userId: data.userID,
        otherUsers: []);
  }

  Future<void> updateChatList(
      {required ChatUser currentUser, required ChatUser otherUser}) async {
    await chatUsers.doc(currentUser.chatId).update({
      "chatList": FieldValue.arrayUnion([otherUser.userId])
    });
    await chatUsers.doc(otherUser.chatId).update({
      "chatList": FieldValue.arrayUnion([currentUser.userId])
    });
  }

  Future<void> createSingleChat(
      {required ChatUser user, required ChatUser data}) {
    // TODO: implement createSingleChat
    throw UnimplementedError();
  }

  Future<void> updateSingleChat(
      {required ChatUser user, required ChatMessage message}) {
    // TODO: implement updateSingleChat
    throw UnimplementedError();
  }
}
