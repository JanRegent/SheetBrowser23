// ignore_for_file: file_names

import 'dart:core';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';

import '../../2business_layer/appdata/0approot.dart';
import '../../2business_layer/appdata/approotdata.dart';
import '../../data_layer/getsheetdl.dart';

import '../alib/alib.dart';

import '../views/detail/cardswiper.dart';
import '../views/plutogrid/_gridpage.dart';
import 'filelistcardmenu.dart';

List<dynamic> filelistMap = [];
String filelistName = 'hledaniList';

Future getFilelist() async {
  //String? filelistSheetName = await appData.appDataGetString('currentFileList');

  String? sheetId = await appData.appDataGetString('rootSheetId');

  List<dynamic> fileArr =
      await GoogleSheetsDL(sheetId: sheetId!, sheetName: filelistName)
          .getSheet();

  List<String> fileHeader = blUti.toListString(fileArr[0]);
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

Future carouselStars(BuildContext context, String sheetNameOrEmpty) async {
  al.message(context, 'Loading starred');
  List<int> ids = await sheetDb.readOps.readRowsStar(sheetNameOrEmpty);

  Map configRow = {};
  configRow['fileUrl'] = currentSheet.fileId;
  configRow['title'] = 'Stars';

  // ignore: use_build_context_synchronously
  await Navigator.push(
      context, MaterialPageRoute(builder: (ctx) => CardSwiper(ids, configRow)));
}

Map getConfigRow(Map configRow) {
  if (configRow['fileTitle'] == null) {
    configRow['fileTitle'] = configRow['sheetName'];
  }
  if (configRow['fileUrl'] == null) {
    configRow['fileUrl'] = getRootSheetId();
  }
  return configRow;
}

Map getConfigRowSheetName(String sheetName) {
  return getConfigRow({'sheetName': sheetName});
}

Card filelistCard(BuildContext context, Map configRow) {
  configRow = getConfigRow(configRow);

  List<Widget> getLements() {
    List<Widget> rowWigs = [];
    rowWigs.add(const Text('    '));
    rowWigs.add(datagridButton(context, configRow));
    rowWigs.add(const Text('  '));

    rowWigs.add(lastBookmarkButton(context, configRow));
    //rowWigs.add(bookmarkAutoCheckbox(context, fileListSheetRow));
    rowWigs.add(const Text('  '));

    rowWigs.add(sheetStarredButton(context, configRow));
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
      initiallyExpanded: false,
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
      children: [expansionFilelistCard(context, configRow)],
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
  al.message(context, 'Loading all rows of  ${fileListRow['sheetName']}');
  String fileId = blUti.url2fileid(fileListRow['fileUrl']);
  await currentSheet.getSheet(fileListRow['sheetName'], fileId);
  fileListRow['title'] = fileListRow['sheetName'];
  // ignore: use_build_context_synchronously

  List<int> ids =
      await sheetDb.readOps.readRowsLocalIds(fileListRow['sheetName']);

  // ignore: use_build_context_synchronously
  await Navigator.push(
      context, MaterialPageRoute(builder: (_) => CardSwiper(ids, fileListRow)));
}

ElevatedButton lastBookmarkButton(BuildContext context, Map configRow) {
  return ElevatedButton.icon(
      label: const Text(''),
      icon: const Icon(
        Icons.list,
        color: Colors.black,
      ),
      onPressed: () async {
        configRow['__bookmarkLastRowVisitSave__'] =
            '__bookmarkLastRowVisitSave__';
        await detailViewAll(context, configRow);
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
