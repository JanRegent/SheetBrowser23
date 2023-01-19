import 'package:flutter/material.dart';

import 'package:sheetbrowse/1pres_layer/views/detail/carousel.dart';
import 'package:sheetbrowse/1pres_layer/views/plutogrid/_gridpage.dart';

import 'package:sheetbrowse/2business_layer/approotdata.dart';

import '2business_layer/getdata.dart';
import '1pres_layer/gettags_getnews/tagselectpage.dart';
import '1pres_layer/_home/__sidebar.dart';

class RouterSwitch extends StatefulWidget {
  const RouterSwitch({super.key});

  @override
  State<RouterSwitch> createState() => _RouterSwitchState();
}

class _RouterSwitchState extends State<RouterSwitch> {
  String route2Page = 'detail';
  String action = 'getNews'; // 'getNews';
  Future<String> getData(BuildContext context) async {
    route2Page = AppDataPrefs.getString('route2Page', 'detail')!;
    currentSheet.rowsArr = [];
    if (action == 'getNews') {
      await currentSheet.getSheet('getNews', '');
    }
    if (action == 'getTags') {
      await currentSheet.getSheet('getTags', '');
      await tagsPrepare();
    }
    if (currentSheet.rowsArr.isEmpty) {
      await currentSheet.getSheet('', '');
    }

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
            if (route2Page == 'grid') {
              return GridPage(currentSheet.plutoCols, currentSheet.gridrows);
            }
            if (route2Page == 'getTags') {
              return TagSelectPage(tagsList, 'Tags');
            }

            if (route2Page == 'homesidebar') {
              return SidebarXApp();
            }
            //-----------------------------------------------default detail view
            if (currentSheet.rowsArrFiltered.isEmpty) {
              return Carousel(
                  currentSheet.colsHeader, currentSheet.rowsArr, false, 'All');
            } else {
              return Carousel(currentSheet.colsHeader,
                  currentSheet.rowsArrFiltered, false, 'Filter:');
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
                    'Error: [RouterSwitch]\n ${snapshot.error}\n\n${currentSheet.colsHeader.join(',')}'),
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
