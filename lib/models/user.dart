import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../services/cloud/cloud_constants.dart';

class AppUser {
  String userAuthID;

  AppUser({required this.userAuthID});

  factory AppUser.fromFirebaseUser(User user) => AppUser(userAuthID: user.uid);

  @override
  String toString() {
    return "AppUser(userID: $userAuthID)";
  }
}

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

  // String fullName() => '$firstName $lastName';
  @override
  String toString() {
    return "AppUserData(userID: $userID, userName: $userName, department: $department \n email: $email)";
  }

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

  factory AppUserData.empty() {
    return const AppUserData(
      email: 'dummy email',
      userName: 'dummy dummy',
      userID: 'userID',
      department: 'dept',
      profilePictureURL:
          'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
      status: "incognito",
    );
    // docID: 'docID');
  }

  Map<String, dynamic> toJson() {
    return {
      userEmailName: email,
      // userFirstName: firstName,
      // userLastName: lastName,
      'id': userID,
      departmentName: department,
      userProfileURLName: profilePictureURL
    };
  }

  AppUserData.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : userID = snapshot.data()[userIDName],
        email = snapshot.data()[userEmailName],
        // firstName = snapshot.data()[userFirstName],
        // lastName = snapshot.data()[userLastName],
        userName = snapshot.data()[userFullName],
        department = snapshot.data()[departmentName],
        profilePictureURL = snapshot.data()[userProfileURLName],
        status = (snapshot.data()[userStatus]);
  // docID = snapshot.id;

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
  // docID = snapshot.data()![docIDName];
}
