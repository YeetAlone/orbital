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
  const testUser2 = AppUserData(
    email: "test2@gmail.com",
    userName: "Bulbasaur",
    userID: '1',
    department: 'Grass',
    status: 'incognito',
    profilePictureURL:
        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png',
  );
  const testUser3 = AppUserData(
    email: "test3@gmail.com",
    userName: "Squirtle",
    userID: '3',
    department: 'Water',
    status: 'incognito',
    profilePictureURL:
        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png',
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

      // Add two more users

      db.createNewAppUser(
        email: testUser2.email,
        fullName: testUser2.userName,
        userAuthId: testUser2.userID,
        department: testUser2.department,
        profilePictureUrl: testUser2.profilePictureURL,
      );
      db.createNewAppUser(
        email: testUser3.email,
        fullName: testUser3.userName,
        userAuthId: testUser3.userID,
        department: testUser3.department,
        profilePictureUrl: testUser3.profilePictureURL,
      );

      test("get iterable of AppUserData objects when allUsers is called",
          () async {
        expect(await db.allUsers().first,
            const TypeMatcher<Iterable<AppUserData>>());
        expect(await db.allUsers().first.then((value) => value.length), 3);
      });
    });
    test('findUsersByAvailability', () async {
      expect(
          await db
              .findUsersByAvailability('incognito')
              .first
              .then((value) => value.length),
          3);
      await db.updateAppUser(email: testUser2.email, status: 'busy');
      await db.updateAppUser(email: testUser3.email, status: 'busy');
      expect(
          await db
              .findUsersByAvailability('busy')
              .first
              .then((value) => value.length),
          2);
      await db.updateAppUser(email: testUser.email, status: 'available');
      expect(
          await db
              .findUsersByAvailability('available')
              .first
              .then((value) => value.length),
          1);
      // final invalidAvailability = db.findUsersByAvailability('invalid');
      // expect(invalidAvailability,
      //     throwsA(const TypeMatcher<InvalidStatusException>()));
    });

    test('findUsersByName', () async {
      expect(
          await db
              .findUsersByName('Charmander')
              .first
              .then((value) => value.length),
          1);
      expect(
          await db.findUsersByName('Charm').first.then((value) => value.length),
          1);
      // expect(
      //     await db.findUsersByName('Bulb').first.then((value) => value.length),
      //     1);
      expect(
          await db
              .findUsersByName('unknown')
              .first
              .then((value) => value.length),
          0);
      // expect(
      //     await db
      //         .findUsersByName('Squirtle')
      //         .first
      //         .then((value) => value.length),
      //     1);
      expect(
          await db.findUsersByName('charm').first.then((value) => value.length),
          1);
      expect(
          await db
              .findUsersByName('   charm   ')
              .first
              .then((value) => value.length),
          1);
    });
  });
}
