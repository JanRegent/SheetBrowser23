// ----------------------------------------------------root vars

// ignore_for_file: file_names

import 'package:global_configuration/global_configuration.dart';
import 'package:sheetbrowser/data_layer/getsheetdl.dart';

import '../models/sheetdb/_sheetdb.dart';
import 'approotdata.dart';

String? getApikey() => GlobalConfiguration().getValue("apikey");

String getRootSheetId() => GlobalConfiguration().getValue("rootSheetId");

Future apikeyRootSheetIdLoad() async {
  await appData.appDataClear();
  try {
    await GlobalConfiguration().loadFromAsset('apikey');
    String apikey = GlobalConfiguration().getValue('apikey');
    await appData.appDataCreate('apikey', apikey, '');
  } catch (e) {
    appDataPrefsApdataLoadingError = e.toString();
  }
  try {
    await GlobalConfiguration().loadFromAsset("rootSheetId");
    String rootSheetId = GlobalConfiguration().getValue("rootSheetId");
    await appData.appDataCreate('rootSheetId', rootSheetId, '');
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

Future rootSheet2localStorage() async {
  String? rootSheetId = '';
  try {
    final values = await GoogleSheetsDL(
      sheetId: getRootSheetId(),
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
    await appData.appDataCreate(arr[rowIx][keyIx], arr[rowIx][valIx], '');
  }
}
