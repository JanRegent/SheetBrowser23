// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

import 'cols.dart';

class MenuGridPage extends StatefulWidget {
  const MenuGridPage({
    super.key,
  });

  @override
  State<MenuGridPage> createState() => _MenuGridPageState();
}

class _MenuGridPageState extends State<MenuGridPage> {
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

  List<PlutoMenuItem> _makeMenus(BuildContext context) {
    return [
      //---------------------------------------------------------Detail
      PlutoMenuItem(
        title: 'Detail',
        icon: Icons.list,
        children: [
          PlutoMenuItem(
            icon: Icons.add,
            title: 'Add filtered to detail view',
            onTap: () {},
          ),
          PlutoMenuItem(
            icon: Icons.list,
            title: 'Detail view',
            onTap: () {},
          ),
        ],
      ),

      //---------------------------------------------------------filters
      PlutoMenuItem(
        title: 'Filters',
        icon: Icons.filter,
        children: [
          PlutoMenuItem(
            title: 'Save current filter',
            onTap: () {
              try {
                List<Map> filters = getFilteredList();
                Map filt = filters[0];
                String filtKey =
                    '${filt["columnName"]} ${filt["operator"]} ${filt["value"]}';
                print(filtKey);
              } catch (_) {}
            },
          ),
          PlutoMenuItem(
            title: 'Saved filters',
            icon: Icons.group,
            onTap: () {},
            children: [
              PlutoMenuItem(
                title: 'Menu 1-1-2',
                onTap: () => message(context, 'Menu 1-1-2 tap'),
              ),
            ],
          ),
        ],
      ),

      //---------------------------------------------------------views
      PlutoMenuItem(
        title: 'Views',
        icon: Icons.view_agenda,
        children: [
          PlutoMenuItem(
            title: 'Save current view',
            onTap: () {},
          ),
          PlutoMenuItem(
            title: 'Saved views',
            icon: Icons.group,
            onTap: () {},
            children: [
              PlutoMenuItem(
                title: 'view 1-1-2',
                onTap: () => message(context, 'view 1-1-2 tap'),
              ),
            ],
          )
        ],
      ),

      //---------------------------------------------------------export
      PlutoMenuItem(
        title: 'Export',
        icon: Icons.import_export,
        children: [
          PlutoMenuItem(
            icon: Icons.picture_as_pdf,
            title: 'PDF',
            onTap: () {},
          ),
          PlutoMenuItem(
            icon: Icons.cleaning_services,
            title: 'CSV comma,',
            onTap: () {},
          ),
          PlutoMenuItem(
            icon: Icons.self_improvement,
            title: 'CSV semicolon;',
            onTap: () {},
          ),
          PlutoMenuItem(
            icon: Icons.explicit,
            title: 'Excel',
            onTap: () {},
          )
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
            itemStyle: const PlutoMenuItemStyle(
              enableSelectedTopMenu: true,
            ),
            menus: whiteTapMenus,
          ),
        ],
      ),
    );
  }
}
