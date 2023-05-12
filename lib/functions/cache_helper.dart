import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences preferences;
  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void setString({
    required String key,
    required String value,
  }) async {
    await preferences.setString(key, value).then((val) {
      log("SET => $key : $value");
    });
  }

  static String? getString({
    required String key,
  }) {
    return preferences.getString(key);
  }

  static removeKey({
    required String key,
  }) async {
    await preferences.remove(key);
    log("Removed : $key");
  }
}
