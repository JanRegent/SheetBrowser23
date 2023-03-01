// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../2business_layer/models/sheetdb/_sheetdb.dart';
import 'detailmenu.dart';
import '../../../data_layer/getsheetdl.dart';
import '../../alib/alib.dart';
import 'detailstartags.dart';

import 'detailrowsmapwidgets.dart';

class DetailPage extends StatefulWidget {
  final int localId;
  final Map configRow;
  const DetailPage(this.localId, this.configRow, {Key? key}) : super(key: key);

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

  Future<List<Widget>> getDataListviewItems(BuildContext context) async {
    List<Widget> listWidgets = [];
    Map rowmap = await sheetDb.rowMap.row2MapLocalId(widget.localId);
    listWidgets.add(DetailMenu(rowmap, widget.configRow));

    // ignore: use_build_context_synchronously
    listWidgets.add(starRow(context, widget.localId, rowmap));
    // ignore: use_build_context_synchronously
    List<Widget> rowmapWidgets = await rowmapWidgetsGet(
        context, rowmap, widget.configRow, widget.localId);
    listWidgets.addAll(rowmapWidgets);
    return listWidgets;
  }

  //-------------------------------------------------------star
  Row starRow(BuildContext context, localId, Map rowmap) {
    Widget starredWidget = const Icon(Icons.star_border);
    try {
      if (rowmap['tags'].contains('*')) {
        starredWidget = const Icon(Icons.star);
      } else {
        // ignore: use_build_context_synchronously
        starredWidget = addStarIcon(context, rowmap, localId);
      }
    } catch (_) {}
    return Row(
      children: [starredWidget, addTagsIcon(context, localId, rowmap)],
    );
  }

  IconButton addStarIcon(BuildContext context, Map rowmap, int localId) {
    return IconButton(
        onPressed: () async {
          String sheetName = rowmap['sheetName'];
          int? sheetID = int.tryParse(rowmap['ID']);
          await appendStarCommunity(sheetName, sheetID.toString());
          await sheetDb.updateOps.updateTags(localId, '*');
          setState(() {});
          // ignore: use_build_context_synchronously
          al.message(context, 'Added to starred');
        },
        icon: const Icon(Icons.star_border));
  }

  //-------------------------------------------------------tags
  IconButton addTagsIcon(BuildContext context, int id, Map rowmap) {
    return IconButton(
        onPressed: () => addTagsDialog(context, rowmap, id),
        icon: const Icon(Icons.tag));
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
                Text('Row detail loading for row: ${widget.localId}'),
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
