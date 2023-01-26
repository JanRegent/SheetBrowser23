// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../2business_layer/getdata.dart';
import '../views/detail/carousel.dart';

///
///https://pub.dev/packages/multiple_search_selection/example
///
///

// ignore: must_be_immutable
class TagSelectPage extends StatefulWidget {
  final List<String> keysNames;
  final String title;
  const TagSelectPage(this.keysNames, this.title, {Key? key}) : super(key: key);

  @override
  State<TagSelectPage> createState() => _TagSelectPageState();
}

class _TagSelectPageState extends State<TagSelectPage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController textEditingController = TextEditingController();

  SearchableList searchableKeyListview() {
    return SearchableList<String>(
      initialList: widget.keysNames,
      builder: (String keyName) => ListTile(
          title: Row(
        children: [
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  textEditingController.text = keyName;
                });
              },
              child: Text(keyName)),
        ],
      )),
      filter: (value) => widget.keysNames
          .where(
            (element) => element.toLowerCase().contains(value),
          )
          .toList(),
      searchTextController: textEditingController,
      inputDecoration: InputDecoration(
        labelText: "Search key or click",
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () async {
                  await rowsOfTag(textEditingController.text);
                  Map filelistRow = {};
                  filelistRow['sheetName'] =
                      'Tag: ${textEditingController.text}';
                  // ignore: use_build_context_synchronously
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => Carousel(const [
                          'tag',
                          'sourceSheetName',
                          'targetSheetID',
                          'targetFileUrl',
                          'ID'
                        ], tagRows, true, filelistRow, 0),
                      ));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: searchableKeyListview());
  }
}
