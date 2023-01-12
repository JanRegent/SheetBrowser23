import 'package:sheetbrowse/2app_layer/appdata.dart';

import '../4data_layer/sheetget.dart';

Future<List> getSheetValues() async {
  final values = await GoogleSheets(
    sheetId: AppDataPrefs.getRootSheetId(),
    sheetName: 'starred2022',
  ).sheetValues();

  return values;
}

Map rowMapGet(List<dynamic> header, List<dynamic> datarow) {
  Map row = {};
  for (var i = 0; i < header.length; i++) {
    row[header[i]] = datarow[i];
  }
  return row;
}

Future<List<dynamic>> selectData() async {
  final values = await GoogleSheets(
    sheetId: AppDataPrefs.getRootSheetId(),
    sheetName: 'starred2022',
  ).selectData();

  return values;
}
