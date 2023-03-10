import 'package:clipboard/clipboard.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

import '../../alib/alib.dart';

int currentRowIndex = 0;
List<int> swiperLocalIds = [];

class DetailMenu extends StatefulWidget {
  final Map rowmap;
  final Map configRow;
  final VoidCallback swiperSetstate;

  const DetailMenu(
    this.rowmap,
    this.configRow,
    this.swiperSetstate, {
    super.key,
  });

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  late final List<PlutoMenuItem> whiteTapMenus;

  List<PlutoMenuItem> gotoItems = [];
  void gotoItemsBuild() {
    int localIdsLength = widget.configRow['localIds.length'];
    for (int i = 0; i < localIdsLength; i = i + 10) {
      gotoItems.add(PlutoMenuItem(
        title: i.toString(),
        onTap: () async {
          currentRowIndex = i;
          widget.swiperSetstate();
        },
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    gotoItemsBuild();
    whiteTapMenus = _makeMenus(context);
  }

  Future getData() async {}

  void message(context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<PlutoMenuItem> _makeMenus(BuildContext context) {
    return [
      //---------------------------------------------------file
      PlutoMenuItem(
        title: 'File',
        children: [
          PlutoMenuItem(
            title: 'Open source document',
            icon: Icons.open_in_browser,
            onTap: () async {
              await al.openDoc(
                  widget.configRow['fileUrl'], context, 'Open data source');
            },
          ),
          PlutoMenuItem(
            title: 'Import/export',
            icon: Icons.open_in_browser,
            onTap: () async {
              showExportDialog(context);
            },
          ),
        ],
      ),
      //---------------------------------------------------Edit
      PlutoMenuItem(
        title: 'Edit',
        children: [
          PlutoMenuItem(
            title: 'Copy row',
            icon: Icons.copy_all,
            onTap: () async {
              String res = const ListToCsvConverter().convert([
                [',b', 3.1, 42],
                ['n\n']
              ]);
              List<String> row = [
                'ID?',
                widget.rowmap['sheetName'],
                widget.rowmap['ID']
              ];
              for (var element in widget.rowmap.entries) {
                if (element.key == 'ID') continue;
                row.add('${element.value}');
              }
              const conv = ListToCsvConverter(fieldDelimiter: '|');
              res = conv.convert([row]);
              FlutterClipboard.copy(res).then((value) => {});
            },
          ),
          PlutoMenuItem(
            title: 'Import/export',
            icon: Icons.open_in_browser,
            onTap: () async {
              showExportDialog(context);
            },
          ),
        ],
      ),

      PlutoMenuItem(
        title: 'GoTo',
        children: gotoItems,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: getData(), // async work
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasError) {
          return Text('DetailPage\n\n Error: ${snapshot.error}');
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                PlutoMenuBar(
                  mode: PlutoMenuBarMode.tap,
                  backgroundColor: const Color.fromARGB(255, 193, 218, 230),
                  menus: whiteTapMenus,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Future<void> showExportDialog(BuildContext context) async {
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          // <-- SEE HERE
          title: const Text('Select Booking Type'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('General'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Silver'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Gold'),
            ),
          ],
        );
      });
}

//----------------------------------------------------------------row menu
PopupMenuButton rowItemRightPopup(BuildContext context, String clipContent) {
  return PopupMenuButton(
      // add icon, by default "3 dot" icon
      // icon: Icon(Icons.book)
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: IconButton(
              tooltip: 'Copy current cell',
              icon: const Icon(Icons.copy),
              onPressed: () async {
                Navigator.pop(context);
                FlutterClipboard.copy(clipContent).then((value) => {});
              },
            ),
          ),
        ];
      },
      onSelected: (value) {});
}
