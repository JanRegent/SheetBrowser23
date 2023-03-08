import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sheetdb/_sheetdb.dart';
import './appdata.dart';

String appDataPrefsApdataLoadingError = '';
AppDataPrefs appData = AppDataPrefs();

class AppDataPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

//-----------------------------------------------------load

  Future appDataClear() async {
    try {
      await isar.writeTxn((isar) async {
        await isar.appdatas.clear(); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('appdatas.clear', e.toString(), s.toString());
      return '';
    }
  }

  Future appDataCreate(
      String key, String value, String sheetNameOrEmptyGlobal) async {
    Appdata appdataRow = Appdata()
      ..key = key
      ..value = value
      ..sheetName = sheetNameOrEmptyGlobal;

    try {
      await isar.writeTxn((isar) async {
        await isar.appdatas.put(appdataRow); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('appdatas.create', e.toString(), s.toString());
      return '';
    }
  }

  Future<String> appDataGetString(String key) async {
    if (key.isEmpty) return '';

    String? value = await isar.appdatas
        .filter()
        .keyEqualTo(key)
        .and()
        .sheetNameEqualTo('')
        .valueProperty()
        .findFirst();
    try {
      return value ?? '';
    } catch (_) {
      return '';
    }
  }

  //-------------------------------------------------------string
  String? getString(String key) {
    return _instance.getString(key);
  }

  List<String> getKeys() {
    return _instance.getKeys().toList();
  }

  Future<bool> setString(String key, String value) async {
    return _instance.setString(key, value);
  }

  //-------------------------------------------------------bool
  // Getter
  bool? getBool(String key) => _instance.getBool(key);

  // Setter
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);
}
