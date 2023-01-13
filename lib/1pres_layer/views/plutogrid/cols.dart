import 'package:pluto_grid/pluto_grid.dart';

//import 'package:sheetviewer/AL/views/plutogrid/drawergrid.dart';

Future<List<PlutoColumn>> colsMap(List<dynamic> colsHeader) async {
  // String? freezeStart =
  //     await viewSetting.valueGet(sheetName + '__|__freezeStart');
  // if (freezeStart!.startsWith('"')) {
  //   freezeStart = freezeStart.substring(1, freezeStart.length - 1);
  // }
  // List<String> startList = freezeStart.split(',');
  // String? freezeEnd =
  //     await viewSetting.valueGet(sheetName + '__|__freezeStart');
  // if (freezeEnd!.startsWith('"')) {
  //   freezeEnd = freezeEnd.substring(1, freezeEnd.length - 1);
  // }
  //List<String> endList = freezeEnd.split(',');
  List<PlutoColumn> gridCols = [];
  for (var colIx = 0; colIx < colsHeader.length; colIx++) {
    String columnName = colsHeader[colIx].toString();
    PlutoColumn col = PlutoColumn(
        title: columnName,
        field: columnName,
        type: PlutoColumnType.text(),
        readOnly: true);
    // col.sort = viewHelper.setSort(columnName);
    //col.frozen = setFreeze(columnName, startList, endList);
    gridCols.add(col);
  }
  // PlutoColumn col = PlutoColumn(
  //     title: 'RowNo',
  //     field: 'RowNo',
  //     type: PlutoColumnType.number(),
  //     readOnly: true,
  //     hide: true);
  // gridCols.add(col);

  return gridCols;
}

class PlutoFilterTypeExt extends PlutoFilterType {}

PlutoColumnFrozen setFreeze(
    String columnName, List<String> startList, List<String> endList) {
  try {
    if (startList.contains(columnName)) return PlutoColumnFrozen.start;
    if (endList.contains(columnName)) return PlutoColumnFrozen.end;
  } catch (e) {
    return PlutoColumnFrozen.none;
  }
  return PlutoColumnFrozen.none;
}
