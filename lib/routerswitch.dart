import 'package:flutter/material.dart';

import 'package:sheetbrowser/1pres_layer/views/detail/cardswiper.dart';
import 'package:sheetbrowser/1pres_layer/views/plutogrid/_gridpage.dart';

import 'package:sheetbrowser/2business_layer/appdata/approotdata.dart';

import '1pres_layer/_home/errorpage.dart';
import '1pres_layer/filelist/filelistcard.dart';
import '1pres_layer/filelist/inboxhome.dart';
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

    List<dynamic> rowsArr = [];
    if (route2Page == 'filelist') {
      await getFilelist();
    }
    if (action == 'getNews') {
      await currentSheet.getSheet('getNews', '');
    }

    if (rowsArr.isEmpty) {
      await currentSheet.getSheet('', '');
    }
    configRow['fileUrl'] = AppDataPrefs.getRootSheetId();

    // ignore: use_build_context_synchronously

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

            if (route2Page == 'homesidebar') {
              return const SidebarXApp();
            }
            //-----------------------------------------------default detail view
            if (currentSheet.rowsArrFiltered.isEmpty) {
              configRow['sheetName'] = 'All';

              return CardSwiper(const [], configRow, 0);
            } else {
              configRow['sheetName'] = 'Filter:';
              return CardSwiper(const [], configRow, 0);
            }
          } else if (snapshot.hasError) {
            runApp(
              ErrorPage2('[RouterSwitch] snapshot.error \n${snapshot.error}'),
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
            children = const [Text('Awaiting result...')];
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
