import 'package:isar/isar.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/sheet.dart';

import './sheetdb.dart';

class StarredDb extends SheetDb {
  StarredDb(super.isar);

  Future addStarr(String sheetName, String fileId, int sheetID) async {
    Sheet? sheet = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .sheetIdEqualTo(sheetID)
        .findFirst();

    try {
      sheet!.starred += '*';
      //todo: Error: Expected a value of type 'List<dynamic>?', but got one of type 'LegacyJavaScriptObject'
      sheet.listStr = blUti.toListString(sheet.listStr);
      await isar.writeTxn((isar) async {
        await isar.sheets.put(sheet);
      });
    } catch (e, s) {
      logDb.createErr('sheetDB.updateStarred2', e.toString(), s.toString());
      return '';
    }
  }
}
