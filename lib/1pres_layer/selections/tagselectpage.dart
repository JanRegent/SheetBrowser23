// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../2business_layer/models/sheetdb/_sheetdb.dart';
import '../views/detail/cardswiper.dart';

///
///https://pub.dev/packages/multiple_search_selection/example
///
///

// ignore: must_be_immutable
class TagSelectPage extends StatefulWidget {
  const TagSelectPage({Key? key}) : super(key: key);

  @override
  State<TagSelectPage> createState() => _TagSelectPageState();
}

class _TagSelectPageState extends State<TagSelectPage> {
  @override
  void initState() {
    super.initState();
  }

  List<String> tags = [];
  Future<String> getDataTags() async {
    tags = await sheetDb.readOps.readTags();
    return 'OK';
  }

  TextEditingController textEditingController = TextEditingController();

  SearchableList searchableKeyListview() {
    return SearchableList<String>(
      initialList: tags,
      builder: (String keyName) => ListTile(
          title: Row(
        children: [
          ElevatedButton(
              onPressed: () async {
                textEditingController.text = keyName;
                await showTags();
              },
              child: Text(keyName)),
        ],
      )),
      filter: (value) => tags
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

  Future showTags() async {
    List<int> ids =
        await sheetDb.readOps.readRowsTag(textEditingController.text);

    Map configRow = {};
    configRow['title'] = 'Tag: ${textEditingController.text}';
    // ignore: use_build_context_synchronously
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => CardSwiper(ids, configRow),
        ));
  }

  // IconButton searchButton() {
  //   return IconButton(
  //       onPressed: () async {
  //         await showTags();
  //       },
  //       icon: const Icon(Icons.search));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Select tag')),
        body: FutureBuilder<String>(
            future: getDataTags(), // async work
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Column(
                    children: const [
                      Text('Tags loading'),
                      Text(' '),
                      CircularProgressIndicator()
                    ],
                  );

                default:
                  if (snapshot.hasError) {
                    return Text('DetailPage\n\n Error: ${snapshot.error}');
                  } else {
                    return searchableKeyListview();
                  }
              }
            }));
  }
}
