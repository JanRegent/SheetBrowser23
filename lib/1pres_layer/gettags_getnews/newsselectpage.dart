// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:sheetbrowse/1pres_layer/acontrolers/isloading.dart';
import 'package:sheetbrowse/data_layer/getsheetdl.dart';

import '../alib/uti.dart';
import '../views/detail/carousel.dart';
import '../views/plutogrid/_gridpage.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select day'),
        actions: [
          textEditingController.text.isEmpty
              ? const Text('')
              : IconButton(
                  onPressed: () async {
                    isDataLoading.value = true;
                    await GoogleSheetsDL(sheetId: '', sheetName: '')
                        .getNewsBuild(textEditingController.text);
                    await currentSheet.getSheet('getNews', '');
                    isDataLoading.value = false;
                    Map configRow = {};
                    configRow['sheetName'] = 'getNews';
                    configRow['title'] = 'New: ${textEditingController.text}';
                    // ignore: use_build_context_synchronously
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => Carousel(
                              blUti.toListString(currentSheet.colsHeader),
                              currentSheet.rowsArr,
                              false,
                              configRow),
                        ));
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      body: Obx(() => isDataLoading.value
          ? isloadingWidgetColumn(
              'Awaiting news...(${textEditingController.text})')
          : searchableKeyListview()),

      //searchableKeyListview()
    );
  }
}
