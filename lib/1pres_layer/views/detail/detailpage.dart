// ignore_for_file: file_names

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'package:parsed_readmore/parsed_readmore.dart';
import 'package:sheetbrowse/1pres_layer/alib/uti.dart';

import '../../../4data_layer/sheetget.dart';
import '../../alib/alib.dart';
//ccc

class DetailPage extends StatefulWidget {
  final Map rowmap;
  final bool askTag;
  const DetailPage(this.rowmap, this.askTag, {Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController textEditingController = TextEditingController();
  List<Widget> listWidgets = [];

  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();

    super.initState();
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

  Map rowmap = {};
  Future<List<Widget>> getDataListviewItems(BuildContext context) async {
    listWidgets.clear();

    rowmap = widget.rowmap;

    void key2listWidget(String key, List<Widget> list) {
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

      if (text.isNotEmpty) {
        list.add(ListTile(
          leading: Text(
            key,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
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
          textAlign: TextAlign.left,
          trimLines: 4,
          delimiter: '  ***',
          delimiterStyle: const TextStyle(color: Colors.black, fontSize: 20),
          style: const TextStyle(color: Colors.black, fontSize: 20),
          trimCollapsedText: 'expand',
          trimExpandedText: 'compress',
          moreStyle: const TextStyle(color: Colors.red, fontSize: 20),
          lessStyle: const TextStyle(color: Colors.blue, fontSize: 20),
        ));
        //list.add(const Text('  '));
      }
    }

    if (widget.askTag) {
      BLuti bLuti = BLuti();
      String fileId = bLuti.url2fileid(widget.rowmap['targetFileUrl']);
      rowmap = await getTagQuote(widget.rowmap['sourceSheetName'],
          widget.rowmap['targetSheetID'], fileId);
    }

    for (String key in rowmap.keys) {
      // ignore: unnecessary_null_comparison
      if (key == null) continue;
      key2listWidget(key, listWidgets);
    }

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
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: getDataListviewItems(context), // async work
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
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
              return Text('DetailPage\n\n Error: ${snapshot.error}');
            } else {
              return listViewBody();
            }
        }
      },
    );
  }
}
