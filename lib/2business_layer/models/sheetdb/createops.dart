import 'dart:async';

import '../../../1pres_layer/alib/uti.dart';
import '_sheetdb.dart';
import 'sheet.dart';

class CreateOps {
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

  Future createRows(
      String sheetName, String fileId, List<dynamic> rowsArr) async {
    Future<List<String>> colsHeaderGet() async {
      List<String> colsHeader = [];
      try {
        colsHeader = blUti.toListString(rowsArr[0]);

        if (colsHeader.isEmpty) return [];
        if (!colsHeader.contains('ID')) return [];
        rowsArr.removeAt(0);

        await sheetDb.colsDb.createColsHeader(sheetName, fileId, colsHeader);
      } catch (e, s) {
        logDb.createErr(
            'sheetDB.createRows.createColsHeader', e.toString(), s.toString(),
            descr:
                'sheetName: $sheetName fileId: $fileId rowsArrLen: ${rowsArr.length} ');
      }
      return colsHeader;
    }

    List<String> colsHeader = await colsHeaderGet();
    int sheetIDix = colsHeader.indexOf('ID');
    if (sheetIDix == -1) return;

    int tagIx = colsHeader.indexOf('tags');
    List<Sheet> rows = [];
    int rowIx = 0;

    for (rowIx = 0; rowIx < rowsArr.length; rowIx++) {
      int sheetID = -1;
      try {
        sheetID = int.tryParse(rowsArr[rowIx][sheetIDix])!;
      } catch (e) {
        //todo
        if (sheetID == -1) continue;
        logDb.createWarning('sheetDB.createRows.sheetID',
            '$e  \n\n sheetName: $sheetName $sheetID=${rowsArr[rowIx][sheetIDix]} fileId: $fileId rowsArrLen: ${rowsArr.length} colsHeader: $colsHeader');

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

        if (tagIx > -1) {
          sheet.tagsList.addAll(rowsArr[rowIx][tagIx].trim().split(','));
        }
      } catch (_) {
        //todo RangeError (index): Index out of range: index should be less than 10: 10
      }

      rows.add(sheet);
    }

    if (rows.isEmpty) {
      //todo tgMilos tomas is empty
      // logDb.createErr('sheetDB.createRows.putAll',
      //     'Error: wrong data sheet $sheetName', 'empty rows[]');
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
}
