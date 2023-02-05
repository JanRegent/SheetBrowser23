import 'package:flutter/material.dart';

import '../../2business_layer/models/sheetdb/sheetdb.dart';
import '../alib/alib.dart';
import '../alib/keysselectpage.dart';
import '../views/detail/carousel.dart';

Future searchFlow(
    BuildContext context, List<String> keys4hint, String title) async {
  String keySelected = '';
  try {
    keySelected = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => KeySelectPage(keys4hint, title),
        ));
  } catch (_) {
    keySelected = '';
  }
  if (keySelected.isEmpty) return;

  List<Map> rowsMaps = await sheetDb.readFullText(keySelected);

  if (rowsMaps.isEmpty) {
    // ignore: use_build_context_synchronously
    al.message(context, 'Nothing found');
    return;
  }
  Map configRow = {};
  configRow['title'] = 'Search word: $keySelected';
  // ignore: use_build_context_synchronously
  await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Carousel(rowsMaps, configRow, 0),
      ));
}
