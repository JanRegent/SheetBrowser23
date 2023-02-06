import 'package:isar/isar.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/sheet.dart';

import '_sheetdb.dart';

class RowMap extends SheetDb {
  RowMap(super.isar);

  Future<List<Map>> readRowMapsSheet(String sheetName) async {
    List<int> ids = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .aKeyEqualTo('row')
        .idProperty()
        .findAll();

    return readRowMapsByIDs(ids);
  }

  Future<List<Map>> readRowMapsByIDs(List<int> ids) async {
    List<Map> rowmaps = [];
    await sheetDb.colsDb.colsHeadersMapBuild();
    for (var idIx = 0; idIx < ids.length; idIx++) {
      Sheet? sheet = await isar.sheets.get(ids[idIx]);
      List<String> colHeader =
          sheetDb.colsDb.colsHeadersMap[sheet!.aSheetName]!;
      Map rowmap = {};
      for (var colIx = 0; colIx < colHeader.length; colIx++) {
        try {
          rowmap[colHeader[colIx]] = sheet.rowArr[colIx];
          //todo: different len of cols and listStr row
        } catch (_) {}
      }
      rowmap['sheetName'] = sheet.aSheetName;
      rowmap['starred'] = sheet.starred;
      rowmaps.add(rowmap);
    }
    return rowmaps;
  }

  Future<List<Map>> readRowMapsBySheets(List<Sheet> sheets) async {
    List<Map> rowmaps = [];
    await sheetDb.colsDb.colsHeadersMapBuild();
    for (var idIx = 0; idIx < sheets.length; idIx++) {
      Sheet? sheet = sheets[idIx];
      List<String> colHeader = colsDb.colsHeadersMap[sheet.aSheetName]!;
      Map rowmap = {};
      for (var colIx = 0; colIx < colHeader.length; colIx++) {
        try {
          rowmap[colHeader[colIx]] = sheet.rowArr[colIx];
          //todo: different len of cols and listStr row
        } catch (_) {}
      }
      rowmap['sheetName'] = sheet.aSheetName;
      rowmap['starred'] = sheet.starred;
      rowmaps.add(rowmap);
    }
    return rowmaps;
  }

  //----------------------------------------------------------convert
  Map row2Map(List<dynamic> keys, List<dynamic> datarow) {
    Map rowmap = {};
    for (var i = 0; i < keys.length; i++) {
      try {
        rowmap[keys[i]] = datarow[i];
      } catch (_) {
        rowmap[keys[i]] = '';
      }
    }
    return rowmap;
  }

  Map row2MapSheet(List<dynamic> keys, Sheet sheet) {
    Map rowmap = {};
    for (var i = 0; i < keys.length; i++) {
      try {
        rowmap[keys[i]] = sheet.rowArr[i];
      } catch (_) {
        rowmap[keys[i]] = '';
      }
    }
    rowmap['sheetName'] = sheet.aSheetName;
    rowmap['starred'] = sheet.starred;
    return rowmap;
  }
}
