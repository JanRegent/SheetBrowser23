import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

//import 'gtidviewopt.dart';

late final PlutoGridStateManager stateManager;
List<dynamic> rowsArrSelected = [];
List<dynamic> rowsArr = [];

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('fileTitle'),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  //await gridViewOpt.save();
                },
                onLongPress: () async {
                  //await gridViewOpt.filterClear();
                  setState(() {});
                },
                child: const Icon(Icons.filter)),
            ElevatedButton(
                onPressed: () async {
                  //await gridViewOpt.hidedColumnsSave();
                },
                onLongPress: () async {
                  //await gridViewOpt.hidedColumnsReset();
                  setState(() {});
                },
                child: const Icon(Icons.hide_source)),
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
              onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) async {
                var filteredIDs = stateManager.refRows
                    .map((e) => e.cells['ID']!.value.toString());

                for (String filteredID in filteredIDs) {
                  int? rowIx = int.tryParse(filteredID);
                  rowsArrSelected.add(rowsArr[rowIx!]);
                }
              },
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
