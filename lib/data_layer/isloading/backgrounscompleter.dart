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

Future backgroundCompleter() async {
  if (!isar.isOpen) {
    await Future.delayed(const Duration(seconds: 3));
  }

  String? lastCompleted =
      appDataPrefs.getString('backgroundCompleter-lastDate');

  if (lastCompleted == blUti.todayStr()) return;

  backgroundCompleterIsRunning = true;
  //----------------------------------------------------clear
  await sheetDb.sheeetsClear();

  await getFilelist();

  //--------------------------------------------------------load
  Future.delayed(const Duration(seconds: 1), () async {
    for (int fileIx = 0; fileIx < filelistMap.length; fileIx++) {
      String sheetName = filelistMap[fileIx]['sheetName'];

      EasyLoading.show(
          status: '${(fileIx + 1)}/${filelistMap.length} \n $sheetName');
      String fileId = blUti.url2fileid(filelistMap[fileIx]['fileUrl']);
      await GetSheet().sheetFill2localDb(sheetName, fileId);
    }
  }).then((value) {}).catchError((e, s) {
    logDb.createErr('backgroundCompleter', e.toString(), s.toString());
    EasyLoading.showError(e);
  }).whenComplete(() async {
    EasyLoading.dismiss();
    appDataPrefs.setString('backgroundCompleter-lastDate', blUti.todayStr());
  });
  backgroundCompleterIsRunning = false;
  try {} catch (_) {}
}
