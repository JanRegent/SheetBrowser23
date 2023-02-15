import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../2business_layer/appdata/approotdata.dart';
import 'cardactions.dart';

import 'detailpage.dart';

class CardSwiper extends StatefulWidget {
  final List<int> ids;
  final Map configRow;

  const CardSwiper(this.ids, this.configRow, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CardSwiperState();
  }
}

class _CardSwiperState extends State<CardSwiper> {
  SwiperController controller = SwiperController();
  int startRow = 0;

  @override
  void initState() {
    super.initState();
    if (widget.configRow['startRowByBookmark'] != null) startRow = 55;
  }

  void onIndexChanged(int index) {
    String sheetName = widget.configRow['sheetName'];
    AppDataPrefs.setString('${sheetName}__bookmark', index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text(widget.configRow['title'])],
        ),
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
              return DetailPage(widget.ids[index], widget.configRow);
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
