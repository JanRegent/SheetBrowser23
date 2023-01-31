import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../2business_layer/getdata.dart';
import 'models/sheetdb.dart';

class AppDataPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static Future appRootConfigLoad() async {
    //----------------------apikey
    // ignore: unused_local_variable

    try {
      String jsonString = await rootBundle.loadString('apikey.json');
      dynamic jsonMap = jsonDecode(jsonString);
      apiKey = jsonMap['apikey'];
    } catch (e, s) {
      logDb.createErr('AppDataPrefs.apikey', e.toString(), s.toString());
    }

    try {
      String jsonString = await rootBundle.loadString('appConfig.json');
      dynamic jsonMap = jsonDecode(jsonString);
      await setString('rootSheetId', jsonMap['rootSheetId']);
    } catch (e, s) {
      logDb.createErr('AppDataPrefs.rootSheetId', e.toString(), s.toString());
    }

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
