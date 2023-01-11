import '../../4data_layer/sheetget.dart';

Future<List> getSheetValues() async {
  final values = await GoogleSheets(
    sheetId: '1H5P-NbOR5ie-tQYZPIdhDsSHCvHesPVKccSmy1OI2HQ',
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
    sheetId: '1H5P-NbOR5ie-tQYZPIdhDsSHCvHesPVKccSmy1OI2HQ',
    sheetName: 'starred2022',
  ).selectData();

  return values;
}
