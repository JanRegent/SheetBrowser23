import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../2business_layer/getdata.dart';

class AppDataPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static Future appRootConfigLoad() async {
    String jsonString =
        await rootBundle.loadString('appRootConfig_gitIgnore.json');
    final dynamic jsonMap = jsonDecode(jsonString);
    await setString('apikey', jsonMap['apikey']);
    await setString('rootSheetId', jsonMap['rootSheetId']);

    await rootSheet2localStorage();
  }

// ----------------------------------------------------root vars
  static Future<bool> setApikey(String value) =>
      _instance.setString('apikey', value);

  static String? getApikey() => _instance.getString('apikey');

  static String getRootSheetId() =>
      _instance.getString('rootSheetId').toString();

  //-------------------------------------------------------string
  static String? getString(String key, String defValue) {
    try {
      return _instance.getString(key);
    } catch (_) {
      return defValue;
    }
  }

  static Future<bool> setString(String key, String value) async {
    return _instance.setString(key, value);
  }

  //-------------------------------------------------------bool
  // Getter
  static bool? getBool(String key) => _instance.getBool(key);

  // Setter
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);
}
