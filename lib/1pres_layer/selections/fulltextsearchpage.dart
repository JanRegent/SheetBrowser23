// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';

import '../alib/uti.dart';
import '../views/detail/cardswiper.dart';

///
///https://pub.dev/packages/multiple_search_selection/example
///
///

class SearchPage extends StatefulWidget {
  final String byDateWords;
  const SearchPage(this.byDateWords, {Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> keysNames = [];

  @override
  void initState() {
    super.initState();

    keysNames = blUti.lastNdays(5);
    keysNames.insert(0, '__search__');
    textEditingController.addListener(searchTextChanged);
    textEditingController.text = blUti.todayStr();
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
          keyName == '__search__'
              ? searchButton()
              : ElevatedButton(
                  onPressed: () async {
                    await fulltextSearch(keyName);
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Fulltext search ${widget.byDateWords}'),
              pinned: true,
              floating: true,
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Icon(Icons.calendar_month)),
                  Tab(child: Icon(Icons.wordpress)),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            searchableKeyListview(),
            const Icon(Icons.directions_transit, size: 350),
          ],
        ),
      )),
    );
  }
}
