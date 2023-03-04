import 'package:flutter/foundation.dart';
import 'package:sheetbrowser/data_layer/getsheetdl.dart';

import '../../2business_layer/appdata/0approot.dart';
import '../../2business_layer/appdata/approotdata.dart';
import '../../2business_layer/models/sheetdb/_sheetdb.dart';
import '../alib/uti.dart';

List<dynamic> filelistMap = [];
String filelistName = '';

Future getFilelistTry() async {
  try {
    await getFilelist();
  } catch (e) {
    debugPrint(e as String?);
  }
  if (filelistMap.isNotEmpty) return;
  //todo why 2nd run for filelist?
  await Future.delayed(const Duration(seconds: 3));
  debugPrint('await getFilelist() 2nd');
  await getFilelist();
}

Future getFilelist() async {
  String filelistName = await appData.appDataGetString('currentFileList');

  String sheetId = getRootSheetId();

  List<dynamic> fileArr =
      await GoogleSheetsDL(sheetId: sheetId, sheetName: filelistName)
          .getSheet();

  List<String> fileHeader = [];
  try {
    fileHeader = blUti.toListString(fileArr[0]);
  } catch (_) {
    //todo-optimize not ready yet
  }
  filelistMap.clear();
  for (var rowIx = 1; rowIx < fileArr.length; rowIx++) {
    filelistMap.add(sheetDb.rowMap.row2Map(fileHeader, fileArr[rowIx]));
  }
}

Future<String> getFileIdFromFilelist(String sheetName) async {
  filelistMap.clear();
  for (var rowIx = 0; rowIx < filelistMap.length; rowIx++) {
    if (filelistMap[rowIx]['sheetName'] == sheetName) {
      String fileId = blUti.url2fileid(filelistMap[rowIx]['fileUrl']);
      return fileId;
    }
  }
  return '';
}
