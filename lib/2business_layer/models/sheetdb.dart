import '../../1pres_layer/alib/uti.dart';
import './sheet.dart';
import 'package:isar/isar.dart';

import 'log.dart';

late SheetDb sheetDb;
late LogDb logDb;

Future dbInit() async {
  //db = openIsar();

  final isar = await Isar.open(
    schemas: [SheetSchema, LogSchema],
    name: 'pbFielistDB',
    relaxedDurability: true,
    inspector: false,
  );
  logDb = LogDb(isar);
  sheetDb = SheetDb(isar);
}

class SheetDb {
  final Isar isar;
  SheetDb(this.isar);

  Future create(Sheet newSheet) async {
    try {
      await isar.writeTxn((isar) async {
        newSheet.id = await isar.sheets.put(newSheet); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('SheetService.create', e, s);
      return '';
    }
  }

  Future createRows(String sheetName, String fileId, List<dynamic> rowsArr,
      List<String> colsHeader) async {
    create(Sheet()
      ..zfileId = fileId
      ..aSheetName = sheetName
      ..key = 'colsHeader'
      ..listStr = blUti.toListString(colsHeader));

    List<Sheet> rows = [];
    for (int rowIx = 0; rowIx < rowsArr.length; rowIx++) {
      rows.add(Sheet()
        ..zfileId = fileId
        ..aSheetName = sheetName
        ..key = 'row'
        ..listStr = blUti.toListString(rowsArr[rowIx]));
    }
    try {
      await isar.writeTxn((isar) async {
        await isar.sheets.putAll(rows); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('SheetService.create', e, s);
      return '';
    }
  }
  // Future<void> cleanDb() async {
  //   //final isar = await db;
  //   //await isar.writeTxn(() => isar.clear());
  // }

  Future<int> lengthRows(String sheetName) async {
    final rows = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .keyEqualTo('row')
        .findAll();
    return rows.length;
  }
}
