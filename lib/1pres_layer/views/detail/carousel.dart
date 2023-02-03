// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'detailpage.dart';

class Carousel extends StatefulWidget {
  final List<List<dynamic>> colsHeaders;
  final List rowMaps;
  final Map configRow;
  final int startRow;
  const Carousel(this.colsHeaders, this.rowMaps, this.configRow, this.startRow,
      {super.key});

  @override
  State<StatefulWidget> createState() {
    return CarouselState();
  }
}

class CarouselState extends State<Carousel> {
  final CarouselController _controller = CarouselController();

  List<int> tabsList = [];
  late List<Widget> widgets;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    if (widget.configRow['title'] == null) {
      widget.configRow['title'] = widget.configRow['sheetName'];
    }

    try {
      _currentIndex = widget.startRow;
    } catch (_) {
      _currentIndex = 0;
    }

    tabsList = List.generate(widget.rowMaps.length, (index) {
      return index;
    });
    widgets = tabsList
        .map((rowIndex) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      DetailPage(
                          widget.rowMaps[rowIndex], widget.configRow, rowIndex)
                    ],
                  )),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.configRow['title'])),
        body: Column(
          children: <Widget>[
            CarouselSlider(
              items: widgets,
              options: CarouselOptions(
                initialPage: widget.startRow,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height - 100,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              carouselController: _controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => _controller.previousPage(),
                    child: const Text('←'),
                  ),
                ),
                Text(
                  '$_currentIndex/${widget.rowMaps.length}',
                  style: const TextStyle(fontSize: 15),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => _controller.nextPage(),
                    child: const Text('→'),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
