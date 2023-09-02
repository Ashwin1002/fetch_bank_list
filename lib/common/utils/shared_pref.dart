import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static getData(
      {required String key, dynamic dValue, required String type}) async {
    late dynamic temp;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return switch (type) {
      "String" => prefs.getString(key) ?? dValue,
      ("int") => prefs.getInt(key) ?? dValue,
      ("bool") => prefs.getBool(key) ?? dValue,
      (_) => prefs.getString(key) ?? dValue,
    };
  }

  static setData(
      {required String key,
      required dynamic dValue,
      required String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return switch (type) {
      "String" => prefs.setString(key, dValue),
      ("int") => prefs.setInt(key, dValue),
      ("bool") => prefs.setBool(key, dValue),
      (_) => prefs.setString(key, dValue)
    };
  }

  static removeData({required String key, required String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return switch (type) {
      ("String") => prefs.remove(key),
      ("int") => prefs.remove(key),
      ("bool") => prefs.remove(key),
      (_) => prefs.remove(key)
    };
  }

  static removeAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
