// ignore_for_file: file_names

import 'dart:core';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';

import '../../2business_layer/appdata/approotdata.dart';
import '../../data_layer/getsheetdl.dart';

import '../alib/alib.dart';

import '../views/detail/cardswiper.dart';
import '../views/plutogrid/_gridpage.dart';
import 'filelistcardmenu.dart';

List<dynamic> filelist = [];
Map sheetNameFileIdMap = {};
Future getFilelist() async {
  String? filelistSheetName = AppDataPrefs.getString('currentFileList');
  String sheetId = AppDataPrefs.getRootSheetId();
  List<dynamic> fileArr =
      await GoogleSheetsDL(sheetId: sheetId, sheetName: filelistSheetName!)
          .getSheet();

  List<String> fileHeader = blUti.toListString(fileArr[0]);
  filelist.clear();
  for (var rowIx = 1; rowIx < fileArr.length; rowIx++) {
    filelist.add(sheetDb.rowMap.row2Map(fileHeader, fileArr[rowIx]));
    String sheetName = filelist.last['sheetName'];
    String fileId = blUti.url2fileid(filelist.last['fileUrl']);
    sheetNameFileIdMap[sheetName] = fileId;
  }
}

Future<String> getFileIdFromFilelist(String sheetName) async {
  filelist.clear();
  for (var rowIx = 0; rowIx < filelist.length; rowIx++) {
    if (filelist[rowIx]['sheetName'] == sheetName) {
      String fileId = blUti.url2fileid(filelist[rowIx]['fileUrl']);
      return fileId;
    }
  }
  return '';
}

Future carouselStars(BuildContext context, String sheetNameOrEmpty) async {
  EasyLoading.show(status: 'Loading starred');
  List<int> ids = await sheetDb.starredBL.readStarredLocalIds(sheetNameOrEmpty);

  EasyLoading.dismiss();
  Map configRow = {};
  configRow['fileUrl'] = currentSheet.fileId;
  configRow['title'] = 'Stars';

  // ignore: use_build_context_synchronously
  await Navigator.push(
      context, MaterialPageRoute(builder: (ctx) => CardSwiper(ids, configRow)));
}

Card filelistCard(BuildContext context, Map fileListRow, int index) {
  List<Widget> getLements() {
    List<Widget> rowWigs = [];
    rowWigs.add(const Text('    '));
    rowWigs.add(datagridButton(context, fileListRow));
    rowWigs.add(const Text('  '));

    rowWigs.add(lastBookmarkButton(context, fileListRow));
    //rowWigs.add(bookmarkAutoCheckbox(context, fileListSheetRow));
    rowWigs.add(const Text('  '));

    rowWigs.add(sheetStarredButton(context, fileListRow));
    rowWigs.add(const Text('  '));
    return rowWigs;
  }

  ExpansionTileCard expansionFilelistCard(
      BuildContext context, Map fileListRow) {
    final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
    return ExpansionTileCard(
      baseColor: Colors.cyan[50],
      expandedColor: Colors.red[50],
      key: cardA,
      initiallyExpanded: index == 0 ? true : false,
      title: Text(fileListRow['fileTitle'],
          style: const TextStyle(fontSize: 20, color: Colors.black)),
      subtitle:
          const Text("..", style: TextStyle(fontSize: 10, color: Colors.black)),
      trailing: rightPopup(context, fileListRow),
      children: [
        const Text('     '),
        Row(
          children: getLements(),
        )
      ],
    );
  }

  return Card(
    shape: RoundedRectangleBorder(
      side: BorderSide.merge(
          const BorderSide(
              width: 1.5, color: Colors.lightBlue, style: BorderStyle.solid),
          const BorderSide(
              width: 1.5, color: Colors.lightBlue, style: BorderStyle.solid)),
      borderRadius: BorderRadius.circular(20),
    ),
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [expansionFilelistCard(context, fileListRow)],
    ),
  );
}

Future plutoGridShow(
  BuildContext context,
  Map fileListRow,
) async {
  //---------------------------------------------------------------------cols
  /// Columns must be provided at the beginning of a row synchronously.

  //----------------------------------------------------------------------rows
  String fileId = '';
  try {
    fileId = blUti.url2fileid(fileListRow['fileUrl']);
    await currentSheet.getSheet(fileListRow['sheetName'], fileId);

    // ignore: use_build_context_synchronously
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GridPage(
                currentSheet.plutoCols, currentSheet.gridrows, fileListRow)));
  } catch (e, s) {
    logDb.createErr('plutoGridShow(', e.toString(), s.toString(),
        descr: fileListRow['sheetName'] + ' fileId: ' + fileId);
  }
}

//-------------------------------------------------------------------grid
RxString allRowsButtonlAllRowsLabel = ''.obs;

ElevatedButton datagridButton(BuildContext context, Map fileListRow) {
  return ElevatedButton.icon(
      label: const Text(''),
      icon: const Icon(
        Icons.grid_4x4,
        color: Colors.black,
      ),
      onPressed: () async {
        al.message(context, 'Preparing grid of ${fileListRow["sheetName"]}');
        String fileId = blUti.url2fileid(fileListRow['fileUrl']);
        await currentSheet.getSheet(fileListRow['sheetName'], fileId);
        currentSheet.rowsArrFiltered.clear();
        // ignore: use_build_context_synchronously
        await plutoGridShow(context, fileListRow);
      });
}

Future detailViewAll(BuildContext context, Map fileListRow) async {
  String fileId = blUti.url2fileid(fileListRow['fileUrl']);
  await currentSheet.getSheet(fileListRow['sheetName'], fileId);
  fileListRow['title'] = fileListRow['sheetName'];
  fileListRow['startRowByBookmark'] = 'doIt';
  List<int> ids =
      await sheetDb.starredBL.readRowsLocalIds(fileListRow['sheetName']);

  // ignore: use_build_context_synchronously
  await Navigator.push(
      context, MaterialPageRoute(builder: (_) => CardSwiper(ids, fileListRow)));
}

ElevatedButton lastBookmarkButton(BuildContext context, Map fileListRow) {
  return ElevatedButton.icon(
      label: const Text(''),
      icon: const Icon(
        Icons.list,
        color: Colors.black,
      ),
      onPressed: () async {
        await detailViewAll(context, fileListRow);
      });
}

ElevatedButton sheetStarredButton(BuildContext context, Map fileListRow) {
  return ElevatedButton.icon(
      label: const Text(''),
      icon: const Icon(
        Icons.star,
        color: Colors.black,
      ),
      onPressed: () async {
        al.message(context, 'Starred is loading');
        await carouselStars(context, fileListRow['sheetName']);
      });
}
