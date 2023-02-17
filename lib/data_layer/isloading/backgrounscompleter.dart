import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/1pres_layer/filelist/filelistcard.dart';
import 'package:sheetbrowser/2business_layer/getsheet.dart';

import '../../2business_layer/appdata/approotdata.dart';
import '../../2business_layer/models/sheetdb/_sheetdb.dart';

bool backgroundCompleterIsRunning = false;
RxBool isDataLoading = false.obs;
RxString isloadingAction = ''.obs;
RxString isloadingPhaseMessage = ''.obs;

Future backgroundCompleter(Function setStateCallback) async {
  String? lastCompleted =
      AppDataPrefs.getString('backgroundCompleter-lastDate');

  if (lastCompleted == blUti.todayStr()) {
    await sheetDb.colsDb.colsHeadersMapBuild();
    return;
  }
  backgroundCompleterIsRunning = true;
  //----------------------------------------------------clear
  await sheetDb.sheeetsClear();

  await getFilelist();
  Map<String, List<int>> starsmap = await sheetDb.selsBL.getStarMap();

  //--------------------------------------------------------load
  Future.delayed(const Duration(seconds: 1), () async {
    for (int fileIx = 0; fileIx < filelist.length; fileIx++) {
      String sheetName = filelist[fileIx]['sheetName'];

      EasyLoading.show(
          status: 'Loading $sheetName\n ${(fileIx + 1)}/${filelist.length}');
      String fileId = blUti.url2fileid(filelist[fileIx]['fileUrl']);
      await GetSheet().sheetPrepare(sheetName, fileId, starsmap);
    }
  }).then((value) {}).catchError((e, s) {
    logDb.createErr('backgroundCompleter', e.toString(), s.toString());
    EasyLoading.showError(e);
  }).whenComplete(() async {
    //-----------------------------------------------index
    EasyLoading.show(status: 'Getting cols');
    await sheetDb.colsDb.colsHeadersMapBuild();

    EasyLoading.dismiss();
    AppDataPrefs.setString('backgroundCompleter-lastDate', blUti.todayStr());
  });
  backgroundCompleterIsRunning = false;
  try {
    setStateCallback;
  } catch (_) {}
}
