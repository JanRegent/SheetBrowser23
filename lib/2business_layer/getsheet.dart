import 'package:pluto_grid/pluto_grid.dart';

import '../1pres_layer/alib/uti.dart';
import '../1pres_layer/views/plutogrid/cols.dart';
import '../1pres_layer/views/plutogrid/rows.dart';
import '../data_layer/getsheetdl.dart';
import 'appdata/approotdata.dart';

import 'models/sheetdb.dart';

class GetSheet {
  String fileId = '';
  String sheetName = '';

  List<dynamic> rowsArrFiltered = [];
  List<dynamic> rowsArr = [];
  List<String> colsHeader = [];
  List<PlutoColumn> plutoCols = [];
  List<PlutoRow> gridrows = [];

  Future getSheet(String sheetNameNew, String fileIdNew) async {
    rowsArr = [];
    //-----------------------------------new sheet
    sheetName = sheetNameNew;
    fileId = fileIdNew;
    if (sheetName.isEmpty) {
      sheetName = AppDataPrefs.getString('currentSheetName')!;
    }
    fileId = fileIdNew;
    if (fileId.isEmpty) {
      fileId = AppDataPrefs.getRootSheetId();
    }

    try {
      await sheetPrepare(sheetName, fileId);
      await gridPrepare();
    } catch (e, s) {
      logDb.createErr('GetSheet().getSheet', e.toString(), s.toString());
    }
  }

  Future sheetPrepare(String sheetName, String fileId) async {
    try {
      rowsArr = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
          .getSheet();
      colsHeader = blUti.toListString(rowsArr[0]);
      rowsArr.removeAt(0);
      if (await sheetDb.lengthRows(sheetName) == 0) {
        await sheetDb.createRows(sheetName, fileId, rowsArr, colsHeader);
      } else {
        List<int> newRows = await sheetsDiff(rowsArr);
        if (newRows.isNotEmpty) {
          await sheetDb.deleteRowsAll(sheetName);
          await sheetDb.createRows(sheetName, fileId, rowsArr, colsHeader);
        }
      }
    } catch (e, s) {
      logDb.createErr('GetSheet().checkSheet', e.toString(), s.toString());
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
    colsHeader = (await sheetDb.readColsHeader(sheetName))!;
    int sheetIDix = colsHeader.indexOf('ID');
    List<int> cloudIDs = [];
    try {
      List<dynamic> cloudIDsStr = rowsCloud
          .map<String>((row) => row[sheetIDix])
          .toList(growable: false);
      cloudIDs = blUti.toListInt(cloudIDsStr);
    } catch (e, s) {
      logDb.createErr('GetSheet().sheetsDiff', e.toString(), s.toString());
    }
    //------------------------------------------difference
    List<int> diffIds = cloudIDs.toSet().difference(locIDs.toSet()).toList();

    return diffIds;
  }

  Future gridPrepare() async {
    colsHeader = (await sheetDb.readColsHeader(sheetName))!;
    plutoCols = await colsMap(colsHeader);
    rowsArr = await sheetDb.readRowsAll(sheetName);
    gridrows = await gridRowsMap(rowsArr, colsHeader);
  }
}
