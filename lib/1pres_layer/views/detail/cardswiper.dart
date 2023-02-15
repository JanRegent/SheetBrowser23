import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../2business_layer/models/sheetdb/_sheetdb.dart';
import 'cardactions.dart';
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
  SwiperController controller = SwiperController();

  Map rowmap = {};
  int startRow = 0;
  Future<String> getDataRowMaps() async {
    rowmap = await sheetDb.rowMap.row2MapLocalId(widget.ids[0]);
    return 'ok';
  }

  @override
  void initState() {
    super.initState();
    startRow = widget.startRow;
  }

  void onIndexChanged(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.configRowFilelistRow['title']),
        actions: getActions(widget.ids.length, controller, context),
      ),
      body: ConstrainedBox(
          constraints: BoxConstraints.loose(Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height)),
          child: Swiper(
            //https://pub.dev/packages/card_swiper
            //https://github.com/TheAnkurPanchani/card_swiper/
            itemBuilder: (BuildContext context, int index) {
              return DetailPage(widget.ids[index], widget.configRowFilelistRow);
            },
            itemCount: widget.ids.length,
            onIndexChanged: (index) => onIndexChanged(index),
            //pagination: const SwiperPagination(),
            control: const SwiperControl(),
            index: startRow,
            controller: controller,
          )),
    );
  }
}
