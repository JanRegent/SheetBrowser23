// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

import '../../alib/alib.dart';
import '../../filelist/filelistcard.dart';
import '../detail/cardswiper.dart';
import 'cols.dart';

List<int> filteredLocalIds = [];

class MenuGridPage extends StatefulWidget {
  final Map configRow;
  final String sheetName;
  const MenuGridPage(
    this.configRow,
    this.sheetName, {
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
            onTap: () {
              al.message(context, 'Adding to filtered rows');
              var filteredIDsVar = stateManager.refRows
                  .map((e) => e.cells['ID']!.value.toString());

              for (var element in filteredIDsVar) {
                try {
                  int? localId = int.tryParse(element);
                  filteredLocalIds.add(localId!);
                } catch (_) {}
              }
            },
          ),
          PlutoMenuItem(
            icon: Icons.list,
            title: 'Detail view',
            onTap: () async {
              if (filteredLocalIds.isEmpty) {
                widget.configRow['__bookmarkLastRowVisitSave__'] =
                    '__bookmarkLastRowVisitSave__';
                await detailViewAll(context, widget.configRow);
              } else {
                al.message(
                    context, 'Loading filtered rows of  ${widget.sheetName}');

                Map configRow = {};
                widget.configRow['__bookmarkLastRowVisitSave__'] = '';
                configRow['title'] = widget.sheetName;
                configRow['sheetName'] = widget.sheetName;
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => CardSwiper(filteredLocalIds, configRow),
                    ));
              }
            },
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
