// ignore_for_file: file_names

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';

import '../alib/alib.dart';
import '../alib/uti.dart';
import '../_home/views/detail/cardswiper.dart';

///
///https://pub.dev/packages/multiple_search_selection/example
///
///

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> keysNames = [];

  @override
  void initState() {
    super.initState();
    keysNames = blUti.lastNdays(5);
    textEditingController.addListener(searchTextChanged);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    textEditingController.dispose();
    super.dispose();
  }

  void searchTextChanged() {
    setState(() {});
  }

  TextEditingController textEditingController = TextEditingController();

  SearchableList searchableKeyListview() {
    return SearchableList<String>(
      initialList: keysNames,
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
      filter: (value) => keysNames
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
          List<int> localIds =
              await sheetDb.readOps.readSearch(textEditingController.text);

          Map configRow = {};
          configRow['title'] = textEditingController.text;
          // ignore: use_build_context_synchronously
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => CardSwiper(localIds, configRow),
              ));
        },
        icon: const Icon(Icons.search));
  }

  IconButton searchRels2clipboard() {
    return IconButton(
        onPressed: () async {
          if (textEditingController.text.trim().isEmpty) {
            al.message(context, 'Text is empty');
            return;
          }
          String csv = await sheetDb.readOps
              .readSearch2selSheet(textEditingController.text);
          FlutterClipboard.copy(csv).then((value) => {});
          // ignore: use_build_context_synchronously
          al.message(context,
              'Data in clipboard. Use "Paste special" at empty sheet: ${textEditingController.text}');
        },
        icon: const Icon(Icons.search_sharp));
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  textEditingController.text.length > 1
                      ? const Text('')
                      : const Text('Day or word?  '),
                  textEditingController.text.length < 2
                      ? const Text('')
                      : searchButton()
                ],
              ),
        actions: [searchRels2clipboard()],
      ),
      body: isLoading
          ? const Text('Awaiting search results...')
          : searchableKeyListview(),

      //searchableKeyListview()
    );
  }
}
