// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../2business_layer/models/sheetdb/_sheetdb.dart';
import 'detailpage.dart';

class Carousel extends StatefulWidget {
  final List<int> ids;
  final Map configRowFilelistRow;
  final int startRow;
  const Carousel(this.ids, this.configRowFilelistRow, this.startRow,
      {super.key});

  @override
  State<StatefulWidget> createState() {
    return CarouselState();
  }
}

class CarouselState extends State<Carousel> {
  final CarouselController carouselController = CarouselController();

  List<int> tabsList = [];
  late List<Widget> widgets;
  int _currentIndex = 0;

  Map rowmap = {};
  Map rowmapNext = {};
  Map rowmapPrev = {};

  Future<String> getDataRowMaps() async {
    rowmap = await sheetDb.rowMap.row2MapLocalId(widget.ids[_currentIndex]);
    return 'ok';
  }

  @override
  void initState() {
    super.initState();

    try {
      _currentIndex = widget.startRow;
    } catch (_) {
      _currentIndex = 0;
    }
  }

  Column body() {
    return Column(
      children: <Widget>[
        //https://pub.dev/packages/carousel_slider

        //Build item widgets on demand
        CarouselSlider.builder(
          itemCount: widget.ids.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    DetailPage(rowmap, widget.configRowFilelistRow),
                  ],
                )),
          ),

          //Text(itemIndex.toString()),
          options: CarouselOptions(
            initialPage: widget.startRow,
            enlargeCenterPage: true,
            height: MediaQuery.of(context).size.height - 100,
            onPageChanged: (index, reason) {
              //print(reason);
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          carouselController: carouselController,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: ElevatedButton(
                onPressed: () => carouselController.previousPage(),
                child: const Text('←'),
              ),
            ),
            Text(
              '$_currentIndex/${widget.ids.length}',
              style: const TextStyle(fontSize: 15),
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  _currentIndex = widget.ids.length ~/ 2;
                  carouselController.jumpToPage(_currentIndex);
                },
                child: Text((widget.ids.length ~/ 2).toString()),
              ),
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: () => carouselController.nextPage(),
                child: const Text('→'),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.configRowFilelistRow['title'])),
        body: FutureBuilder<String>(
          future: getDataRowMaps(), // async work
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Column(
                  children: [
                    Text('Preparing row $_currentIndex',
                        style: const TextStyle(fontSize: 18)),
                    const Text(' '),
                    const CircularProgressIndicator()
                  ],
                );

              default:
                if (snapshot.hasError) {
                  return Text('DetailPage\n\n Error: ${snapshot.error}');
                } else {
                  return body();
                }
            }
          },
        ));
  }
}
