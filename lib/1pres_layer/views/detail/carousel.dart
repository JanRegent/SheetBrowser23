// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../2business_layer/getdata.dart';
import 'detailpage.dart';

class Carousel extends StatefulWidget {
  final List<String> colsHeader;
  final List sheetArr;
  final bool askTags;
  final Map configRow;
  const Carousel(this.colsHeader, this.sheetArr, this.askTags, this.configRow,
      {super.key});

  @override
  State<StatefulWidget> createState() {
    return CarouselState();
  }
}

class CarouselState extends State<Carousel> {
  final CarouselController _controller = CarouselController();

  void methodA() {
    setState(() {});
  }

  List<int> tabsList = [];
  late List<Widget> widgets;
  @override
  void initState() {
    super.initState();
    tabsList = List.generate(widget.sheetArr.length, (index) {
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
                          row2Map(widget.colsHeader, widget.sheetArr[rowIndex]),
                          widget.askTags,
                          widget.configRow)
                    ],
                  )),
            ))
        .toList();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.configRow['title'])),
        body: Column(
          children: <Widget>[
            CarouselSlider(
              items: widgets,
              options: CarouselOptions(
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
                  '$_currentIndex/${widget.sheetArr.length}',
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
