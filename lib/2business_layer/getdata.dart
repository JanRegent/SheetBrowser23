import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/1pres_layer/filelist/filelistcard.dart';
import 'package:sheetbrowser/2business_layer/appdata/approotdata.dart';

import '../data_layer/getsheetdl.dart';
import 'models/sheetdb/_sheetdb.dart';

//--------------------------------------------------------------------filelist
Future getFilelist() async {
  String? sheetName = AppDataPrefs.getString('currentFileList');
  String sheetId = AppDataPrefs.getRootSheetId();
  List<dynamic> fileArr =
      await GoogleSheetsDL(sheetId: sheetId, sheetName: sheetName!).getSheet();

  List<String> fileHeader = blUti.toListString(fileArr[0]);
  filelist.clear();
  for (var rowIx = 1; rowIx < fileArr.length; rowIx++) {
    filelist.add(sheetDb.rowMap.row2Map(fileHeader, fileArr[rowIx]));
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

//-----------------------------------------------------------------------rootSheet

Future rootSheet2localStorage() async {
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

Future sheet2localStorage(List<dynamic> arr) async {
  int keyIx = 0;
  int valIx = 1;
  for (var rowIx = 1; rowIx < arr.length; rowIx++) {
    if (arr[rowIx].length == 0) continue;
    await AppDataPrefs.setString(arr[rowIx][keyIx], arr[rowIx][valIx]);
  }
}
