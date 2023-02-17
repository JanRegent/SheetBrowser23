// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../views/detail/cardswiper.dart';

///
///https://pub.dev/packages/multiple_search_selection/example
///
///

// ignore: must_be_immutable
class TagSelectPage extends StatefulWidget {
  final List<String> tags;
  const TagSelectPage(this.tags, {Key? key}) : super(key: key);

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
      initialList: widget.tags,
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
      filter: (value) => widget.tags
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

  IconButton searchButton() {
    return IconButton(
        onPressed: () async {
          List<int> ids = [];
          // await tagsDb.readTagIds(textEditingController.text);

          Map configRow = {};
          configRow['title'] = 'Tag: ${textEditingController.text}';
          // ignore: use_build_context_synchronously
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => CardSwiper(ids, configRow),
              ));
        },
        icon: const Icon(Icons.search));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textEditingController.text.isEmpty
              ? const Text('Select tag')
              : searchButton(),
        ),
        body: searchableKeyListview());
  }
}
