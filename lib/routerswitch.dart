import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sheetbrowse/1pres_layer/alib/uti.dart';
import 'package:sheetbrowse/1pres_layer/views/detail/carousel.dart';
import 'package:sheetbrowse/1pres_layer/views/plutogrid/_gridpage.dart';
import 'package:sheetbrowse/1pres_layer/views/plutogrid/cols.dart';
import 'package:sheetbrowse/1pres_layer/views/plutogrid/rows.dart';
import 'package:sheetbrowse/2app_layer/approotdata.dart';

import '../2app_layer/getdata.dart';

class RouterSwitch extends StatefulWidget {
  const RouterSwitch({super.key});

  @override
  State<RouterSwitch> createState() => _RouterSwitchState();
}

class _RouterSwitchState extends State<RouterSwitch> {
  List<PlutoColumn> plutoCols = [];
  List<PlutoRow> gridrows = [];

  String route2Page = 'detail';
  Future<String> getData() async {
    rowsArr = await getSheetValues();
    BLuti uti = BLuti();
    colsHeader = uti.toListString(rowsArr[0]);
    rowsArr.removeAt(0);

    plutoCols = await colsMap(colsHeader);
    gridrows = await gridRowsMap(rowsArr, colsHeader);

    route2Page = AppDataPrefs.getString('route2Page', 'detail')!;
    return 'ok';
  }

  Row titleSwitch() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              route2Page = 'grid';
              setState(() {});
            },
            icon: const Icon(Icons.grid_4x4)),
        IconButton(
            onPressed: () {
              route2Page = 'detail';
              setState(() {});
            },
            icon: const Icon(Icons.list))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (route2Page != 'detail') {
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
                child: Text(
                    'Error: [RouterSwitch]\n ${snapshot.error}\n\n${colsHeader.join(',')}'),
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
