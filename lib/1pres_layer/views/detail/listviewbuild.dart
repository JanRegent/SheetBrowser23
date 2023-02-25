import 'package:flutter/material.dart';

import 'package:parsed_readmore/parsed_readmore.dart';

import '../../../2business_layer/models/sheetdb/_sheetdb.dart';
import '../../../data_layer/getsheetdl.dart';
import '../../alib/alib.dart';
import 'detailmenu.dart';

Map rowmap = {};

IconButton starrAdd(BuildContext context) {
  return IconButton(
      onPressed: () async {
        String sheetName = rowmap['sheetName'];
        int? sheetID = int.tryParse(rowmap['ID']);
        await appendStarCommunity(sheetName, sheetID.toString());
        //sheetDb.selsBL.appendStar(sheetName, sheetID!);

        // ignore: use_build_context_synchronously
        al.message(context, 'Added to starred');
      },
      icon: const Icon(Icons.star_border));
}

Future<List<Widget>> getDataListviewItems(
    BuildContext context, int localIdOfSheetDb, Map configRow) async {
  List<Widget> listWidgets = [];
  rowmap = await sheetDb.rowMap.row2MapLocalId(localIdOfSheetDb);

  listWidgets.add(DetailMenu(rowmap, configRow));
  Widget starredWidget = const Icon(Icons.star_border);
  try {
    if (rowmap['__isStar__'] as bool) {
      starredWidget = const Icon(Icons.star);
    } else {
      // ignore: use_build_context_synchronously
      starredWidget = starrAdd(context);
    }
  } catch (_) {}

  void key2listWidget(String key, List<Widget> list, bool isFirstKey) {
    if (key == '__isStar__') return;

    String value = '';
    try {
      // ignore: unnecessary_string_interpolations
      value = rowmap['$key'];
    } catch (_) {
      value = '';
    }

    String text = '';
    try {
      text = rowmap[key].toString().trim();
    } catch (_) {
      text = '';
    }

    if (text.isEmpty) return;

    Widget valueText(String text) {
      return ParsedReadMore(
        text,
        urlTextStyle: const TextStyle(
            color: Colors.green,
            fontSize: 20,
            decoration: TextDecoration.underline),
        trimMode: TrimMode.line,
        textAlign: TextAlign.left,
        trimLines: 4,
        delimiter: '  ...',
        delimiterStyle: const TextStyle(color: Colors.black, fontSize: 20),
        style: const TextStyle(color: Colors.black, fontSize: 20),
        trimCollapsedText: '↓',
        trimExpandedText: '↑',
        moreStyle: const TextStyle(color: Colors.red, fontSize: 20),
        lessStyle: const TextStyle(color: Colors.blue, fontSize: 20),
      );
    }

    ListTile firstRow(String text) {
      return ListTile(
        leading: Text(
          key,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        title: Row(
          children: [starredWidget],
        ),
        trailing: rowItemRightPopup(context, value),
      );
    }

    ListTile rowAddTo50(String text) {
      return ListTile(
        leading: Text(
          key,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        title: valueText(text),
        trailing: rowItemRightPopup(context, value),
      );
    }

    ListTile rowUp50(String text) {
      return ListTile(
        leading: Text(
          key,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        title: valueText(text),
        trailing: rowItemRightPopup(context, value),
      );
    }

    if (isFirstKey) {
      list.add(firstRow(text));
      list.add(valueText(text));
      return;
    }
    if (text.length > 50) {
      list.add(rowUp50(text));
    } else {
      list.add(rowAddTo50(text));
    }
  }

  for (String key in rowmap.keys) {
    key2listWidget(key, listWidgets, key == rowmap.keys.first);
  }
  return listWidgets;
}