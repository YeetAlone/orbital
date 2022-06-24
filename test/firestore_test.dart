// import 'package:building/models/user.dart';
import 'package:building/services/cloud/cloud_exceptions.dart';

import 'package:flutter_test/flutter_test.dart';

import 'firestore_classes.dart';

void main() {
  final db = FakeCloudStorage();
  const testUser = AppUserData(
    email: "test@gmail.com",
    userName: "Charmander",
    userID: '4',
    department: 'Fire',
    status: 'incognito',
    profilePictureURL:
        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/004.png',
  );
  group('Firebase Mock', () {
    test("generic user should be added", () async {
      expect(
          await db.createNewAppUser(
            email: "test@gmail.com",
            fullName: "Charmander",
            userAuthId: '4',
            department: 'Fire',
            profilePictureUrl:
                'https://assets.pokemon.com/assets/cms2/img/pokedex/full/004.png',
          ),
          const TypeMatcher<AppUserData>());
    });
    test("throws CouldNotUpdateAppUserException on wrong data type", () {
      expect(db.updateAppUser(email: "test@gmail.com", status: "sleepy"),
          throwsA(const TypeMatcher<CouldNotUpdateAppUserException>()));
    });
    test("throws CouldNotUpdateAppUserException on unknown email", () {
      expect(db.updateAppUser(email: "wrong_emails", status: "busy"),
          throwsA(const TypeMatcher<CouldNotUpdateAppUserException>()));
    });

    test("throws CouldNotUpdateAppUserException on same unknown email", () {
      expect(db.updateAppUser(email: "wrong_emails", status: "busy"),
          throwsA(const TypeMatcher<CouldNotUpdateAppUserException>()));
    });
    group("getters", () {
      db.createNewAppUser(
        email: "test@gmail.com",
        fullName: "Charmander",
        userAuthId: '4',
        department: 'Fire',
        profilePictureUrl:
            'https://assets.pokemon.com/assets/cms2/img/pokedex/full/004.png',
      );
      test("get a user using id", () async {
        expect(await db.getAppUserFromId(testUser.userID), equals(testUser));
      });

      test("get a user using email", () async {
        expect(await db.getAppUserFromEmail(testUser.email), equals(testUser));
      });

      test("get a user email using id", () async {
        expect(await db.getUserEmailFromId(testUser.userID),
            equals(testUser.email));
      });

      test("throws CouldNotGetAppUserException on unknown id", () {
        expect(db.getAppUserFromId("unknown_id"),
            throwsA(const TypeMatcher<CouldNotGetAppUserException>()));
      });

      test("throws CouldNotGetAppUserException on unknown email", () {
        expect(db.getUserEmailFromId("unknown_email"),
            throwsA(const TypeMatcher<CouldNotGetAppUserException>()));
      });

      test("throws CouldNotGetAppUserException on unknown id for email", () {
        expect(db.getUserEmailFromId("unknown_id"),
            throwsA(const TypeMatcher<CouldNotGetAppUserException>()));
      });
    });
  });
}
