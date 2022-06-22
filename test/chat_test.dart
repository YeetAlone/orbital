// import 'package:building/firebase_options.dart';
// import 'package:building/models/user.dart';
// import 'package:building/services/authenticate/firebase_auth_provider.dart';
// import 'package:building/services/cloud/cloud_constants.dart';
// import 'package:building/services/chat/firebase_chat_storage.dart';
// import 'package:building/models/chat_user.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';

// void main() {
//   FirebaseAuthProvider().initialize();

//   FirebaseChatStorage yolo = FirebaseChatStorage();

//   Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   AppUserData u1 = const AppUserData(
//       userID: '01',
//       email: "shirsho@gmail.com",
//       userName: "shirsho",
//       department: "comp science",
//       profilePictureURL: '',
//       docID: "");
//   AppUserData u2 = const AppUserData(
//       userID: '02',
//       email: "ishi@gmail.com",
//       userName: "Ishita",
//       department: "comp eng",
//       profilePictureURL: '',
//       docID: '');

//   ChatUser shirsho = yolo.createChatList(data: u1) as ChatUser;

//   ChatUser ishita = yolo.createChatList(data: u2) as ChatUser;

//   yolo.updateChatList(otherUser: ishita, currentUser: shirsho);
// }
