import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2business_layer/appdata/approotdata.dart';
import 'cardactions.dart';

import 'detailpage.dart';

class CardSwiper extends StatefulWidget {
  final List<int> localIds;
  final Map configRow;

  const CardSwiper(this.localIds, this.configRow, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CardSwiperState();
  }
}

class _CardSwiperState extends State<CardSwiper> {
  SwiperController controller = SwiperController();

  @override
  void initState() {
    super.initState();
    startRowSet();
  }

  //---------------------------------------------------------- int startRow
  int startRow = 0;

  void startRowSet() {
    if (widget.configRow['startRowByBookmark'] == null) return;

    String? startRowStr = AppDataPrefs.getString(
        '${widget.configRow['sheetName']}__bookmarkLastRowVisit');
    try {
      startRow = int.tryParse(startRowStr!)!;
      currentRowIndex.value = startRow;
    } catch (_) {
      startRow = 0;
    }
  }

  RxInt currentRowIndex = 0.obs;
  void onIndexChanged(int index) {
    String sheetName = widget.configRow['sheetName'];
    currentRowIndex.value = index;
    AppDataPrefs.setString(
        '${sheetName}__bookmarkLastRowVisit', index.toString());
  }

  ConstrainedBox body() {
    return ConstrainedBox(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height)),
        child: Swiper(
          //https://pub.dev/packages/card_swiper
          //https://github.com/TheAnkurPanchani/card_swiper/
          itemBuilder: (BuildContext context, int rowIndex) {
            return DetailPage(widget.localIds[rowIndex], widget.configRow);
          },
          itemCount: widget.localIds.length,
          onIndexChanged: (index) => onIndexChanged(index),
          //pagination: const SwiperPagination(),
          control: const SwiperControl(),
          index: startRow,
          controller: controller,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(widget.configRow['title']),
              Obx(() =>
                  Text(' ${currentRowIndex.value}/${widget.localIds.length}')),
            ],
          ),
          actions: getActions(widget.localIds.length, controller, context),
        ),
        body: body());
  }
}
