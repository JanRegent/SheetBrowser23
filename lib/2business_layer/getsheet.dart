import 'package:pluto_grid/pluto_grid.dart';

import '../1pres_layer/alib/uti.dart';
import '../1pres_layer/views/plutogrid/cols.dart';
import '../1pres_layer/views/plutogrid/rows.dart';
import '../data_layer/getsheetdl.dart';
import 'approotdata.dart';

class GetSheet {
  String fileId = '';
  String sheetName = '';

  List<dynamic> rowsArrFiltered = [];
  List<dynamic> rowsArr = [];
  List<String> colsHeader = [];
  List<PlutoColumn> plutoCols = [];
  List<PlutoRow> gridrows = [];

  Future getSheet(String sheetNameNew, String fileIdNew) async {
    if (fileId == '' && fileIdNew == '') {
      fileId = AppDataPrefs.getRootSheetId();
      rowsArr = [];
    }

    if (fileId != fileIdNew) rowsArr = [];
    if (sheetName != sheetNameNew) rowsArr = [];
    if (rowsArr.isNotEmpty) return;
    //-----------------------------------new sheet
    sheetName = sheetNameNew;

    if (sheetName.isEmpty) {
      sheetName = AppDataPrefs.getString('currentSheetName')!;
    }
    fileId = fileIdNew;
    if (fileId.isEmpty) {
      fileId = AppDataPrefs.getRootSheetId();
    }
    rowsArr = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
        .getAllSheet();
    await gridPrepare();
  }

  Map getFilelistRow() {
    Map filelistRow = {};
    filelistRow['sheetName'] = sheetName;
    filelistRow['fileId'] = fileId;
    return filelistRow;
  }
  // Future newRows(List<dynamic> newRowsArr) async {
  //   rowsArr = newRowsArr;
  //   await gridPrepare();
  // }

  Future gridPrepare() async {
    colsHeader = blUti.toListString(rowsArr[0]);
    rowsArr.removeAt(0);

    plutoCols = await colsMap(colsHeader);
    gridrows = await gridRowsMap(rowsArr, colsHeader);
  }

  //---------------------------------------------------------------DL
  // Future<List> getAllSheet(String? sheetName, String fileId) async {
  //   final values = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
  //       .getAllSheet();

  //   return values;
  // }
}
