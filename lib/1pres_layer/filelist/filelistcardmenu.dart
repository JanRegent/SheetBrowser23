import 'package:flutter/material.dart';

import '../alib/alib.dart';

ListTile urlTile(String label, String url, BuildContext context) {
  return ListTile(
    leading: Text(label),
    title: label.startsWith('sheet')
        ? al.linkIconOpenDoc(url, context)
        : al.linkIconOpenUrlNoDoc(url, context),
  );
}

PopupMenuButton rightPopup(BuildContext context, Map filelistRow) {
  return PopupMenuButton(
      // add icon, by default "3 dot" icon
      // icon: Icon(Icons.book)
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: al.helpIcon(context),
          ),
          PopupMenuItem<int>(
              value: 1,
              child: urlTile('sheet url', filelistRow['fileUrl'], context)),
          PopupMenuItem<int>(
              value: 1,
              child: urlTile('source url', filelistRow['sourceUrl'], context)),
          PopupMenuItem<int>(
              value: 1,
              child: urlTile(
                  'copyright url', filelistRow['copyrightUrl'], context)),
          PopupMenuItem<int>(
              value: 1,
              child:
                  urlTile('AppSheet url', filelistRow['AppSheetUrl'], context)),
        ];
      },
      onSelected: (value) {});
}
