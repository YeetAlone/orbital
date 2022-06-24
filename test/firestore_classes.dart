import 'package:building/services/cloud/cloud_exceptions.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter/foundation.dart' show immutable;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

const departmentName = 'department';
const userFullName = 'user_name';
const userIDName = 'user_id';
const userEmailName = 'user_email';
const userProfileURLName = 'user_profile_url';
const gpsLocation = 'location';
const userStatus = 'user_status';

@immutable
class AppUserData {
  final String email;
  // final String firstName;
  // final String lastName;
  final String userName;
  final String userID;
  final String department;
  final String profilePictureURL;
  final String status;
  // final String docID;

  const AppUserData({
    required this.email,
    required this.userName,
    // required this.firstName,
    // required this.lastName,
    required this.userID,
    // required this.docID,
    required this.department,
    required this.profilePictureURL,
    required this.status,
  });

  @override
  bool operator ==(covariant other) =>
      other is AppUserData &&
      other.runtimeType == runtimeType &&
      other.email == email &&
      other.userID == userID &&
      other.department == department &&
      other.status == status &&
      other.userName == userName;

  @override
  int get hashCode => userID.hashCode;

  factory AppUserData.fromJson(Map<String, dynamic> parsedJson) {
    return AppUserData(
      email: parsedJson[userEmailName] ?? '',
      // firstName: parsedJson[userFirstName] ?? '',
      // lastName: parsedJson[userLastName] ?? '',
      userName: parsedJson[userFullName] ?? '',
      userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
      department: parsedJson[departmentName] ?? '',
      profilePictureURL: parsedJson[userProfileURLName] ?? '',
      status: (parsedJson[userStatus]),
    );
    // docID: parsedJson[docIDName] ?? '');
  }
  AppUserData.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : userID = snapshot.data()![userIDName],
        email = snapshot.data()![userEmailName],
        // firstName = snapshot.data()[userFirstName],
        // lastName = snapshot.data()[userLastName],
        userName = snapshot.data()![userFullName],
        department = snapshot.data()![departmentName],
        profilePictureURL = snapshot.data()![userProfileURLName],
        status = (snapshot.data()![userStatus]);
}

class FakeCloudStorage {
  static const userCollection = 'users';

  static final FakeCloudStorage _instance = FakeCloudStorage._internal();
  FakeCloudStorage._internal();
  factory FakeCloudStorage() => _instance;

  static final db = FakeFirebaseFirestore();
  final users = db.collection(userCollection);

  Future<AppUserData> createNewAppUser({
    required String userAuthId,
    required String fullName,
    required String email,
    required String department,
    String? profilePictureUrl,
  }) async {
    try {
      await users.doc(email).set(
        {
          userIDName: userAuthId,
          userFullName: fullName,
          userEmailName: email,
          departmentName: department,
          userProfileURLName: profilePictureUrl ?? "",
          userStatus: 'incognito',
          // gpsLocation: null,
        },
      );
      // devtools.log(fetchedUser.id);
      return AppUserData(
          email: email,
          userName: fullName,
          userID: userAuthId,
          department: department,
          status: "incognito",
          profilePictureURL: profilePictureUrl ?? "");
    } catch (e) {
      throw CouldNotCreateAppUserException();
    }
  }

  Future<void> updateAppUser({
    String? fullName,
    required String email,
    String? department,
    String? profilePictureUrl,
    String? status,
  }) async {
    try {
      final doc = await users.doc(email).get();
      if (!doc.exists) {
        throw Exception();
      }

      if (fullName != null) {
        users.doc(email).update({userFullName: fullName});
      }
      if (department != null) {
        users.doc(email).update({departmentName: department});
      }
      if (profilePictureUrl != null) {
        users.doc(email).update({userProfileURLName: profilePictureUrl});
      }
      if (status != null) {
        if (status != "incognito" &&
            status != "busy" &&
            status != "available") {
          throw Exception();
        }
        users.doc(email).update({userStatus: status});
      }
    } catch (e) {
      throw CouldNotUpdateAppUserException();
    }
  }

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

  Stream<Iterable<AppUserData>> allUsers() => users.snapshots().map((event) =>
      event.docs.map((snapshot) => AppUserData.fromJson(snapshot.data())));
}

class NoDocumentException implements Exception {}
 
// await db.collection(userCollection).doc("dummy@email.com").set({
//       userFullName: 'dummy 1',
//       userIDName: '10',
//       departmentName: 'A',
//       userProfileURLName:
//           'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
//       userStatus: "incognito",
//     });

//     await db.collection(userCollection).doc("foo@bar.com").set({
//       userFullName: 'dummy 2',
//       userIDName: '2',
//       departmentName: 'B',
//       userProfileURLName:
//           'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
//       userStatus: "busy",
//     });

    // await db.collection(userCollection).doc("bul@ba.saur").set({
    //   userFullName: "Bulbasaur",
    //   userIDName: '1',
    //   departmentName: 'Grass',
    //   userProfileURLName:
    //       'https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png',
    //   userStatus: 'available',
    // });

    // await db.collection(userCollection).doc("sq@uir.tle").set({
    //   userFullName: "Squirtle",
    //   userIDName: '7',
    //   departmentName: 'Water',
    //   userProfileURLName:
    //       'https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png',
    //   userStatus: 'available',
    // });