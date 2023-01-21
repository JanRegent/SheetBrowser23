import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:sheetbrowse/1pres_layer/alib/uti.dart';
import 'package:sheetbrowse/data_layer/getsheetdl.dart';

import '../../alib/alib.dart';

Widget firstButtons(Map rowmap, Map configMap, BuildContext context) {
  return Row(
    children: [
      ElevatedButton.icon(
        icon: const Icon(Icons.star),
        onPressed: () async {
          List<String> starredLink = [
            'sheetName|${configMap['sheetName']}',
            'ID|${rowmap['ID']}',
            'fileId|${blUti.url2fileid(configMap['fileUrl'])}',
          ];

          await GoogleSheetsDL(sheetId: '', sheetName: '')
              .starredAppend(starredLink.join('__|__'));

          // ignore: use_build_context_synchronously
          al.message(context, 'Added to starred');
        },
        onLongPress: () {
          //todo open sheet
        },
        label: const Text(''),
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.bookmark_add),
        onPressed: () async {
          // Navigator.pop(context);
          // await filelistContr.bookmarkSheetIDset(row['ID']);
        },
        onLongPress: () {
          //todo open sheet
        },
        label: const Text(''),
      ),
      //---------------------------------------------other menu
      PopupMenuButton(
        itemBuilder: (context) {
          return <PopupMenuItem>[
            PopupMenuItem(
              child: al.linkIconOpenDoc(
                  configMap['fileUrl'], context, 'Open source sheet'),
            ),
            PopupMenuItem(
              child: PopupMenuItem(
                  value: 0,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.copy_all),
                    label: const Text('Copy all row'),
                    onPressed: () {
                      Navigator.pop(context);
                      al.message(context, 'Copy all row dialog');
                    },
                    onLongPress: () {
                      //todo open sheet
                    },
                  )),
            ),
            PopupMenuItem(
              value: 0,
              child: ElevatedButton.icon(
                label: const Text('Import/export '),
                icon: const Icon(Icons.import_export),
                onPressed: () {
                  Navigator.pop(context);
                  al.message(context, 'Import/export dialog');
                },
                onLongPress: () {
                  //todo open sheet
                },
              ),
            )
          ];
        },
        child: const Icon(
          Icons.menu,
          color: Colors.lightBlue,
        ),
      ),
    ],
  );
}
//----------------------------------------------------------------page menu

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
