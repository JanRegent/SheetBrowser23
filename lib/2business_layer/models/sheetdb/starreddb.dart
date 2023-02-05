import 'package:isar/isar.dart';

import '../sheet.dart';
import './sheetdb.dart';

class StarredDb extends SheetDb {
  StarredDb(super.isar);

  Future createStarred(String sheetName, String fileId) async {
    int? id = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .aKeyEqualTo('starred')
        .idProperty()
        .findFirst();

    if (id != null) return;

    try {
      await create(Sheet()
        ..zfileId = fileId
        ..aSheetName = sheetName
        ..aKey = 'starred');
    } catch (e, s) {
      logDb.createErr('sheetDB.createStarred', e.toString(), s.toString());
      return '';
    }
  }
}
