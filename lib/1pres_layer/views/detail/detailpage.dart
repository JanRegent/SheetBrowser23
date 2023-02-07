// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:parsed_readmore/parsed_readmore.dart';

import 'detailmenu.dart';
//ccc

class DetailPage extends StatefulWidget {
  final Map rowmap;
  final Map configRow;
  final int rowsArrRowIx;
  const DetailPage(this.rowmap, this.configRow, this.rowsArrRowIx, {Key? key})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Widget> listWidgets = [];

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
    listWidgets.clear();

    listWidgets.add(DetailMenu(widget.rowmap, widget.configRow,
        widget.rowsArrRowIx, setStateCallback));
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
          delimiter: '  ...',
          delimiterStyle: const TextStyle(color: Colors.black, fontSize: 20),
          style: const TextStyle(color: Colors.black, fontSize: 20),
          trimCollapsedText: '-->',
          trimExpandedText: '<--',
          moreStyle: const TextStyle(color: Colors.red, fontSize: 20),
          lessStyle: const TextStyle(color: Colors.blue, fontSize: 20),
        ));
        //list.add(const Text('  '));
      }
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
          controller: scrollController,
          children: listWidgets,
        ));
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
