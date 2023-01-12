import 'package:shared_preferences/shared_preferences.dart';

class AppDataPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static Future appdataLoad() async {
    const apikey = String.fromEnvironment('apikey');
    await setString('apikey', apikey);
  }

// ----------------------------------------------------vars
  static Future<bool> setApikey(String value) =>
      _instance.setString('apikey', value);

  static String? getApikey() => _instance.getString('apikey');

  static String getRootSheetId = '1H5P-NbOR5ie-tQYZPIdhDsSHCvHesPVKccSmy1OI2HQ';
  static String getRootSheetName = 'starred2022';
  //-------------------------------------------------------string
  static String getString(String key, String defValue) {
    return _instance.getString(key) ?? defValue;
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
