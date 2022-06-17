import 'package:building/models/user.dart';
import 'package:building/services/cloud/cloud_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as devtools show log;

import 'cloud_constants.dart';

class FirebaseCloudStorage {
  static final FirebaseCloudStorage _instance =
      FirebaseCloudStorage._internal();
  FirebaseCloudStorage._internal();
  factory FirebaseCloudStorage() => _instance;

  final users = FirebaseFirestore.instance.collection('userData');

  Stream<Iterable<AppUserData>> getAppUser(String userId) {
    devtools.log('getAppUser: $userId');
    try {
      return users.where(userIDName, isEqualTo: userId).snapshots().map(
          (event) => event.docs.map((doc) => AppUserData.fromSnapshot(doc)));
    } catch (e) {
      throw CouldNotGetAppUserException();
    }
  }

  Future<AppUserData> getDocAppUser(String docId) {
    return users.doc(docId).get().then((doc) {
      if (doc.exists) {
        return AppUserData.fromDocumentSnapshot(doc);
      } else {
        throw CouldNotGetAppUserException();
      }
    });
  }

  Future<void> updateAppUser({
    required String docID,
    String? fullName,
    String? email,
    String? department,
    String? profilePictureUrl,
  }) async {
    try {
      if (fullName != null) {
        users.doc(docID).update({userFullName: fullName});
      }
      if (email != null) {
        users.doc(docID).update({userEmailName: email});
      }
      if (department != null) {
        users.doc(docID).update({departmentName: department});
      }
      if (profilePictureUrl != null) {
        users.doc(docID).update({userProfileURLName: profilePictureUrl});
      }
      // return AppUserData(
      //   userID: userData.userID,
      //   docID: docID,
      //   userName: fullName ?? userData.userName,
      //   profilePictureURL: profilePictureUrl ?? userData.profilePictureURL,
      //   department: department ?? userData.department,
      //   email: email ?? userData.email,
      // );
    } catch (e) {
      throw CouldNotUpdateAppUserException();
    }
  }

  Future<AppUserData> createNewAppUser({
    required String userId,
    String? fullName,
    String? email,
    String? department,
    String? profilePictureUrl,
  }) async {
    final user = await users.add(
      {
        userIDName: userId,
        userFullName: fullName ?? "",
        userEmailName: email ?? "",
        departmentName: department ?? "",
        userProfileURLName: profilePictureUrl ?? "",
      },
    );
    final fetchedUser = await user.get();
    // devtools.log(fetchedUser.id);
    return AppUserData(
        email: email ?? "",
        docID: fetchedUser.id,
        userName: fullName ?? "",
        userID: userId,
        department: department ?? "",
        profilePictureURL: profilePictureUrl ?? "");
  }

  // test this, if fromJson does not work write a fromSnapshot method
  Stream<Iterable<AppUserData>> allUsers() => users.snapshots().map((event) =>
      event.docs.map((snapshot) => AppUserData.fromJson(snapshot.data())));
}
