import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sheetbrowse/1pres_layer/alib/uti.dart';
import 'package:sheetbrowse/1pres_layer/views/detail/carousel.dart';
import 'package:sheetbrowse/1pres_layer/views/plutogrid/_gridpage.dart';
import 'package:sheetbrowse/1pres_layer/views/plutogrid/cols.dart';
import 'package:sheetbrowse/1pres_layer/views/plutogrid/rows.dart';
import 'package:sheetbrowse/2app_layer/approotdata.dart';

import '../2app_layer/getdata.dart';
import '1pres_layer/gettags/tagselectpage.dart';
import '4data_layer/sheetget.dart';

class RouterSwitch extends StatefulWidget {
  const RouterSwitch({super.key});

  @override
  State<RouterSwitch> createState() => _RouterSwitchState();
}

class _RouterSwitchState extends State<RouterSwitch> {
  List<PlutoColumn> plutoCols = [];
  List<PlutoRow> gridrows = [];

  String route2Page = 'detail';
  String action = 'getTags'; // 'getNews';
  Future<String> getData(BuildContext context) async {
    rowsArr = [];
    if (action == 'getNews') rowsArr = await getNewsData();
    if (action == 'getTags') rowsArr = await tagsPrepare();
    print(await getTagQuote('Nisargadatta__tgQuotes', '46',
        '1JJk7OMlA3_qp0re6H_15ugYUj5KP8x3319GUNHEZ0zo'));
    if (rowsArr.isEmpty) rowsArr = await getSheetValues();

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
        future: getData(context),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (route2Page != 'detail') {
              return GridPage(plutoCols, gridrows);
            }
            if (route2Page != 'getTags') {
              return TagSelectPage(tagsList, 'Tags');
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
