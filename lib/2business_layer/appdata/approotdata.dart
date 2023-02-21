
import 'package:global_configuration/global_configuration.dart';

import 'package:shared_preferences/shared_preferences.dart';


import '../../data_layer/getsheetdl.dart';
import '../models/sheetdb/_sheetdb.dart';

String appDataPrefsApdataLoadingError = '';

class AppDataPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static Future apikeyRootSheetIdLoad() async {
    try {
      await GlobalConfiguration().loadFromAsset("apikey");
    } catch (e) {
      appDataPrefsApdataLoadingError = e.toString();

   
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
      appDataPrefsApdataLoadingError = e.toString();
    
    }

    await rootSheet2localStorage();
  }

//-----------------------------------------------------load

  static Future rootSheet2localStorage() async {
    try {
      final values = await GoogleSheetsDL(
        sheetId: AppDataPrefs.getRootSheetId(),
        sheetName: 'rootSheet',
      ).getSheet();

      sheet2localStorage(values);
    } catch (e, s) {
      logDb.createErr(
          'getData.rootSheet2localStorage', e.toString(), s.toString(),
          descr:
              '\n sheetName: rootSheet \nsheetId: ${AppDataPrefs.getRootSheetId()}');
    }
  }

  static Future sheet2localStorage(List<dynamic> arr) async {
    int keyIx = 0;
    int valIx = 1;
    for (var rowIx = 1; rowIx < arr.length; rowIx++) {
      if (arr[rowIx].length == 0) continue;
      await AppDataPrefs.setString(arr[rowIx][keyIx], arr[rowIx][valIx]);
    }
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
