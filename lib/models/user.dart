import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String userID;

  AppUser({required this.userID});

  factory AppUser.fromFirebaseUser(User user) => AppUser(userID: user.uid);

  @override
  String toString() {
    return "AppUser(userID: $userID)";
  }
}

class AppUserData {
  String email;

  String firstName;

  String lastName;

  String? userID;

  String department;

  String profilePictureURL;

  AppUserData(
      {this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.userID = '',
      this.department = '',
      this.profilePictureURL = ''});

  String fullName() => '$firstName $lastName';

  factory AppUserData.fromJson(Map<String, dynamic> parsedJson) {
    return AppUserData(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        department: parsedJson['department'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': userID,
      'department': department,
      'profilePictureURL': profilePictureURL
    };
  }
}
