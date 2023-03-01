import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2business_layer/appdata/approotdata.dart';
import 'cardactions.dart';

import 'detailapage.dart';

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
    startRowBookmarksSet();
  }

  //---------------------------------------------------------- int startRow
  int startRow = 0;

  void startRowBookmarksSet() {
    currentRowTitleValue(startRow);
    try {
      if (widget.configRow['sheetName'] == null) {
        widget.configRow['__bookmarkLastRowVisitSave__'] = '';
      }
    } catch (_) {
      widget.configRow['__bookmarkLastRowVisitSave__'] = '';
      return;
    }
    if (widget.configRow['__bookmarkLastRowVisitSave__'] == null) {
      widget.configRow['__bookmarkLastRowVisitSave__'] = '';
    }
    if (widget.configRow['__bookmarkLastRowVisitSave__'] == '') {
      return;
    }

    try {
      String? startRowStr = AppDataPrefs.getString(
          '${widget.configRow['sheetName']}__bookmarkLastRowVisit');
      //filtered localIds like starred has no sheetName
      startRow = int.tryParse(startRowStr!)!;
    } catch (_) {
      startRow = 0;
    }
    currentRowTitleValue(startRow);
  }

  void currentRowTitleValue(int currentIndex) {
    currentRowTitle.value = ' ${(currentIndex + 1)}/${widget.localIds.length}';
  }

  RxString currentRowTitle = ''.obs;
  void onIndexChanged(int index) {
    currentRowTitleValue(index);
    if (widget.configRow['__bookmarkLastRowVisitSave__'] == '') {
      return;
    }
    try {
      //filtered localIds like starred has no sheetName
      String sheetName = widget.configRow['sheetName'];
      AppDataPrefs.setString(
          '${sheetName}__bookmarkLastRowVisit', index.toString());
    } catch (__) {}
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
          title: ListTile(
            title: Text(widget.configRow['title']),
            subtitle: Obx(() => Text('\n${currentRowTitle.value}',
                style: const TextStyle(fontSize: 18))),
          ),
          actions: getActions(widget.localIds.length, controller, context),
        ),
        body: body());
  }
}
