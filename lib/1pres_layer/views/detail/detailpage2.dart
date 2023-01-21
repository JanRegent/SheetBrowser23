import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:sheetbrowse/1pres_layer/alib/uti.dart';
import 'package:sheetbrowse/data_layer/getsheetdl.dart';

import '../../alib/alib.dart';

Widget firstButtons(Map rowmap, Map configMap, BuildContext context) {
  return Row(
    children: [
      al.linkIconOpenDoc(configMap['fileUrl'], context),
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
        icon: const Icon(Icons.copy_all),
        onPressed: () {
          Navigator.pop(context);
          al.message(context, 'copy all row dialog');
        },
        onLongPress: () {
          //todo open sheet
        },
        label: const Text(''),
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.import_export),
        onPressed: () {
          Navigator.pop(context);
          al.message(context, 'inport/export dialog');
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
      )
    ],
  );
}

PopupMenuButton rowItemRightPopup(BuildContext context, String clipContent) {
  return PopupMenuButton(
      // add icon, by default "3 dot" icon
      // icon: Icon(Icons.book)
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
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
