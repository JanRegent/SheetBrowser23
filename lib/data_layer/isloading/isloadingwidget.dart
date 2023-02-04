import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../1pres_layer/filelist/filelistcard.dart';

CountController loadController = Get.put(CountController());

class CountController extends GetxController {
  final sheetName = ''.obs;
  RxList rowsPlus = [].obs;
}

Obx isLoadingWidget(BuildContext context) {
  return Obx(() => filelist[0]['isLoading'].value
      ? Row(
          children: [
            const CircularProgressIndicator(color: Colors.red),
            const Text('  '),
            Text(
              loadController.sheetName.value,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        )
      : Text(
          loadController.sheetName.value,
          style: Theme.of(context).textTheme.titleLarge,
        ));
}
