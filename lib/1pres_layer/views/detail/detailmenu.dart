import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';

import '../../../2business_layer/appdata/approotdata.dart';
import '../../../2business_layer/models/sheetdb/rowmap.dart';
import '../../alib/alib.dart';

// ignore: must_be_immutable
class DetailMenu extends StatefulWidget {
  final Map rowmap;
  final Map configMap;
  final int rowsArrRowIx;
  Function setStateCallback;
  DetailMenu(
    this.rowmap,
    this.configMap,
    this.rowsArrRowIx,
    this.setStateCallback, {
    super.key,
  });

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  late final List<PlutoMenuItem> whiteTapMenus;

  @override
  void initState() {
    super.initState();

    whiteTapMenus = _makeMenus(context);
  }

  void message(context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  RxString starTitle = ''.obs;

  List<PlutoMenuItem> _makeMenus(BuildContext context) {
    starTitle.value = '';
    try {
      starTitle.value = starsMap[int.tryParse(widget.rowmap['ID'])]!;
    } catch (_) {
      starTitle.value = '';
    }
    return [
      //-----------------------------------------------------file
      PlutoMenuItem(
        title: 'File',
        children: [
          PlutoMenuItem(
            title: 'Open source document',
            icon: Icons.open_in_browser,
            onTap: () async {
              await al.openDoc(
                  widget.rowmap['fileUrl'], context, 'Open data source');
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
      //-----------------------------------------------------Edit
      PlutoMenuItem(
        title: 'Edit',
        children: [
          PlutoMenuItem(
            title: 'Copy all row',
            icon: Icons.copy_all,
            onTap: () async {
              message(context, 'Copy all row');
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
      //------------------------------------------------star
      PlutoMenuItem(
        title: 'Star',
        icon: Icons.stars,
        children: [
          PlutoMenuItem(title: starTitle.value),
          PlutoMenuItemDivider(),
          PlutoMenuItem(
            title: '',
            icon: Icons.add,
            onTap: () async {
              int? sheetID = int.tryParse(widget.rowmap['ID']);
              starsMap[sheetID!] = await sheetDb.starredBL
                  .addStar(widget.rowmap['sheetName'], sheetID);
              starTitle.value = starsMap[sheetID]!;
              widget.setStateCallback();
            },
          ),
          PlutoMenuItem(
            title: '',
            icon: Icons.exposure_minus_1,
            onTap: () async {
              int? sheetID = int.tryParse(widget.rowmap['ID']);
              if (sheetID == null) return;
              starsMap[sheetID] = await sheetDb.starredBL
                  .minusStar1(widget.rowmap['sheetName'], sheetID);
              starTitle.value = starsMap[sheetID]!;
              widget.setStateCallback();
            },
          ),
          PlutoMenuItem(
            title: '',
            icon: Icons.clear,
            onTap: () async {
              int? sheetID = int.tryParse(widget.rowmap['ID']);
              await sheetDb.starredBL
                  .clearStars(widget.rowmap['sheetName'], sheetID!);
              starsMap[sheetID] = '';
              starTitle.value = starsMap[sheetID]!;
              widget.setStateCallback();
            },
          )
        ],
      ),

      PlutoMenuItem(
        title: 'Bookmark',
        icon: Icons.bookmark,
        children: [
          PlutoMenuItem(
            title: 'Add',
            icon: Icons.bookmark_add,
            onTap: () => AppDataPrefs.setString(
                widget.rowmap['sheetName'] + '__bookmark',
                widget.rowsArrRowIx.toString()),
          ),
        ],
      ),
      PlutoMenuItem(
        title: 'Menu 3',
        icon: Icons.apps_outlined,
        onTap: () => message(context, 'Menu 3 tap'),
      ),
      PlutoMenuItem(
        title: 'Menu 4',
        onTap: () => message(context, 'Menu 4 tap'),
      ),
      PlutoMenuItem(
        title: 'Menu 5',
        onTap: () => message(context, 'Menu 5 tap'),
      ),
      PlutoMenuItem(
        title: 'Menu 6',
        children: [
          PlutoMenuItem(
            title: 'Menu 6-1',
            onTap: () => message(context, 'Menu 6-1 tap'),
            children: [
              PlutoMenuItem(
                title: 'Menu 6-1-1',
                onTap: () => message(context, 'Menu 6-1-1 tap'),
                children: [
                  PlutoMenuItem(
                    title: 'Menu 6-1-1-1',
                    onTap: () => message(context, 'Menu 6-1-1-1 tap'),
                  ),
                  PlutoMenuItem(
                    title: 'Menu 6-1-1-2',
                    onTap: () => message(context, 'Menu 6-1-1-2 tap'),
                  ),
                ],
              ),
              PlutoMenuItem(
                title: 'Menu 6-1-2',
                onTap: () => message(context, 'Menu 6-1-2 tap'),
              ),
            ],
          ),
          PlutoMenuItem(
            title: 'Menu 6-2',
            onTap: () => message(context, 'Menu 6-2 tap'),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
