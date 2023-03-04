import 'package:global_configuration/global_configuration.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_layer/getsheetdl.dart';
import '../models/sheetdb/_sheetdb.dart';
import './appdata.dart';

String appDataPrefsApdataLoadingError = '';
AppDataPrefs appDataPrefs = AppDataPrefs();

class AppDataPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();
  Future apikeyRootSheetIdLoad() async {
    await appDataPrefs.appDataClear();
    try {
      await GlobalConfiguration().loadFromAsset("apikey");
      String apikey = GlobalConfiguration().getValue("apikey");
      await appDataPrefs.appDataCreate('apikey', apikey, '');
    } catch (e) {
      appDataPrefsApdataLoadingError = e.toString();
    }
    try {
      await GlobalConfiguration().loadFromAsset("rootSheetId");
      String rootSheetId = GlobalConfiguration().getValue("rootSheetId");
      await appDataPrefs.appDataCreate('rootSheetId', rootSheetId, '');
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

  Future rootSheet2localStorage() async {
    String? rootSheetId = '';
    try {
      rootSheetId = await getRootSheetId();

      final values = await GoogleSheetsDL(
        sheetId: rootSheetId!,
        sheetName: 'rootSheet',
      ).getSheet();

      sheet2localStorage(values);
    } catch (e, s) {
      logDb.createErr(
          'getData.rootSheet2localStorage', e.toString(), s.toString(),
          descr: '\n sheetName: rootSheet \nsheetId: $rootSheetId');
    }
  }

  Future sheet2localStorage(List<dynamic> arr) async {
    int keyIx = 0;
    int valIx = 1;
    for (var rowIx = 1; rowIx < arr.length; rowIx++) {
      if (arr[rowIx].length == 0) continue;
      await appDataCreate(arr[rowIx][keyIx], arr[rowIx][valIx], '');
    }
  }

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

  Future<String?> appDataReadGetString(String key) async {
    if (key.isEmpty) return '';

    String? value = await isar.appdatas
        .filter()
        .keyEqualTo(key)
        .valueProperty()
        .findFirst();
    print('$key value $value');
    return value;
  }
// ----------------------------------------------------root vars

  String? getApikey() => GlobalConfiguration().getValue("apikey");

  Future<String?> getRootSheetId() async {
    return await appDataReadGetString('rootSheetId');
  }

  //-------------------------------------------------------string
  String? getString(String key) {
    return _instance.getString(key);
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
