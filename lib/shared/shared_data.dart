import 'package:building/models/user.dart';
import 'package:building/shared/shared_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // static Future<SharedPreferences> get _instance async =>
  // instance = await SharedPreferences.getInstance();
  static late final SharedPreferences instance;
  // static SharedPreferences instance = await SharedPreferences.getInstance();

  static Future<SharedPreferences> init() async {
    instance = await SharedPreferences.getInstance();
    return instance;
  }

  // check if the user data is already available in the shared instance
  static bool get firstTime => instance.getBool(firstTimeKey) ?? true;

  static Future<void> setFirstTime({bool value = false}) async {
    await instance.setBool(firstTimeKey, value);
  }

  static Future<void> setUserId(String userId) async {
    await instance.setString(userIdKey, userId);
  }

  static String get userId => instance.getString(userIdKey) ?? '';

  static Future<void> setUserEmail(String email) async {
    await instance.setString(userEmailKey, email);
  }

  static String get userEmail => instance.getString(userEmailKey) ?? '';

  static Future<void> setUserFullName(String fullName) async {
    await instance.setString(userFullNameKey, fullName);
  }

  static String get userFullName => instance.getString(userFullNameKey) ?? '';

  static Future<void> setUserDepartment(String department) async {
    await instance.setString(userDepartmentKey, department);
  }

  static String get userDepartment =>
      instance.getString(userDepartmentKey) ?? '';

  static Future<void> setUserStatus(String status) async {
    await instance.setString(userStatusKey, status);
  }

  static String get userStatus => instance.getString(userStatusKey) ?? '';

  static Future<void> setUserProfilePictureUrl(String profilePictureUrl) async {
    await instance.setString(avatarKey, profilePictureUrl);
  }

  static String get getUserProfilePictureUrl =>
      instance.getString(avatarKey) ?? '';

  static String get userLocation => instance.getString(userLocationKey) ?? '';

  static Future<void> setUserLocation(String location) async {
    await instance.setString(userLocationKey, location);
  }

  static Future<void> setFromData(AppUserData data) async {
    await setUserId(data.userID);
    await setUserEmail(data.email);
    await setUserProfilePictureUrl(data.profilePictureURL);
    await setUserFullName(data.userName);
    await setUserDepartment(data.department);
    await setUserStatus(data.status);
    await setUserLocation(data.location);
  }

  static AppUserData get userData => AppUserData(
        userID: userId,
        email: userEmail,
        profilePictureURL: getUserProfilePictureUrl,
        userName: userFullName,
        department: userDepartment,
        status: userStatus,
        location: userLocation,
      );

  static Future<void> resetPrefs() async {
    await instance.clear();
  }
}
