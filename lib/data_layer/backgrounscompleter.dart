import 'dart:async';

import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/1pres_layer/filelist/filelistcard.dart';
import 'package:sheetbrowser/2business_layer/getsheet.dart';

import '../1pres_layer/acontrolers/isloading.dart';
import '../2business_layer/appdata/approotdata.dart';
import '../2business_layer/getdata.dart';
import '../2business_layer/models/sheetdb.dart';

Future backgroundCompleter() async {
  String? lastCompleted =
      AppDataPrefs.getString('backgroundCompleter-lastDate');
  if (lastCompleted == blUti.todayStr()) {
    sheetNameIsloadiding.value = '';
    return;
  }
  await sheetDb.deleteAKeyEqualToRow();
  await sheetDb.deleteNewsToday();
  await getFilelist();

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
    logDb.createErr('backgroundCompleter', e.toString(), s.toString());
  }).whenComplete(() {
    sheetNameIsloadiding.value = '';
    AppDataPrefs.setString('backgroundCompleter-lastDate', blUti.todayStr());
  });
}
