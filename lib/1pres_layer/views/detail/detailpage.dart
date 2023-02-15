// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:parsed_readmore/parsed_readmore.dart';

import '../../../2business_layer/models/sheetdb/_sheetdb.dart';
import 'detailmenu.dart';

class DetailPage extends StatefulWidget {
  final int localIdOfSheetDb;
  final Map configRow;
  const DetailPage(this.localIdOfSheetDb, this.configRow, {Key? key})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  setStateCallback() {
    setState(() {});
  }

  Map rowmap = {};

  Future<List<Widget>> getDataListviewItems(BuildContext context) async {
    List<Widget> listWidgets = [];
    rowmap = await sheetDb.rowMap.row2MapLocalId(widget.localIdOfSheetDb);

    listWidgets.add(DetailMenu(rowmap, widget.configRow, setStateCallback));
    Icon starredIcon = const Icon(Icons.star_border);
    try {
      int idExists = await sheetDb.starredBL
          .starExists(rowmap['sheetName'], int.tryParse(rowmap['ID'])!);
      if (idExists > -1) {
        starredIcon = const Icon(Icons.star);
      }
    } catch (_) {}
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

      list.add(ListTile(
        leading: Text(
          key,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        title: isFirstKey
            ? Row(
                children: [starredIcon],
              )
            : null,
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
        delimiter: '  ...',
        delimiterStyle: const TextStyle(color: Colors.black, fontSize: 20),
        style: const TextStyle(color: Colors.black, fontSize: 20),
        trimCollapsedText: '↓',
        trimExpandedText: '↑',
        moreStyle: const TextStyle(color: Colors.red, fontSize: 20),
        lessStyle: const TextStyle(color: Colors.blue, fontSize: 20),
      ));
      //list.add(const Text('  '));
    }

    for (String key in rowmap.keys) {
      key2listWidget(key, listWidgets, key == rowmap.keys.first);
    }
    return listWidgets;
  }

  Widget listViewBody(List<Widget> listWidgets) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey[50],
        child: ListView.separated(
            itemCount: listWidgets.length,
            controller: scrollController,
            separatorBuilder: (context, index) {
              return index.floor().isEven
                  ? Divider(
                      color: Theme.of(context).primaryColor,
                    )
                  : const Text(' ');
            },
            itemBuilder: (context, index) {
              return listWidgets[index];
            }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: getDataListviewItems(context), // async work
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Column(
              children: [
                Text('Row detail loading for row: ${widget.localIdOfSheetDb}'),
                const Text(' '),
                const CircularProgressIndicator()
              ],
            );

          default:
            if (snapshot.hasError) {
              return Text('DetailPage\n\n Error: ${snapshot.error}');
            } else {
              return listViewBody(snapshot.data!);
            }
        }
      },
    );
  }
}
