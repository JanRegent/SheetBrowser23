import 'package:sheetbrowse/2app_layer/approotdata.dart';

import '../4data_layer/sheetget.dart';

Future<List> getSheetValues() async {
  String currentSheetId =
      AppDataPrefs.getString('currentSheetId', AppDataPrefs.getRootSheetId())!;

  String currentSheetName =
      AppDataPrefs.getString('currentSheetName', 'rootSheet')!;

  final values =
      await GoogleSheets(sheetId: currentSheetId, sheetName: currentSheetName)
          .sheetValues();

  return values;
}

Future<List<dynamic>> selectData() async {
  final values = await GoogleSheets(
    sheetId: AppDataPrefs.getRootSheetId(),
    sheetName: 'starred2022',
  ).selectData();

  return values;
}

Map row2Map(List<dynamic> keys, List<dynamic> datarow) {
  Map row = {};
  for (var i = 0; i < keys.length; i++) {
    try {
      row[keys[i]] = datarow[i];
    } catch (_) {
      row[keys[i]] = ''; //datarow.length < keys.length
    }
  }
  return row;
}

Future rootSheet2localStorage() async {
  final values = await GoogleSheets(
    sheetId: AppDataPrefs.getRootSheetId(),
    sheetName: 'rootSheet',
  ).sheetValues();
  sheet2localStorage(values);
}

Future sheet2localStorage(List<dynamic> arr) async {
  for (var rowIx = 1; rowIx < arr.length; rowIx++) {
    if (arr[rowIx].length == 0) continue;
    await AppDataPrefs.setString(arr[rowIx][0], arr[rowIx][1]);
  }
  String currentSheetId = ''; //------------default is rootSheetId
  try {
    currentSheetId = AppDataPrefs.getString(
        'currentSheetId', AppDataPrefs.getRootSheetId())!;
  } catch (_) {
    currentSheetId = AppDataPrefs.getRootSheetId();
    AppDataPrefs.setString('currentSheetId', currentSheetId);
  }
}
