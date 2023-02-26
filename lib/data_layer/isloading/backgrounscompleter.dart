import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/1pres_layer/filelist/filelistcard.dart';
import 'package:sheetbrowser/2business_layer/getsheet.dart';
import 'package:sheetbrowser/data_layer/getsheetdl.dart';

import '../../2business_layer/appdata/approotdata.dart';
import '../../2business_layer/models/sheetdb/_sheetdb.dart';

bool backgroundCompleterIsRunning = false;
RxBool isDataLoading = false.obs;
RxString isloadingAction = ''.obs;
RxString isloadingPhaseMessage = ''.obs;

Future backgroundCompleter(Function setStateCallback) async {
  if (!isar.isOpen) {
    await Future.delayed(const Duration(seconds: 3));
  }

  String? lastCompleted =
      AppDataPrefs.getString('backgroundCompleter-lastDate');

  if (lastCompleted == blUti.todayStr()) return;

  backgroundCompleterIsRunning = true;
  //----------------------------------------------------clear
  await sheetDb.sheeetsClear();

  await getFilelist();
  Map<String, List<int>> starsmap = await getStarMap();

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

//----------------------------------------------------*map
Map<String, List<int>> starMap = {};
Future<Map<String, List<int>>> getStarMap() async {
  List<dynamic> rowsArr = [];
  List<String> colsHeader = [];
  try {
    String fileId = blUti.url2fileid(AppDataPrefs.getRootSheetId());
    String sheetName = '*';

    rowsArr =
        await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName).getSheet();

    if (rowsArr.isEmpty) {
      logDb.createWarning('createStarDb()',
          'Starred sheet is empty. [setting] "*" sheet exists?  or AppDataPrefs.getRootSheetId()?');
      return {};
    }
    colsHeader = blUti.toListString(rowsArr[0]);
    if (colsHeader.isEmpty) {
      logDb.createWarning(
          'createStarDb()', 'Starred sheet header is empty. [setting] ');
      return {};
    }

    rowsArr.removeAt(0);

    if (rowsArr.isEmpty) {
      logDb.createWarning('createStarDb()',
          'Starred sheet is empty. [setting] sheet "*" is empty?  or AppDataPrefs.getRootSheetId()?');

      return {};
    }
  } catch (_) {}

  for (var rowIx = 0; rowIx < rowsArr.length; rowIx++) {
    int sheetID = -1;
    try {
      sheetID = int.tryParse(rowsArr[rowIx][1])!;
    } catch (_) {
      continue;
    }
    String sheetName = '';
    try {
      sheetName = rowsArr[rowIx][0];
    } catch (_) {
      continue;
    }
    List<int> sheetIDs = [];
    try {
      sheetIDs = starMap[sheetName]!;
      sheetIDs.add(sheetID);
    } catch (e) {
      sheetIDs = [sheetID];
    }
    try {
      Set<int> set = sheetIDs.toSet();
      starMap[sheetName] = set.toList();
    } catch (_) {
      continue;
    }
  }

  return starMap;
}
