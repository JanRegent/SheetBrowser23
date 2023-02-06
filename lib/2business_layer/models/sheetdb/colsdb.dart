import 'package:isar/isar.dart';

import '../../../1pres_layer/alib/uti.dart';
import 'sheet.dart';
import '_sheetdb.dart';

class ColsDb extends SheetDb {
  ColsDb(super.isar);

  Future createColsHeader(
      String sheetName, String fileId, List<String> colsHeader) async {
    await deleteColsHeader(sheetName, fileId);
    try {
      await create(Sheet()
        ..zfileId = fileId
        ..aSheetName = sheetName
        ..aKey = 'colsHeader'
        ..listStr = blUti.toListString(colsHeader));
    } catch (e, s) {
      logDb.createErr('sheetDB.create', e.toString(), s.toString());
      return '';
    }
  }

  Future<List<String>?> readColsHeader(String sheetName) async {
    late Sheet? row;
    try {
      row = (await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .aKeyEqualTo('colsHeader')
          .findFirst());
    } catch (_) {
      return [];
    }
    if (row?.listStr == null) return [];
    return row?.listStr;
  }

  Map<String, List<String>> colsHeadersMap = {};

  Future colsHeadersMapBuild() async {
    final colRows =
        await isar.sheets.filter().aKeyEqualTo('colsHeader').findAll();

    for (var sheetNameIx = 0; sheetNameIx < colRows.length; sheetNameIx++) {
      colsHeadersMap[colRows[sheetNameIx].aSheetName] =
          colRows[sheetNameIx].listStr;
    }
  }

  Future deleteColsHeader(String sheetName, String fileId) async {
    try {
      List<int> ids = await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .aKeyEqualTo('colsHeader')
          .idProperty()
          .findAll();
      if (ids.isNotEmpty) {
        await isar.writeTxn((isar) {
          return isar.sheets.deleteAll(ids); // delete
        });
      }
    } catch (_) {}
  }

  Future<List<String>> sheetNamesGet() async {
    List<String> sheetNames = await isar.sheets
        .filter()
        .aKeyEqualTo('colsHeader')
        .aSheetNameProperty()
        .findAll();

    return sheetNames;
  }
}
