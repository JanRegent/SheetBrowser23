import 'package:flutter/material.dart';
import 'package:sheetbrowse/1pres_layer/alib/uti.dart';
import 'package:sheetbrowse/data_layer/getsheetdl.dart';

import '../../alib/alib.dart';

Widget firstButtons(Map rowmap, Map configMap, BuildContext context) {
  return ElevatedButton.icon(
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
  );
}
