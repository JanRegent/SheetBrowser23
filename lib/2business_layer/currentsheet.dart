import 'package:pluto_grid/pluto_grid.dart';

import '../1pres_layer/alib/uti.dart';
import '../1pres_layer/views/plutogrid/cols.dart';
import '../1pres_layer/views/plutogrid/rows.dart';
import '../data_layer/sheetget.dart';
import 'approotdata.dart';

class CurrentSheet {
  List<dynamic> rowsArrFiltered = [];
  List<dynamic> rowsArr = [];
  List<String> colsHeader = [];
  List<PlutoColumn> plutoCols = [];
  List<PlutoRow> gridrows = [];

  Future newRows(List<dynamic> newRowsArr) async {
    rowsArr = newRowsArr;
    await gridPrepare();
  }

  Future gridPrepare() async {
    colsHeader = blUti.toListString(rowsArr[0]);
    rowsArr.removeAt(0);

    plutoCols = await colsMap(colsHeader);
    gridrows = await gridRowsMap(rowsArr, colsHeader);
  }

  Future<List> getAllSheet(String? sheetName, String fileId) async {
    if (fileId.isEmpty) {
      fileId = AppDataPrefs.getString(
          'currentSheetId', AppDataPrefs.getRootSheetId())!;
    }
    if (sheetName!.isEmpty) {
      sheetName = AppDataPrefs.getString(
          'currentSheetId', AppDataPrefs.getRootSheetId())!;
    }
    final values = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
        .getAllSheet();

    return values;
  }
}
