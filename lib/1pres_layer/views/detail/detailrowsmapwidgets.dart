import 'package:flutter/material.dart';

import 'package:parsed_readmore/parsed_readmore.dart';

import 'detailmenu.dart';

Future<List<Widget>> rowmapWidgetsGet(
    BuildContext context, Map rowmap, Map configRow, int localId) async {
  List<Widget> rowmapWidgets = [];

  void key2listWidget(String key, List<Widget> list, bool isFirstKey) {
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

    Function(bool val)? expand;

    Widget valueText(String text) {
      return ParsedReadMore(
        text,
        urlTextStyle: const TextStyle(
            color: Colors.green,
            fontSize: 20,
            decoration: TextDecoration.underline),
        trimMode: TrimMode.line,
        textAlign: TextAlign.left,
        trimLines: 10,
        delimiter: '  ...',
        delimiterStyle: const TextStyle(color: Colors.black, fontSize: 20),
        style: const TextStyle(color: Colors.black, fontSize: 20),
        trimCollapsedText: '↓',
        trimExpandedText: '↑',
        moreStyle: const TextStyle(color: Colors.red, fontSize: 20),
        lessStyle: const TextStyle(color: Colors.blue, fontSize: 20),
        callback: expand,
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
    if (key == 'sheetName') continue;
    if (key == 'ID') continue;
    if (key == 'dateinsert') continue;

    key2listWidget(key, rowmapWidgets, key == rowmap.keys.first);
  }
  rowmapWidgets.add(ListTile(
      leading: const Text('ID_row'),
      title: Text(
          "${rowmap['sheetName']},${rowmap['ID']},${rowmap['dateinsert']}")));
  return rowmapWidgets;
}
