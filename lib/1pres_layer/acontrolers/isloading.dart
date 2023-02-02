import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxBool isDataLoading = false.obs;
RxString sheetNameIsloadiding = ''.obs;

///
///    body: Obx(() => isDataLoading.value
// ? isloadingWidgetColumn(
//     'Awaiting news...(${textEditingController.text})')
// : searchableKeyListview()),
///
///

List<Widget> isloadingWidgetList(String mess) {
  return <Widget>[
    const SizedBox(
      width: 60,
      height: 60,
      child: CircularProgressIndicator(),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(mess),
    ),
  ];
}

Column isloadingWidgetColumn(String mess) {
  return Column(
    children: [
      const SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(mess),
      ),
    ],
  );
}
