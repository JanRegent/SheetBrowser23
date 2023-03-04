import 'package:pluto_grid/pluto_grid.dart';

import '../1pres_layer/alib/uti.dart';
import '../1pres_layer/views/plutogrid/cols.dart';
import '../1pres_layer/views/plutogrid/rows.dart';
import '../data_layer/getsheetdl.dart';
import 'appdata/approotdata.dart';

import 'models/sheetdb/sheet.dart';
import 'models/sheetdb/_sheetdb.dart';

class GetSheet {
  String fileId = '';
  String sheetName = '';

  List<dynamic> rowsArrFiltered = [];

  List<Sheet> sheets = [];
  List<Map> rowsMaps = [];
  List<String> colsHeader = [];
  List<PlutoColumn> plutoCols = [];
  List<PlutoRow> gridrows = [];

  Future getSheet(
    String sheetNameNew,
    String fileIdNew,
  ) async {
    //-----------------------------------new sheet
    sheetName = sheetNameNew;
    if (sheetName.isEmpty) return;
    fileId = fileIdNew;

    fileId = fileIdNew;
    if (fileId.isEmpty) return;

    if (fileId.isEmpty) {
      fileId = (await appData.getRootSheetId())!;
    }

    try {
      await sheetPrepare(sheetName, fileId);
    } catch (e, s) {
      logDb.createErr('GetSheet().sheetPrepare', e.toString(), s.toString());
    }

    try {
      await gridPrepare();
    } catch (e, s) {
      logDb.createErr('GetSheet().gridPrepare $sheetName, $fileId',
          e.toString(), s.toString());
    }
  }

  Future sheetPrepare(String sheetName, String fileId) async {
    int sheetLen = await sheetDb.lengthRows(sheetName);

    if (sheetLen > 0) return;

    await sheetFill2localDb(sheetName, fileId);
  }

  Future sheetFill2localDb(String sheetName, String fileId) async {
    List<dynamic> rowsArr = [];
    try {
      rowsArr = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
          .getSheet();

      if (rowsArr.isEmpty) return;
    } catch (e, s) {
      logDb.createErr('GetSheet().sheetPrepare2localDb.GoogleSheetsDL',
          e.toString(), s.toString(),
          descr:
              'sheetName: $sheetName fileId: $fileId rowsArrLen: ${rowsArr.length}');
    }
    try {
      await sheetDb.createOps.createRows(sheetName, fileId, rowsArr);

      //-----------------------------------------------try update diffs
      // List<int> newRows = await sheetsDiff(rowsArr);
      // if (newRows.isEmpty) return;

      // await sheetDb.deleteRowsOfSheet(sheetName);
      // await sheetDb.createRows(sheetName, fileId, rowsArr, colsHeader);
    } catch (e, s) {
      logDb.createErr('GetSheet().sheetPrepare2localDb.createRows',
          e.toString(), s.toString(),
          descr:
              'sheetName: $sheetName fileId: $fileId rowsArrLen: ${rowsArr.length} ');
    }
  }

  Map getFilelistRow() {
    Map filelistRow = {};
    filelistRow['sheetName'] = sheetName;
    filelistRow['fileId'] = fileId;
    return filelistRow;
  }

  Future<List<int>> sheetsDiff(List<dynamic> rowsCloud) async {
    List<int> locIDs = await sheetDb.locIDs(sheetName);
    //------------------------------------------cloudIDs
    colsHeader = (await sheetDb.colsDb.readColsHeader(sheetName));
    int sheetIDix = colsHeader.indexOf('ID');
    List<int> cloudIDs = [];
    try {
      List<dynamic> cloudIDsStr = rowsCloud
          .map<String>((row) => row[sheetIDix])
          .toList(growable: false);
      cloudIDs = blUti.toListInt(cloudIDsStr);
    } catch (e, s) {
      if (!e.toString().contains(
          'RangeError (index): Index out of range: index must not be negative: -1')) {
        logDb.createErr('GetSheet().sheetsDiff', e.toString(), s.toString());
      }
      return [];
    }
    //------------------------------------------difference
    List<int> diffIds = cloudIDs.toSet().difference(locIDs.toSet()).toList();

    return diffIds;
  }

  Future gridPrepare() async {
    colsHeader = (await sheetDb.colsDb.readColsHeader(sheetName));
    plutoCols = await colsMap(colsHeader);

    sheets = await sheetDb.readOps.readSheetsAll(sheetName);
    rowsMaps = await sheetDb.rowMap.readRowMapsSheet(sheetName);
    gridrows = await gridRowsMap(sheets, colsHeader);
  }
}
