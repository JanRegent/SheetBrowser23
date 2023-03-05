import 'package:flutter/material.dart';

import 'package:sheetbrowser/1pres_layer/views/detail/cardswiper.dart';
import 'package:sheetbrowser/1pres_layer/views/plutogrid/_gridpage.dart';

import 'package:sheetbrowser/2business_layer/appdata/approotdata.dart';

import '../filelist/filelistmap.dart';
import '../filelist/inboxhome.dart';
import '__sidebar.dart';
import '../../2business_layer/appdata/0approot.dart';

class RouterSwitch extends StatefulWidget {
  const RouterSwitch({super.key});

  @override
  State<RouterSwitch> createState() => _RouterSwitchState();
}

String route2Page = 'homesidebar';

class _RouterSwitchState extends State<RouterSwitch> {
  String action = ''; // 'getNews';
  Map configRow = {};
  Future<String> getData(BuildContext context) async {
    route2Page = (await appData.appDataGetString('route2Page'));
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
    configRow['fileUrl'] = getRootSheetId();

    // ignore: use_build_context_synchronously

    return route2Page;
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
          if (route2Page == 'filelist') {
            return InboxHomePage(filelistMap);
          }
          if (route2Page == 'grid') {
            return GridPage(
                currentSheet.plutoCols, currentSheet.gridrows, filelistMap[0]);
          }

          if (route2Page == 'homesidebar') {
            return const SidebarXApp();
          }
          //-----------------------------------------------default detail view
          if (currentSheet.rowsArrFiltered.isEmpty) {
            configRow['sheetName'] = 'All';

            return CardSwiper(const [], configRow);
          } else {
            configRow['sheetName'] = 'Filter:';
            return CardSwiper(const [], configRow);
          }
        },
      ),
    ));
  }
}
