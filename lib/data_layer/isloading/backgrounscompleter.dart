import 'dart:async';

import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/1pres_layer/filelist/filelistcard.dart';
import 'package:sheetbrowser/2business_layer/getsheet.dart';

import 'isloading.dart';
import '../../2business_layer/appdata/approotdata.dart';
import '../../2business_layer/models/sheetdb/_sheetdb.dart';

Future backgroundCompleter() async {
  String? lastCompleted =
      AppDataPrefs.getString('backgroundCompleter-lastDate');
  isloadingPhaseMessage.value = 'Up to date $lastCompleted';

  if (lastCompleted == blUti.todayStr()) {
    isloadingPhaseMessage.value = '';
    return;
  }
  await sheetDb.sheeetsClear();

  await tagsDb.clear();

  await getFilelist();

  Future.delayed(const Duration(seconds: 1), () async {
    isDataLoading.value = true;
    isloadingAction.value = 'Loading';
    for (int fileIx = 0; fileIx < filelist.length; fileIx++) {
      String sheetName = filelist[fileIx]['sheetName'];

      isloadingPhaseMessage.value = sheetName;
      String fileId = blUti.url2fileid(filelist[fileIx]['fileUrl']);
      await GetSheet().sheetPrepare(sheetName, fileId);
    }
  }).then((value) {}).catchError((e, s) {
    logDb.createErr('backgroundCompleter', e.toString(), s.toString());
    isDataLoading.value = false;
  }).whenComplete(() async {
    AppDataPrefs.setString('backgroundCompleter-lastDate', blUti.todayStr());
    isloadingPhaseMessage.value = 'Indexing';
    //-----------------------------------------------index
    isloadingAction.value = 'Indexing';
    await tagsDb.tagsIndex();
    await tagsDb.tagsMapSave();
    isloadingAction.value = '';
    isloadingPhaseMessage.value =
        'Up to date ${AppDataPrefs.getString('backgroundCompleter-lastDate')}';
    isDataLoading.value = false;
  });
}
