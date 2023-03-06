// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';

import '../../2business_layer/appdata/approotdata.dart';
import '../alib/uti.dart';
import '../views/detail/cardswiper.dart';

///
///https://pub.dev/packages/multiple_search_selection/example
///
///

void fulltextDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search by'),
          content: const Text(''),
          actions: [
            ElevatedButton(
                child: const Text('cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
              child: const Text('date'),
              onPressed: () async {
                Navigator.of(context).pop();
                List<String> keysNames = blUti.lastNdays(5);
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => SearchPage('date', keysNames),
                    ));
              },
            ),
            ElevatedButton(
              child: const Text('word'),
              onPressed: () async {
                String keyNamesStr =
                    await appData.appDataGetString('fulltextHintWords');
                List<String> keysNames = keyNamesStr.split(',');
                // ignore: use_build_context_synchronously
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => SearchPage('word', keysNames),
                    ));
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

class SearchPage extends StatefulWidget {
  final String byDateWords;
  final List<String> keysNames;
  const SearchPage(this.byDateWords, this.keysNames, {Key? key})
      : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();

    widget.keysNames.insert(0, '__search__');
    textEditingController.addListener(searchTextChanged);
    try {
      textEditingController.text = widget.keysNames[1];
    } catch (_) {
      textEditingController.text = '';
    }
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
      initialList: widget.keysNames,
      builder: (String keyName) => ListTile(
          title: Row(
        children: [
          keyName == '__search__'
              ? searchButton()
              : ElevatedButton(
                  onPressed: () async {
                    await fulltextSearch(keyName);
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
        labelText: "Write date or click date buttons",
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

  Future fulltextSearch(String fulltextValue) async {
    List<int> localIds = await sheetDb.readOps.readSearch(fulltextValue);

    Map configRow = {};
    configRow['title'] = fulltextValue;
    // ignore: use_build_context_synchronously
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => CardSwiper(localIds, configRow),
        ));
  }

  IconButton searchButton() {
    return IconButton(
        onPressed: () async {
          await fulltextSearch(textEditingController.text);
        },
        icon: const Icon(Icons.search));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fulltext search by ${widget.byDateWords}'),
      ),
      body: searchableKeyListview(),

      //searchableKeyListview()
    );
  }
}
