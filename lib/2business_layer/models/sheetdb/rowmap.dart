import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/sheet.dart';

import '../../../1pres_layer/alib/uti.dart';
import '_sheetdb.dart';

RxString rowmapsIsLoading = ''.obs;

class RowMap extends SheetDb {
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
      rowmaps.add(rowmap);
    }
    return rowmaps;
  }

  Future<List<Map>> readRowMapsBySheets(List<Sheet> sheets) async {
    List<Map> rowmaps = [];

    for (var idIx = 0; idIx < sheets.length; idIx++) {
      Sheet? sheet = sheets[idIx];
      rowmapsIsLoading.value = sheet.aSheetName;
      List<String> colHeader = sheetDb.colsDb.colsHeadersMap[sheet.aSheetName]!;
      Map rowmap = {};
      for (var colIx = 0; colIx < colHeader.length; colIx++) {
        try {
          rowmap[colHeader[colIx]] = sheet.rowArr[colIx];
          //todo: different len of cols and listStr row
        } catch (_) {}
      }
      rowmap['sheetName'] = sheet.aSheetName;

      rowmaps.add(rowmap);
    }
    return rowmaps;
  }

  //----------------------------------------------------------convert
  Map<String, List<String>> colsHeaders = {};
  Future colsHeadersBuild() async {
    colsHeaders.clear();
    List<Sheet>? sheets = await sheetDb.colsDb.colsHeadersGetAll();
    for (var i = 0; i < sheets!.length; i++) {
      colsHeaders[sheets[i].aSheetName] = blUti.toListString(sheets[i].rowArr);
    }
  }

  Future<Map> row2MapLocalId(int localId) async {
    Sheet? sheet = await sheetDb.readOps.readbyLocalId(localId);
    List<String> cols = colsHeaders[sheet!.aSheetName]!;
    Map rowmap = {};

    for (int i = 0; i < cols.length; i++) {
      try {
        rowmap[cols[i]] = sheet.rowArr[i];
      } catch (_) {}
    }
    rowmap['tags'] = sheet.tagsList;
    rowmap['sheetName'] = sheet.aSheetName;
    return rowmap;
  }

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

    return rowmap;
  }
}
