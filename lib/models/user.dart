class AppUser {
  String userID;

  AppUser({required this.userID});
}


class AppUserData {
  String email;

  String firstName;

  String lastName;

  String? userID;

  String profilePictureURL;

  AppUserData(
      {this.email = '',
        this.firstName = '',
        this.lastName = '',
        this.userID = '',
        this.profilePictureURL = ''});

  String fullName() => '$firstName $lastName';

  factory AppUserData.fromJson(Map<String, dynamic> parsedJson) {
    return AppUserData(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': userID,
      'profilePictureURL': profilePictureURL
    };
  }
}