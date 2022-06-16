//! DEPRECATED
// import 'package:building/models/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService {
//   final String? uid;
//   DatabaseService({this.uid});

//   final CollectionReference userDataCollection = FirebaseFirestore.instance.collection('userData');

//   /// Update
//   Future updateUserData(String? firstName, String? lastName, String? profilePicURL) async{
//     return await userDataCollection.doc(uid).set({
//       'firstName': firstName,
//       'lastName': lastName,
//       'profilePic': profilePicURL,
//     });
//   }

//   /// Get AppUserData
//   AppUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//     return AppUserData(
//       userID: uid,
//       firstName: snapshot.get("firstName") ?? "",
//       lastName: snapshot.get("lastName") ?? "",
//       profilePictureURL: snapshot.get('profilePic') ?? "",
//       email: "",
//     );
//   }

//   /// Building a stream - getter
//   Stream<AppUserData>get userData {
//     return userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
//   }
// }