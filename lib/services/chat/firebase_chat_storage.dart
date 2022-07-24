// import 'package:building/models/chat_message.dart';
// import 'package:building/models/user.dart';
// import 'package:building/services/chat/chat_exceptions.dart';
// import 'package:building/services/cloud/firebase_cloud_storage.dart';
// import 'package:building/shared/chat_constants.dart';
// import 'package:building/shared/status_constants.dart';
import 'dart:async';

import 'package:building/models/chat_convo.dart';
import 'package:building/models/chat_message.dart';
import 'package:building/models/user.dart';
import 'package:building/shared/chat_constants.dart';
import 'package:building/shared/shared_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'chat_exceptions.dart';
import 'dart:developer' as devtools show log;
// import '../../models/chat_user.dart';

class FirebaseChatStorage {
  static final FirebaseChatStorage _instance = FirebaseChatStorage._internal();

  FirebaseChatStorage._internal();

  factory FirebaseChatStorage() => _instance;

  final chatDb = FirebaseFirestore.instance.collection('chats');
  // stores a list of conversations for a user
  final convoDb = FirebaseFirestore.instance.collection('conversation_list');
  // stores the latest conversation to be shown in the chat screen
  final latestConvoDb = FirebaseFirestore.instance.collection('latest_convo');

  final receiver = SharedPrefs.userData;
  static const uuid = Uuid();

  // C
  Future<TextMessage> createChat(
      {required AppUserData sender,
      required String chatId,
      required String text}) async {
    try {
      final time = DateTime.now();
      // final sender =
      //     await FirebaseCloudStorage().getAppUserFromEmail(senderEmail);
      final message = TextMessage(
        sender: sender,
        text: text,
        createdAt: time,
      );
      await chatDb.doc(chatId).collection('texts').add(message.toJson());
      await latestConvoDb.doc(chatId).update({'message': message.toJson()});
      return message;
    } catch (e) {
      devtools.log(e.toString());
      throw CouldNotCreateChatMessageException();
    }
  }

  // R
  Stream<Iterable<TextMessage>> getChatsFromSender({required String chatId}) {
    try {
      // Pagination required
      return chatDb
          .doc(chatId)
          .collection('texts')
          .orderBy(createdAtName, descending: false)
          .limit(20)
          .snapshots()
          .map((event) => event.docs
              .map((snapshot) => TextMessage.fromJson(snapshot.data())));
    } catch (e) {
      throw CouldNotGetChatMessageException();
    }
  }

  // // U
  // Future<void> updateChat(
  //     {required String receiverEmail,
  //     required Message message,
  //     String? text}) async {
  //   try {
  //     final db =
  //         FirebaseFirestore.instance.collection('users/$receiverEmail/chats');
  //     if (text != null) {
  //       await db
  //           .doc("${message.messageId}_${message.createdAt.toString()}")
  //           .update({messageName: text});
  //     }
  //   } catch (e) {
  //     throw CouldNotUpdateChatMessageException();
  //   }
  // }

//   // D
//   Future<void> deleteChat(
//       {required String receiverEmail, required Message message}) async {
//     try {
//       FirebaseFirestore.instance
//           .collection('users/$receiverEmail/chats')
//           .doc("${message.messageId}_${message.createdAt.toString()}")
//           .delete();
//     } catch (e) {
//       throw CouldNotDeleteChatMessageException();
//     }
//   }

  // C
  Future<ChatConversation> createConversation({
    required AppUserData sender,
  }) async {
    try {
      final time = DateTime.now();
      final text =
          TextMessage(text: "Say Hi!", createdAt: time, sender: sender);
      final id = uuid.v4();
      final conversation = ChatConversation(
          chatId: id, userOne: sender, userTwo: receiver, message: text);

      // add the conversation to the list of conversations for the user - this works
      await latestConvoDb.doc(id).set(conversation.toMap());

      // create/update conversation lists for both users - this works
      await convoDb.doc(receiver.email).set({
        'convo': FieldValue.arrayUnion([id])
      }, SetOptions(merge: true));
      await convoDb.doc(sender.email).set({
        'convo': FieldValue.arrayUnion([id])
      }, SetOptions(merge: true));

      // add the message to the chat db for the user
      await chatDb.doc(id).collection('texts').add(text.toJson());
      return conversation;
    } on CouldNotCreateChatMessageException catch (e) {
      devtools.log(e.toString());
      throw CouldNotCreateConversationException();
    }
  }

  // R
  Future<List<ChatConversation>> getChatsFromEveryone() async {
    try {
      // Pagination required
      final convoList = await convoDb
          .doc(receiver.email)
          .get()
          .then((value) => value.exists ? value['convo'] as List<dynamic> : []);

      final conversations = <ChatConversation>[];
      devtools.log(convoList.toString());
      for (final String id in convoList) {
        // Null is not a subtype of type String - latestConvoDb is empty
        final conversation = await latestConvoDb.doc(id).get();
        // devtools.log(conversation.data().toString());

        conversations.add(ChatConversation.fromDocumentSnapshot(conversation));
        // conversations.add(ChatConversation.fromMap(conversation.data()!));
      }
      // devtools.log("Conversation List: $conversations");
      return conversations;
    } catch (e) {
      devtools.log(e.toString());
      // throw CouldNotGetChatUserException();
      rethrow;
    }
  }

//   // U
//   Future<void> updateChatUser(
//       {required String receiverEmail,
//       required Message message,
//       String? text,
//       bool? isRead}) async {
//     try {
//       final db = FirebaseFirestore.instance
//           .collection('users/$receiverEmail/chatUsers');

//       // a text has been read/set to unread
//       if (isRead != null) {
//         await db
//             .doc(message.messageId)
//             .update({isReadName: isRead ? "1" : "0"});
//       }
//       // there is a new text
//       if (text != null && text != message.message) {
//         await db.doc(message.messageId).update({
//           lastMessageTimeName: message.createdAt,
//           messageName: text,
//           isReadName: "0",
//         });
//       }
//     } catch (e) {
//       throw CouldNotUpdateChatUserException();
//     }
//   }

//   // D
//   Future<void> deleteChatUser(
//       {required String senderEmail, required String receiverEmail}) async {
//     try {
//       FirebaseFirestore.instance
//           .collection('users/$receiverEmail/chatUsers')
//           .doc(senderEmail)
//           .delete();
//     } catch (e) {
//       throw CouldNotDeleteChatUserException();
//     }
//   }
}
