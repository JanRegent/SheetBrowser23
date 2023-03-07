// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../2business_layer/models/sheetdb/_sheetdb.dart';
import 'detailmenu.dart';

import 'detailtags.dart';

import 'detailrowsmapwidgets.dart';

class DetailPage extends StatefulWidget {
  final Map configRow;
  final VoidCallback swiperSetstate;
  const DetailPage(this.configRow, this.swiperSetstate, {Key? key})
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

  Future<List<Widget>> getDataListWidgets(BuildContext context) async {
    List<Widget> listWidgets = [];
    int localID = swiperLocalIds[startRowCardswiper];
    Map rowmap = await sheetDb.rowMap.row2MapLocalId(localID);
    listWidgets
        .add(DetailMenu(rowmap, widget.configRow, widget.swiperSetstate));

    // ignore: use_build_context_synchronously
    listWidgets.add(starTagsRow(context, localID, rowmap));
    // ignore: use_build_context_synchronously
    List<Widget> rowmapWidgets =
        // ignore: use_build_context_synchronously
        await rowmapWidgetsGet(context, rowmap, widget.configRow, localID);
    listWidgets.addAll(rowmapWidgets);
    return listWidgets;
  }

  //-------------------------------------------------------star
  Row starTagsRow(BuildContext context, localId, Map rowmap) {
    return Row(
      children: [
        Text(rowmap.keys.first),
        const Text('  '),
        rowmap['tags'].contains('*')
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
        const Text('  '),
        addTagsIcon(context, localId, rowmap)
      ],
    );
  }

  //-------------------------------------------------------tags
  void setStateCallback() {
    setState(() {});
  }

  IconButton addTagsIcon(BuildContext context, int id, Map rowmap) {
    return IconButton(
        onPressed: () => addTagsDialog(context, rowmap, id, setStateCallback),
        icon: const Icon(Icons.tag));
  }

  //------------------------------------------------------------
  Widget listViewBody(List<Widget> listWidgets) {
    List<int> sepIndexes = [1, 2, listWidgets.length - 2];
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey[50],
        child: ListView.separated(
            itemCount: listWidgets.length,
            controller: scrollController,
            separatorBuilder: (context, index) {
              return sepIndexes.contains(index)
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
      future: getDataListWidgets(context), // async work
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Column(
              children: [
                Text('Row detail loading for row: $startRowCardswiper'),
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
