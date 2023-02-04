import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../2business_layer/appdata/approotdata.dart';
import 'backgrounscompleter.dart';
import '../../1pres_layer/alib/uti.dart';

RxBool isDataLoading = false.obs;
RxString isloadingAction = ''.obs;
RxString isloadingPhaseMessage = ''.obs;

ListTile isloadingListTile() {
  isloadingPhaseMessage.value =
      'Data to ${AppDataPrefs.getString('backgroundCompleter-lastDate')}';

  return ListTile(
      leading: Obx(() => Text(' ${isloadingAction.value}',
          style: const TextStyle(fontSize: 18))),
      title: Obx(() => Text(' ${isloadingPhaseMessage.value}',
          style: const TextStyle(fontSize: 18))),
      trailing: IconButton(
          onPressed: () async {
            await AppDataPrefs.setString('backgroundCompleter-lastDate',
                'loading for ${blUti.todayStr()}');
            backgroundCompleter();
          },
          icon: const Icon(Icons.refresh)));
}

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
