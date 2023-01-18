import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../2app_layer/approotdata.dart';
import '../detail/carousel.dart';

//import 'gtidviewopt.dart';

late final PlutoGridStateManager stateManager;
List<dynamic> rowsArrFiltered = [];
List<dynamic> rowsArr = [];
List<String> colsHeader = [];

class GridPage extends StatefulWidget {
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  const GridPage(this.columns, this.rows, {Key? key}) : super(key: key);

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  //late GridViewOpt gridViewOpt;
  String currentSheetName = '';
  @override
  void initState() {
    super.initState();
    currentSheetName = AppDataPrefs.getString('currentSheetName', '')!;
    try {
      stateManager.setShowColumnFilter(true);
    } catch (_) {}
  }

  PopupMenuButton appbarRightPopup() {
    return PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: ElevatedButton(
                  child: const Icon(Icons.clear),
                  onPressed: () {
                    stateManager.filterRows.clear();
                    stateManager.setFilterWithFilterRows([]);
                    rowsArrFiltered = [];
                  }),
            ),
            PopupMenuItem<int>(
              value: 0,
              child: ElevatedButton(
                  onPressed: () async {
                    //await gridViewOpt.save();
                  },
                  onLongPress: () async {
                    //await gridViewOpt.filterClear();
                    setState(() {});
                  },
                  child: const Icon(Icons.filter)),
            ),
            PopupMenuItem<int>(
              value: 0,
              child: ElevatedButton(
                  onPressed: () async {
                    //await gridViewOpt.hidedColumnsSave();
                  },
                  onLongPress: () async {
                    //await gridViewOpt.hidedColumnsReset();
                    setState(() {});
                  },
                  child: const Icon(Icons.hide_source)),
            ),
          ];
        },
        onSelected: (value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(currentSheetName),
          actions: [
            ElevatedButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  var filteredIDs = stateManager.refRows
                      .map((e) => e.cells['ID']!.value.toString());

                  for (String filteredID in filteredIDs) {
                    int? rowIx = int.tryParse(filteredID);
                    rowsArrFiltered.add(rowsArr[rowIx!]);
                  }
                }),
            ElevatedButton(
                child: const Icon(Icons.list),
                onPressed: () async {
                  if (rowsArrFiltered.isEmpty) {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) =>
                              Carousel(colsHeader, rowsArr, false),
                        ));
                  } else {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) =>
                              Carousel(colsHeader, rowsArrFiltered, false),
                        ));
                  }
                }),
            appbarRightPopup()
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(15),
            child: PlutoGrid(
              columns: widget.columns,
              rows: widget.rows,
              //columnGroups: columnGroups,
              createFooter: (stateManager) {
                stateManager.setPageSize(50, notify: false); // default 40
                return PlutoPagination(stateManager);
              },
              onLoaded: (PlutoGridOnLoadedEvent event) {
                try {
                  stateManager = event.stateManager;
                } catch (_) {}
                // gridViewOpt = GridViewOpt(
                //     widget.fileListRow['fileUrl'],
                //     widget.fileListRow['sheetName'],
                //     stateManager,
                //     widget.columns);

                //gridViewOpt.load();
                stateManager.setShowColumnFilter(true);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                if (kDebugMode) {
                  print(event);
                }
              },
              onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) async {},
              //configuration: configuration,
            )));
  }

  List<int> getFilteredIds(PlutoGridStateManager stateManager) {
    List<int> ids = [];
    var idsFilter = stateManager.refRows.map((e) => e.cells['Id']!.value);
    for (var id in idsFilter) {
      ids.add(id);
    }
    return ids;
  }
}
