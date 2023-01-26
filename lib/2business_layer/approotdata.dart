import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../2business_layer/getdata.dart';

class AppDataPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static Future appRootConfigLoad() async {
    //----------------------appRootConfig
    String jsonString = await rootBundle.loadString('appRootConfig.json');
    dynamic jsonMap = jsonDecode(jsonString);
    apiKey = jsonMap['apikey'];

    jsonString = await rootBundle.loadString('appConfig.json');
    jsonMap = jsonDecode(jsonString);

    await setString('rootSheetId', jsonMap['rootSheetId']);

    await rootSheet2localStorage();

    var url = window.defaultRouteName;
    await setString(
        'domain',
        url
            .toString()
            .replaceAll('http://', '')
            .replaceAll('https://', '')
            .split('#')[0]);
  }

// ----------------------------------------------------root vars
  static String apiKey = '';
  static String rootConfig = '';
  static String? getApikey() => apiKey;

  static String getRootSheetId() =>
      _instance.getString('rootSheetId').toString();

  //-------------------------------------------------------string
  static String? getString(String key) {
    return _instance.getString(key);
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
