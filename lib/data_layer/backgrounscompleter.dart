import 'dart:async';

import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/1pres_layer/filelist/filelistcard.dart';

import '../2business_layer/appdata/approotdata.dart';
import '../2business_layer/getdata.dart';
import 'getsheetdl.dart';

Future backgroundCompleter() async {
  String? used = AppDataPrefs.getString('backgroundCompleter');
  if (used == null) return;
  AppDataPrefs.setString('backgroundCompleter', 'start');

  await getFilelist();
  AppDataPrefs.setString('backgroundCompleter', '2filelist');
  Future.delayed(const Duration(seconds: 10), () async {
    for (int fileIx = 0; fileIx < filelist.length; fileIx++) {
      AppDataPrefs.setString(
          'backgroundCompleter-lastSheet', filelist[fileIx]['sheetName']);
      await GoogleSheetsDL(
              sheetId: blUti.url2fileid(filelist[fileIx]['fileUrl']),
              sheetName: filelist[fileIx]['sheetName'])
          .getAllSheet();
      Future.delayed(const Duration(seconds: 10));
    }
    return 'ok';
  }).then((value) {}).catchError((error) {
    AppDataPrefs.setString('backgroundCompleter', error);
  }).whenComplete(() {
    AppDataPrefs.setString('backgroundCompleter', '9completed');
  });
  //print("After the future");
}
