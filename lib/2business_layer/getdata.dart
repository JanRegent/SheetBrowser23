import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/1pres_layer/filelist/filelistcard.dart';
import 'package:sheetbrowser/2business_layer/approotdata.dart';

import '../data_layer/getsheetdl.dart';
import 'models/sheetdb.dart';

//--------------------------------------------------------------------filelist
Future getFilelist() async {
  String? sheetName = AppDataPrefs.getString('currentFileList');
  String sheetId = AppDataPrefs.getRootSheetId();
  List<dynamic> fileArr =
      await GoogleSheetsDL(sheetId: sheetId, sheetName: sheetName!)
          .getAllSheet();

  List<String> fileHeader = blUti.toListString(fileArr[0]);
  filelist.clear();
  for (var rowIx = 1; rowIx < fileArr.length; rowIx++) {
    filelist.add(row2Map(fileHeader, fileArr[rowIx]));
  }
}

//-----------------------------------------------------------------------tags
Future<List<dynamic>> getTagsData() async {
  final values = await GoogleSheetsDL(
    sheetId: AppDataPrefs.getRootSheetId(),
    sheetName: 'getTags',
  ).getAllSheet();

  return values;
}

List<dynamic> getTagsSheet = [];
List<String> tagsList = [];
Future<List<dynamic>> tagsPrepare() async {
  {
    getTagsSheet = await getTagsData();
  }
  Set<String> tagsSet = {};
  for (var rowIx = 0; rowIx < getTagsSheet.length; rowIx++) {
    tagsSet.add(getTagsSheet[rowIx][0].toString());
  }
  tagsList = tagsSet.toList();
  tagsList.sort();
  return getTagsSheet;
}

List<dynamic> tagRows = [];
Future rowsOfTag(String tagSelected) async {
  tagRows = [];
  for (var rowIx = 0; rowIx < getTagsSheet.length; rowIx++) {
    if (getTagsSheet[rowIx][0] == tagSelected) tagRows.add(getTagsSheet[rowIx]);
  }
}

//-------------------------------------------------------------------selects
Future<List<dynamic>> selectData() async {
  final values = await GoogleSheetsDL(
    sheetId: AppDataPrefs.getRootSheetId(),
    sheetName: '',
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

//-----------------------------------------------------------------------rootSheet

Future rootSheet2localStorage() async {
  try {
    final values = await GoogleSheetsDL(
      sheetId: AppDataPrefs.getRootSheetId(),
      sheetName: 'rootSheet',
    ).getAllSheet();
    sheet2localStorage(values);
  } catch (e, s) {
    logDb.createErr(
        'getData.rootSheet2localStorage', e.toString(), s.toString(),
        descr:
            '\n sheetName: rootSheet \nsheetId: ${AppDataPrefs.getRootSheetId()}');
  }
}

Future sheet2localStorage(List<dynamic> arr) async {
  for (var rowIx = 1; rowIx < arr.length; rowIx++) {
    if (arr[rowIx].length == 0) continue;
    await AppDataPrefs.setString(arr[rowIx][0], arr[rowIx][1]);
  }
}
