import 'dart:async';

import 'package:isar/isar.dart';

import '../../../1pres_layer/alib/uti.dart';
import '_sheetdb.dart';
import 'sheet.dart';

class CreateOps {
  late Isar isar;

  Future create(Sheet newSheet) async {
    try {
      await isar.writeTxn((isar) async {
        newSheet.id = await isar.sheets.put(newSheet); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('sheetDB.create', e.toString(), s.toString());
      return '';
    }
  }

  Future createRows(String sheetName, String fileId, List<dynamic> rowsArr,
      List<String> colsHeader, Map<String, List<int>> starsmap) async {
    try {
      await sheetDb.colsDb.createColsHeader(sheetName, fileId, colsHeader);
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.createRows.createColsHeader', e.toString(), s.toString(),
          descr:
              'sheetName: $sheetName fileId: $fileId rowsArrLen: ${rowsArr.length} colsHeader: $colsHeader');
    }

    List<Sheet> rows = [];

    int rowIx = 0;

    int sheetIDix = colsHeader.indexOf('ID');
    for (rowIx = 0; rowIx < rowsArr.length; rowIx++) {
      int sheetID = -1;
      try {
        sheetID = int.tryParse(rowsArr[rowIx][sheetIDix])!;
      } catch (e) {
        logDb.createWarning('sheetDB.createRows.sheetID',
            '$e  \n\n sheetName: $sheetName fileId: $fileId rowsArrLen: ${rowsArr.length} colsHeader: $colsHeader');

        continue;
      }

      Sheet sheet = Sheet();

      try {
        sheet
          ..zfileId = fileId
          ..aSheetName = sheetName
          ..aKey = 'row'
          ..sheetId = sheetID
          ..rowArr = blUti.toListString(rowsArr[rowIx]);
      } catch (_) {
        continue;
      }
      try {
        sheet = sheetTags(sheet, colsHeader, rowsArr[rowIx], starsmap);
      } catch (_) {
        continue;
      }

      rows.add(sheet);
    }

    if (rows.isEmpty) {
      logDb.createErr('sheetDB.createRows.putAll',
          'Error: wrong data sheet $sheetName', 'empty rows[]');
      return;
    }
    try {
      await isar.writeTxn((isar) async {
        await isar.sheets.putAll(rows); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('sheetDB.createRows.putAll', e.toString(), s.toString());
      return;
    }
  }

  Sheet sheetTags(Sheet sheet, List<String> colsHeader, List<dynamic> rowDyn,
      Map<String, List<int>> starsmap) {
    try {
      List<int> sheetIDs = starsmap[sheet.aSheetName]!.toList();
      if (sheetIDs.contains(sheet.sheetId)) {
        sheet.tags.add('*');
      }
    } catch (_) {
      //todo:
      //unexpected null value on sheetIDs = starsmap
      return sheet;
    }
    //------------------------------------------tags
    List<String> row = [];
    try {
      row = blUti.toListString(rowDyn);
    } catch (_) {
      return sheet;
    }
    int tagIx = colsHeader.indexOf('tags');
    if (tagIx == -1) return sheet;

    List<String> tags = [];
    try {
      tags = row[tagIx].split(',');
    } catch (_) {
      return sheet;
    }
    for (String tag in tags) {
      // ignore: unnecessary_null_comparison
      if (tag == null) continue;
      if (tag.isEmpty) continue;
      sheet.tags.add(tag);
    }
    return sheet;
  }
}
