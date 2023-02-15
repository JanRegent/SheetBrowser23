import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../2business_layer/models/sheetdb/_sheetdb.dart';
import 'detailpage.dart';

class CardSwiper extends StatefulWidget {
  final List<int> ids;
  final Map configRowFilelistRow;
  final int startRow;
  const CardSwiper(this.ids, this.configRowFilelistRow, this.startRow,
      {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CardSwiperState();
  }
}

class _CardSwiperState extends State<CardSwiper> {
  late SwiperController controller;

  late List<bool> autoPlayer;

  late List<SwiperController> controllers;
  Map rowmap = {};

  Future<String> getDataRowMaps() async {
    rowmap = await sheetDb.rowMap.row2MapLocalId(widget.ids[0]);
    return 'ok';
  }

  @override
  void initState() {
    controller = SwiperController();
    autoPlayer = List.generate(10, (index) => false);
    controllers = List.generate(10, (index) => SwiperController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.configRowFilelistRow['title'])),
      body: ConstrainedBox(
          constraints: BoxConstraints.loose(Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height)),
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return DetailPage(widget.ids[index], widget.configRowFilelistRow);
            },
            itemCount: widget.ids.length,
            //pagination: const SwiperPagination(),
            control: const SwiperControl(),
          )),
    );
  }
}
