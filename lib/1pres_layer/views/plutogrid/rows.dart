import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sheetbrowse/2app_layer/getdata.dart';

Future<List<PlutoRow>> gridRowsMap(
    List<dynamic> rowsArr, List<String> cols) async {
  PlutoRow gridRow(List<dynamic> dynRow, int rowIx) {
    PlutoRow plutoRow = PlutoRow(cells: {});
    Map row = row2Map(cols, dynRow);
    for (var colIx = 0; colIx < cols.length; colIx++) {
      // ignore: unused_local_variable
      String value = '';
      try {
        if (row[cols[colIx]] == null) {
          value = '';
        } else {
          value = row[cols[colIx]];
        }
      } catch (_) {
        value = '';
      }
      try {
        plutoRow.cells[cols[colIx]] = PlutoCell(value: value);
      } catch (e) {
        plutoRow.cells[cols[colIx]] = PlutoCell(value: '');
      }
    }
    plutoRow.cells['Id'] = PlutoCell(value: rowIx.toString());
    return plutoRow;
  }

  List<PlutoRow> gridrows = [];

  for (var rowIx = 0; rowIx < rowsArr.length; rowIx++) {
    gridrows.add(gridRow(rowsArr[rowIx], rowIx));
  }
  return gridrows;
}

Icon detailIcon() {
  return const Icon(
    Icons.last_page,
  );
}
