// ignore_for_file: file_names

import 'dart:core';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb.dart';

import '../../2business_layer/approotdata.dart';
import '../alib/alib.dart';

import '../views/detail/carousel.dart';
import '../views/plutogrid/_gridpage.dart';
import 'filelistcardmenu.dart';

List<dynamic> filelist = [];

Card filelistCard(BuildContext context, Map fileListRow, int index) {
  List<Widget> getLements() {
    List<Widget> rowWigs = [];
    rowWigs.add(const Text('    '));
    rowWigs.add(datagridButton(context, fileListRow));
    rowWigs.add(const Text('  '));

    rowWigs.add(lastRowButton(context, fileListRow));
    rowWigs.add(const Text('  '));

    rowWigs.add(lastBookmarkButton(context, fileListRow));
    //rowWigs.add(bookmarkAutoCheckbox(context, fileListSheetRow));
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
  // String fileId = blUti.url2fileid(fileListRow['fileUrl']);
  // String sheetName = fileListRow['sheetName'];

  //viewHelper = ViewHelper();
  //await viewHelper.load(fileId, sheetName);
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
            builder: (context) =>
                GridPage(currentSheet.plutoCols, currentSheet.gridrows)));
  } catch (e, s) {
    logDb.createErr('plutoGridShow(', e.toString(), s.toString(),
        descr: fileListRow['sheetName'] + ' fileId: ' + fileId);
  }
}

//-------------------------------------------------------------------------all
RxString allRowsButtonlAllRowsLabel = ''.obs;

ElevatedButton datagridButton(BuildContext context, Map fileListRow) {
  return ElevatedButton.icon(
      label: const Text(''),
      icon: const Icon(
        Icons.grid_4x4,
        color: Colors.black,
      ),
      onPressed: () async {
        al.message(context, fileListRow['sheetName']);
        String fileId = blUti.url2fileid(fileListRow['fileUrl']);
        await currentSheet.getSheet(fileListRow['sheetName'], fileId);
        // ignore: use_build_context_synchronously
        await plutoGridShow(context, fileListRow);
      });
}

ElevatedButton lastRowButton(BuildContext context, Map fileListRow) {
  return ElevatedButton.icon(
      label: const Text(''),
      icon: const Icon(
        Icons.list,
        color: Colors.black,
      ),
      onPressed: () async {
        al.message(context, fileListRow['sheetName']);
        String fileId = blUti.url2fileid(fileListRow['fileUrl']);
        await currentSheet.getSheet(fileListRow['sheetName'], fileId);
        fileListRow['title'] = fileListRow['sheetName'];
        // ignore: use_build_context_synchronously
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Carousel(currentSheet.colsHeader,
                    currentSheet.rowsArr, false, fileListRow, 0)));
      });
}

// Obx bookmarkAutoCheckbox(BuildContext context, Map fileListRow) {
//   return Obx(() => Checkbox(
//         value: filelistContr.bookmarkAuto.value,
//         onChanged: (bool? value) {
//           filelistContr.bookmarkAuto.value = !filelistContr.bookmarkAuto.value;
//         },
//       ));
// }

ElevatedButton lastBookmarkButton(BuildContext context, Map fileListRow) {
  return ElevatedButton.icon(
      label: const Text(''),
      icon: const Icon(
        Icons.bookmark,
        color: Colors.black,
      ),
      onPressed: () async {
        String fileId = blUti.url2fileid(fileListRow['fileUrl']);
        await currentSheet.getSheet(fileListRow['sheetName'], fileId);
        fileListRow['title'] = fileListRow['sheetName'];

        String? startRowStr =
            AppDataPrefs.getString('${fileListRow['sheetName']}__bookmark');
        int? startRow = int.tryParse(startRowStr!);

        // ignore: use_build_context_synchronously
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Carousel(currentSheet.colsHeader,
                    currentSheet.rowsArr, false, fileListRow, startRow!)));
        // await sheetRowsDb.readPrepare(fileListRow['sheetName']);
        // String bookmarkSheetID = await filelistContr.bookmarkSheetIDget();
        // int? localId = await sheetRowsDb.readSheetRowId(bookmarkSheetID);
        // await rowDetailPageShow(context, fileListRow, localId!, [], '');
      });
}
