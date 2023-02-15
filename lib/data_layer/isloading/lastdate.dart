import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../1pres_layer/alib/uti.dart';
import '../../2business_layer/appdata/approotdata.dart';
import 'backgrounscompleter.dart';

RxBool isDataLoading = false.obs;
RxString isloadingAction = ''.obs;
RxString isloadingPhaseMessage = ''.obs;

ListTile backgroundCompleterLastDateListTile() {
  isloadingAction.value = 'Data:';
  isloadingPhaseMessage.value =
      'Up to date ${AppDataPrefs.getString('backgroundCompleter-lastDate')}';

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
