import '_sheetdb.dart';
import 'sheet.dart';

class UpdateOps {
  Future update(Sheet sheet) async {
    try {
      await isar.writeTxn((isar) async {
        sheet.id = await isar.sheets.put(sheet); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('sheetDB.update', e.toString(), s.toString());
      return '';
    }
  }

  Future updateTags(int localId, String newTags) async {
    try {
      Sheet? sheet = await sheetDb.readOps.readbyLocalId(localId);
      sheet!.tags.addAll(newTags.split(','));
      await update(sheet);
    } catch (_) {}
  }
}
