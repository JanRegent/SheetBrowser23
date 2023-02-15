import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../2business_layer/getsheet.dart';
import '../../../2business_layer/models/sheetdb/_sheetdb.dart';
import '../detail/cardswiper.dart';

//import 'gtidviewopt.dart';

late final PlutoGridStateManager stateManager;
GetSheet currentSheet = GetSheet();

class GridPage extends StatefulWidget {
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  const GridPage(this.columns, this.rows, {Key? key}) : super(key: key);

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  //late GridViewOpt gridViewOpt;
  @override
  void initState() {
    super.initState();
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
                    currentSheet.rowsArrFiltered = [];
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

  Map sheetIDsMap = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(currentSheet.sheetName),
          actions: [
            ElevatedButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  var filteredIDs = stateManager.refRows
                      .map((e) => e.cells['ID']!.value.toString());

                  for (String filteredID in filteredIDs) {
                    int? rowIx = int.tryParse(filteredID);
                    currentSheet.rowsArrFiltered
                        .add(currentSheet.sheets[rowIx!].rowArr);
                  }
                }),
            ElevatedButton(
                child: const Icon(Icons.list),
                onPressed: () async {
                  if (currentSheet.rowsArrFiltered.isEmpty) {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CardSwiper(
                              const [], currentSheet.getFilelistRow(), 0),
                        ));
                  } else {
                    List<int> ids = await sheetDb.starredBL
                        .readRowsLocalIds(currentSheet.sheetName);

                    // ignore: use_build_context_synchronously
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) =>
                              CardSwiper(ids, currentSheet.getFilelistRow(), 0),
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
                if (kDebugMode) {}
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
