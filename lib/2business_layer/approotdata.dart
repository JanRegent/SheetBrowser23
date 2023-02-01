import 'package:global_configuration/global_configuration.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../2business_layer/getdata.dart';
import 'models/sheetdb.dart';

class AppDataPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static Future apikeyRootSheetIdLoad() async {
    try {
      await GlobalConfiguration().loadFromAsset("apikey");
    } catch (e, s) {
      logDb.createErr(
        'GlobalConfiguration().loadFromAsset("apikey")',
        e.toString(),
        s.toString(),
      );
    }
    try {
      await GlobalConfiguration().loadFromAsset("rootSheetId");
      await AppDataPrefs.setString('rootSheetId', getRootSheetId());
    } catch (e, s) {
      logDb.createErr(
        'GlobalConfiguration().loadFromAsset("rootSheetId")',
        e.toString(),
        s.toString(),
      );
    }
    await rootSheet2localStorage();
  }

// ----------------------------------------------------root vars

  static String? getApikey() => GlobalConfiguration().getValue("apikey");

  static String getRootSheetId() =>
      GlobalConfiguration().getValue("rootSheetId");

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
