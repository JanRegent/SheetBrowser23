// ignore_for_file: file_names

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'package:parsed_readmore/parsed_readmore.dart';

import '../../../alib/alib.dart';
//ccc

class RowmapDetailPage extends StatefulWidget {
  final Map rowmap;
  const RowmapDetailPage(this.rowmap, {Key? key}) : super(key: key);

  @override
  State<RowmapDetailPage> createState() => _RowmapDetailPageState();
}

class _RowmapDetailPageState extends State<RowmapDetailPage> {
  TextEditingController textEditingController = TextEditingController();
  List<Widget> listWidgets = [];
  List<Widget> listWidgetsDev = [];
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();

    super.initState();
  }

  Future devInfo() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("DevInfo"),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return SimpleDialogOption(
                    onPressed: () => Navigator.pop(context),
                    child: Center(
                      child: listWidgetsDev[index],
                    ),
                  );
                },
                itemCount: listWidgetsDev.length,
              ),
            )
          ],
        );
      },
    );
  }

  Future userInfo(String mode) async {
    List<Widget> listWidgetsInfo = [
      ListTile(leading: const Text('mode:'), title: Text(mode)),
      const ListTile(leading: Text('filter:'), title: Text(''))
    ];
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Info"),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return SimpleDialogOption(
                    onPressed: () => Navigator.pop(context),
                    child: Center(
                      child: listWidgetsInfo[index],
                    ),
                  );
                },
                itemCount: listWidgetsInfo.length,
              ),
            )
          ],
        );
      },
    );
  }

  ElevatedButton infoButton(String mode) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.info),
        label: const Text(''),
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(60, 30), backgroundColor: Colors.lightBlue),
        onPressed: () async {
          await userInfo(mode);
        },
        onLongPress: () async {
          await devInfo();
        });
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

  Future<List<Widget>> getListviewItems(BuildContext context) async {
    listWidgets.clear();
    listWidgetsDev.clear();

    void key2listWidget(String key, List<Widget> list) {
      list.add(const Text('  '));
      list.add(const Text('  '));

      String value = '';
      try {
        // ignore: unnecessary_string_interpolations
        value = widget.rowmap['$key'];
      } catch (_) {
        value = '';
      }

      // ignore: unnecessary_string_interpolations
      String text = widget.rowmap['$key'].toString().trim();

      if (text.isNotEmpty) {
        list.add(ListTile(
          leading: Text(key),
          // ignore: unnecessary_string_interpolations
          trailing: rowItemRightPopup(context, value),
        ));
        //todo tags-highlightingt
        list.add(ParsedReadMore(
          text,
          urlTextStyle: const TextStyle(
              color: Colors.green,
              fontSize: 20,
              decoration: TextDecoration.underline),
          trimMode: TrimMode.line,
          trimLines: 4,
          delimiter: '  ***',
          delimiterStyle: const TextStyle(color: Colors.black, fontSize: 20),
          style: const TextStyle(color: Colors.black, fontSize: 20),
          trimCollapsedText: 'expand',
          trimExpandedText: 'compress',
          moreStyle: const TextStyle(color: Colors.red, fontSize: 20),
          lessStyle: const TextStyle(color: Colors.blue, fontSize: 20),
        ));
      }
    }

    //listWidgetsDev.add(ListTile(
    //     leading: const Text('userConfig'),
    //     title: al.linkIconOpenDoc(viewSetting.getMapFileId(), context)));
    // listWidgetsDev.add(ListTile(
    //     leading: const Text('dataSheet'),
    //     title: al.linkIconOpenDoc(sheetRowsDb.currentRow.aSheetName, context)));

    for (var key in widget.rowmap.keys) {
      if (key == 'ID') {
        listWidgetsDev.add(ListTile(
          leading: const Text('sheetRow ID'),
          title: Text(widget.rowmap['ID']),
          trailing: rowItemRightPopup(context, widget.rowmap['ID']),
        ));

        continue;
      }
      key2listWidget(key, listWidgets);
    }

    listWidgetsDev.add(ListTile(
      leading: const Text('localDb Id'),
      title: Text(widget.rowmap['ID']),
      trailing: rowItemRightPopup(context, widget.rowmap['ID']),
    ));

    return listWidgets;
  }

  Widget listViewBody() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey[50],
        child: ListView(
          controller: _controller,
          children: listWidgets,
        ));
  }

  PopupMenuButton sheetRightPopup(BuildContext context, Map row) {
    return PopupMenuButton(
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
        itemBuilder: (context) {
          return [
            // PopupMenuItem<int>(
            //   value: 0,
            //   child: al.linkSheetNameOpenUrl(
            //       sheetRowsDb.currentRow.aSheetName, context),
            // ),
            PopupMenuItem<int>(
              value: 0,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.star),
                onPressed: () {
                  Navigator.pop(context);
                  //starred.setStar(sheetRowsDb.currentRow);
                  al.message(context, 'Added to starred');
                },
                onLongPress: () {
                  //todo open sheet
                },
                label: const Text(''),
              ),
            ),
            PopupMenuItem<int>(
              value: 0,
              child: ElevatedButton.icon(
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
            ),
            PopupMenuItem<int>(
              value: 0,
              child: ElevatedButton.icon(
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
            ),
            PopupMenuItem<int>(
              value: 0,
              child: ElevatedButton.icon(
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
            ),
          ];
        },
        onSelected: (value) {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          infoButton('dev'),
          sheetRightPopup(context, widget.rowmap)
        ]),
        body: FutureBuilder<List<Widget>>(
          future: getListviewItems(context), // async work
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Column(
                  children: const [
                    Text('Row detail loading'),
                    Text(' '),
                    CircularProgressIndicator()
                  ],
                );

              default:
                if (snapshot.hasError) {
                  return Text('RowDetailPage\n\n Error: ${snapshot.error}');
                } else {
                  return listViewBody();
                }
            }
          },
        ));
  }
}
