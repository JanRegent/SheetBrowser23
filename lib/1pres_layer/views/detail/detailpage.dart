// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'listviewbuild.dart';

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
      future: getDataListviewItems(
          context, widget.configRow, widget.localIdOfSheetDb), // async work
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
