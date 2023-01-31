import 'package:pluto_grid/pluto_grid.dart';

import '../1pres_layer/alib/uti.dart';
import '../1pres_layer/views/plutogrid/cols.dart';
import '../1pres_layer/views/plutogrid/rows.dart';
import '../data_layer/getsheetdl.dart';
import 'approotdata.dart';

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
      if (await sheetDb.lengthRows(sheetName) == 0) {
        rowsArr = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
            .getAllSheet();
        colsHeader = blUti.toListString(rowsArr[0]);
        rowsArr.removeAt(0);
        sheetDb.createRows(sheetName, fileId, rowsArr, colsHeader);
      }
      await gridPrepare();
    } catch (e, s) {
      logDb.createErr('GetSheet().getSheet', e.toString(), s.toString());
    }
  }

  Map getFilelistRow() {
    Map filelistRow = {};
    filelistRow['sheetName'] = sheetName;
    filelistRow['fileId'] = fileId;
    return filelistRow;
  }

  Future gridPrepare() async {
    colsHeader = (await sheetDb.readColsHeader(sheetName))!;
    plutoCols = await colsMap(colsHeader);
    rowsArr = await sheetDb.readRowsAll(sheetName);
    gridrows = await gridRowsMap(rowsArr, colsHeader);
  }
}
