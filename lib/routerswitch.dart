import 'package:flutter/material.dart';

import 'package:sheetbrowser/1pres_layer/views/detail/carousel.dart';
import 'package:sheetbrowser/1pres_layer/views/plutogrid/_gridpage.dart';

import 'package:sheetbrowser/2business_layer/approotdata.dart';

import '../../2business_layer/getdata.dart';
import '1pres_layer/_home/errorpage.dart';
import '1pres_layer/acontrolers/isloading.dart';
import '1pres_layer/filelist/filelistcard.dart';
import '1pres_layer/filelist/inboxhome.dart';
import '1pres_layer/gettags_getnews/tagselectpage.dart';
import '1pres_layer/_home/__sidebar.dart';

class RouterSwitch extends StatefulWidget {
  const RouterSwitch({super.key});

  @override
  State<RouterSwitch> createState() => _RouterSwitchState();
}

class _RouterSwitchState extends State<RouterSwitch> {
  String route2Page = 'detail';
  String action = ''; // 'getNews';
  Map configRow = {};
  Future<String> getData(BuildContext context) async {
    route2Page = AppDataPrefs.getString('route2Page')!;
    currentSheet.rowsArr = [];
    if (route2Page == 'filelist') {
      await getFilelist();
    }
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
    configRow['fileUrl'] = currentSheet.fileId;
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
            if (route2Page == 'filelist') {
              return InboxHomePage(filelist);
            }
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
              configRow['sheetName'] = 'All';
              return Carousel(currentSheet.colsHeader, currentSheet.rowsArr,
                  false, configRow, 0);
            } else {
              configRow['sheetName'] = 'Filter:';
              return Carousel(currentSheet.colsHeader,
                  currentSheet.rowsArrFiltered, false, configRow, 0);
            }
          } else if (snapshot.hasError) {
            runApp(
              const ErrorPage(),
            );
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
            children = isloadingWidgetList('Awaiting result...');
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
