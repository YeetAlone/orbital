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

  final users = FirebaseFirestore.instance.collection('users');

  Future<AppUserData> getAppUserFromId(String userAuthId) async {
    devtools.log('getAppUser: $userAuthId');
    try {
      return await users.where(userIDName, isEqualTo: userAuthId).get().then(
          (event) => event.docs
              .map((doc) => AppUserData.fromDocumentSnapshot(doc))
              .elementAt(0));
    } catch (e) {
      throw CouldNotGetAppUserException();
    }
  }

  Future<String> getUserEmailFromId(String userAuthId) async {
    return await getAppUserFromId(userAuthId).then((value) => value.email);
  }

  Future<AppUserData> getAppUserFromEmail(String email) async {
    try {
      return await users.doc(email).get().then((doc) {
        if (doc.exists) {
          return AppUserData.fromDocumentSnapshot(doc);
        } else {
          throw CouldNotGetAppUserException();
        }
      });
    } catch (e) {
      throw CouldNotGetAppUserException();
    }
  }

  Future<void> updateAppUser({
    String? fullName,
    required String email,
    String? department,
    String? profilePictureUrl,
    String? status,
    String? location,
  }) async {
    try {
      final doc = await users.doc(email).get();
      if (!doc.exists) {
        throw Exception();
      }

      if (fullName != null) {
        await users.doc(email).update({userFullName: fullName});
      }
      if (department != null) {
        await users.doc(email).update({departmentName: department});
      }
      if (profilePictureUrl != null) {
        await users.doc(email).update({userProfileURLName: profilePictureUrl});
      }
      if (status != null) {
        if (status != "incognito" &&
            status != "busy" &&
            status != "available") {
          throw Exception();
        }
        await users.doc(email).update({userStatus: status});
      }
      if (location != null) {
        await users.doc(email).update({gpsLocation: location});
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
    required String userAuthId,
    required String fullName,
    required String email,
    required String department,
    String? profilePictureUrl,
  }) async {
    await users.doc(email).set(
      {
        userIDName: userAuthId,
        userFullName: fullName,
        userEmailName: email,
        departmentName: department,
        userProfileURLName: profilePictureUrl ??
            "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
        userStatus: 'incognito',
        gpsLocation: 'no building',
      },
    );
    // devtools.log(fetchedUser.id);
    return AppUserData(
        email: email,
        userName: fullName,
        userID: userAuthId,
        department: department,
        status: "incognito",
        location: "no building",
        profilePictureURL: profilePictureUrl ?? "");
  }

  // test this, if fromJson does not work write a fromSnapshot method
  Stream<Iterable<AppUserData>> allUsers() => users.snapshots().map((event) =>
      event.docs.map((snapshot) => AppUserData.fromJson(snapshot.data())));

  Stream<Iterable<AppUserData>> findUsersByAvailability(String status) =>
      users.where(userStatus, isEqualTo: status).snapshots().map((event) =>
          event.docs.map((snapshot) => AppUserData.fromJson(snapshot.data())));

  Stream<Iterable<AppUserData>> findUsersByName(String queryText) => users
      .where(userFullName, isGreaterThanOrEqualTo: '$queryText\uf8ff')
      .snapshots()
      .map((event) =>
          event.docs.map((snapshot) => AppUserData.fromJson(snapshot.data())));

  Stream<Iterable<AppUserData>> findUsersByBuilding(String building) =>
      users.where(userStatus, isEqualTo: gpsLocation).snapshots().map((event) =>
          event.docs.map((snapshot) => AppUserData.fromJson(snapshot.data())));
}
