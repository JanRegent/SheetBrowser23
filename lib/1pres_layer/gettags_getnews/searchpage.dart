// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:sheetbrowser/data_layer/isloading/isloading.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/sheetdb.dart';

import '../alib/uti.dart';
import '../views/detail/carousel.dart';

///
///https://pub.dev/packages/multiple_search_selection/example
///
///

// ignore: must_be_immutable
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
          isDataLoading.value = true;
          List<Map> rowsMaps =
              await sheetDb.readNews(textEditingController.text);
          isDataLoading.value = false;
          Map configRow = {};
          configRow['title'] = 'New: ${textEditingController.text}';
          // ignore: use_build_context_synchronously
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => Carousel(rowsMaps, configRow, 0),
              ));
        },
        icon: const Icon(Icons.search));
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isDataLoading.value
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
      ),
      body: Obx(() => isDataLoading.value
          ? isloadingWidgetColumn(
              'Awaiting search results...\n (${textEditingController.text}) \n ${isloadingPhaseMessage.value}')
          : searchableKeyListview()),

      //searchableKeyListview()
    );
  }
}
