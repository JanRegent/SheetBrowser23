import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sheetbrowse/1pres_layer/alib/uti.dart';
import 'package:sheetbrowse/1pres_layer/views/plutogrid/cols.dart';

import '../../2app_layer/getdata.dart';
import 'detail/carousel.dart';
import 'plutogrid/_gridpage.dart';
import 'plutogrid/rows.dart';

class GtridDetailSwitch extends StatefulWidget {
  const GtridDetailSwitch({super.key});

  @override
  State<GtridDetailSwitch> createState() => _GtridDetailSwitchState();
}

class _GtridDetailSwitchState extends State<GtridDetailSwitch> {
  List<PlutoColumn> plutoCols = [];
  List<PlutoRow> gridrows = [];
  List<String> colsHeader = [];

  Future<String> getData() async {
    rowsArr = await getSheetValues();
    BLuti uti = BLuti();
    colsHeader = uti.toListString(rowsArr[0]);
    rowsArr.removeAt(0);

    plutoCols = await colsMap(colsHeader);

    gridrows = await gridRowsMap(rowsArr, colsHeader);

    return 'ok';
  }

  String layout = 'detail';
  Row titleSwitch() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              layout = 'grid';
              setState(() {});
            },
            icon: const Icon(Icons.grid_4x4)),
        IconButton(
            onPressed: () {
              layout = 'detail';
              setState(() {});
            },
            icon: const Icon(Icons.list))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: titleSwitch(),
          //   actions: [
          //   // sheetRightPopup(context, widget.rowmap)
          // ]
        ),
        body: DefaultTextStyle(
          style: Theme.of(context).textTheme.displayMedium!,
          textAlign: TextAlign.center,
          child: FutureBuilder<String>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                if (layout != 'detail') {
                  return GridPage(plutoCols, gridrows);
                }
                if (rowsArrFiltered.isEmpty) {
                  return Carousel(colsHeader, rowsArr);
                } else {
                  return Carousel(colsHeader, rowsArrFiltered);
                }
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ));
  }
}
