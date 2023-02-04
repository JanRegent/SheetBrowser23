import 'package:flutter/material.dart';

import '../alib/alib.dart';

PopupMenuButton rightPopup(BuildContext context) {
  return PopupMenuButton(
      // add icon, by default "3 dot" icon
      // icon: Icon(Icons.book)
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: al.helpIcon(context),
          ),
        ];
      },
      onSelected: (value) {});
}
