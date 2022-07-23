// import 'package:building/models/chat_message.dart';
// import 'package:building/models/user.dart';
// import 'package:building/services/chat/chat_exceptions.dart';
// import 'package:building/services/cloud/firebase_cloud_storage.dart';
// import 'package:building/shared/chat_constants.dart';
// import 'package:building/shared/status_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:developer' as devtools show log;
// import '../../models/chat_user.dart';

class FirebaseChatStorage {
  static final FirebaseChatStorage _instance = FirebaseChatStorage._internal();

  FirebaseChatStorage._internal();

  factory FirebaseChatStorage() => _instance;

  final chatDb = FirebaseFirestore.instance.collection('users/chats');
  final convoDb = FirebaseFirestore.instance.collection('conversations');

  // // C
  // Future<Message> createChat(
  //     {required String senderEmail,
  //     required String text}) async {
  //   try {
  //     final time = DateTime.now();
  //     // final sender =
  //     //     await FirebaseCloudStorage().getAppUserFromEmail(senderEmail);
  //     Message message = TextMessage(
  //       senderEmail: senderEmail,
  //       messageId: '',
  //       senderName: '',
  //       text: text,
  //       createdAt: time,
  //     );
  //     await chatDb.add(message.toJson());
  //     return message;
  //   } catch (e) {
  //     devtools.log(e.toString());
  //     throw CouldNotCreateChatMessageException();
  //   }
  // }

  // // R
  // Stream<Iterable<Message>> getChatsFromSender(
  //     {required String senderEmail, required String receiverEmail}) {
  //   try {
  //     // Pagination required
  //     final db = FirebaseFirestore.instance
  //         .collection('users/$receiverEmail/chats')
  //         .where(messageIdName, isEqualTo: (senderEmail))
  //         .orderBy(lastMessageTimeName, descending: true)
  //         .limit(20);

  //     return db.snapshots().map(
  //         (event) => event.docs.map((e) => Message.fromJson(e.data())));
  //   } catch (e) {
  //     throw CouldNotGetChatMessageException();
  //   }
  // }

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

//   // C
//   Future<ChatUser> createChatUser({
//     required AppUserData sender,
//     required String receiverEmail,
//   }) async {
//     try {
//       final db = FirebaseFirestore.instance
//           .collection('users/$receiverEmail/chatUsers');
//       final time = DateTime.now();
//       ChatUser chatUser = ChatUser(
//           name: sender.userName,
//           imageUrl: sender.profilePictureURL,
//           lastMessageTime: time,
//           lastMessageText: "Say Hi!",
//           email: sender.email,
//           isRead: false);
//       await db.doc(sender.email).set(chatUser.toJson());
//       return chatUser;
//     } catch (e) {
//       throw CouldNotCreateChatUserException();
//     }
//   }

//   // R
//   Stream<Iterable<ChatUser>> getChatsFromEveryone(
//       {required String receiverEmail}) {
//     try {
//       // Pagination required
//       final db = FirebaseFirestore.instance
//           .collection('users/$receiverEmail/chatUsers')
//           .orderBy(lastMessageTimeName, descending: true)
//           .limit(20);
//       return db
//           .snapshots()
//           .map((event) => event.docs.map((e) => ChatUser.fromJson(e.data())));
//     } catch (e) {
//       throw CouldNotGetChatUserException();
//     }
//   }

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
