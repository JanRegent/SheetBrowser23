// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:sheetbrowser/1pres_layer/acontrolers/isloading.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb.dart';

import '../alib/uti.dart';
import '../views/detail/carousel.dart';

///
///https://pub.dev/packages/multiple_search_selection/example
///
///

// ignore: must_be_immutable
class NewsSelectPage extends StatefulWidget {
  const NewsSelectPage({Key? key}) : super(key: key);

  @override
  State<NewsSelectPage> createState() => _NewsSelectPageState();
}

class _NewsSelectPageState extends State<NewsSelectPage> {
  List<String> keysNames = [];

  @override
  void initState() {
    super.initState();
    keysNames = blUti.lastNdays(5);
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
          List newsRows = await sheetDb.readNews(textEditingController.text);
          isDataLoading.value = false;
          Map configRow = {};
          configRow['sheetName'] = 'News';
          configRow['title'] = 'New: ${textEditingController.text}';
          // ignore: use_build_context_synchronously
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => Carousel(
                    sheetDb.readNewsCols, newsRows, false, configRow, 0),
              ));
        },
        icon: const Icon(Icons.search));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          const Text('Day?  '),
          textEditingController.text.isEmpty ? const Text('') : searchButton()
        ],
      )),
      body: Obx(() => isDataLoading.value
          ? isloadingWidgetColumn(
              'Awaiting news...\n (${textEditingController.text}) \n ${phaseMessage.value}')
          : searchableKeyListview()),

      //searchableKeyListview()
    );
  }
}
