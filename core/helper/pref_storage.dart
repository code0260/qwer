import 'package:shared_preferences/shared_preferences.dart';

class PrefStorage {
  PrefStorage._();

  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  static Future<void> clearPreferencesData() async {
    await sharedPreferences!.clear();
  }

  static Future<void> set(String key, String value) async {
    await sharedPreferences!.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await sharedPreferences!.setBool(key, value);
  }

  static Future<void> setStringList(String key, List<String> value) async {
    await sharedPreferences!.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    List<String>? value = sharedPreferences!.getStringList(key);
    return value;
  }

  static dynamic get(String key) {
    dynamic value = sharedPreferences!.getString(key);
    return value;
  }

  static dynamic getBool(String key) {
    bool? value = sharedPreferences!.getBool(key);
    return value;
  }

  ///will clear all the data stored in preference
  static Future<void> remove(String key) async {
    await sharedPreferences!.remove(key);
  }

  static dynamic getKeys() {
    var value = sharedPreferences!.getKeys();
    return value;
  }
}
