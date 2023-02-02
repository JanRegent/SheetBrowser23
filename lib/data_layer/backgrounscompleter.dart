import 'dart:async';

import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/1pres_layer/filelist/filelistcard.dart';
import 'package:sheetbrowser/2business_layer/getsheet.dart';

import '../1pres_layer/acontrolers/isloading.dart';
import '../2business_layer/appdata/approotdata.dart';
import '../2business_layer/getdata.dart';
import '../2business_layer/models/sheetdb.dart';

Future backgroundCompleter() async {
  AppDataPrefs.setString('backgroundCompleter', 'start');

  await getFilelist();

  AppDataPrefs.setString('backgroundCompleter', '2filelist');
  Future.delayed(const Duration(seconds: 1), () async {
    for (int fileIx = 0; fileIx < filelist.length; fileIx++) {
      String sheetName = filelist[fileIx]['sheetName'];

      AppDataPrefs.setString('backgroundCompleter-lastSheet', sheetName);
      sheetNameIsloadiding.value = sheetName;
      String fileId = blUti.url2fileid(filelist[fileIx]['fileUrl']);
      await GetSheet().sheetPrepare(sheetName, fileId);
      Future.delayed(const Duration(seconds: 1));
    }
  }).then((value) {}).catchError((e, s) {
    AppDataPrefs.setString('backgroundCompleter', e);
    logDb.createErr('backgroundCompleter', e.toString(), s.toString());
  }).whenComplete(() {
    AppDataPrefs.setString('backgroundCompleter', '9completed');
    sheetNameIsloadiding.value = '';
  });
}
