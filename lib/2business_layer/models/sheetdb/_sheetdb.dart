import 'package:isar/isar.dart';

import 'package:sheetbrowser/2business_layer/models/sheetdb/sheet.dart';

import '../../appdata/appdata.dart';

import '../log.dart';
import 'colsdb.dart';
import 'createops.dart';
import 'readops.dart';
import 'rowmap.dart';
import 'updateops.dart';

late final Isar isar;

Future dbInit() async {
  isar = await Isar.open(
    schemas: [SheetSchema, LogSchema, AppdataSchema],
    name: 'SheetBrowser',
    relaxedDurability: true,
    inspector: false,
  );
  await sheetDb.init();
}

LogDb logDb = LogDb();
Appdata appdata = Appdata();
SheetDb sheetDb = SheetDb();

class SheetDb {
  CreateOps createOps = CreateOps();
  ReadOps readOps = ReadOps();
  UpdateOps updateOps = UpdateOps();

  late ColsDb colsDb = ColsDb();

  late RowMap rowMap = RowMap();

  Future init() async {}

  //----------------------------------------------------------------

  Future cleanDb() async {
    try {
      await isar.writeTxn((isar) async {
        await isar.sheets.clear();
      });
    } catch (e, s) {
      logDb.createErr('sheetDB.cleanDb', e.toString(), s.toString());
    }
  }

  Future<int> lengthRows(String sheetName) async {
    final rows = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .aKeyEqualTo('row')
        .findAll();
    return rows.length;
  }

  //--------------------------------------------------------read
  Future<List<int>> listIDs2locIDs(String sheetName, List<int> listIDs) async {
    List<int> localIDs = [];
    for (var rowIx = 0; rowIx < listIDs.length; rowIx++) {
      int? locId = await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .sheetIdEqualTo(listIDs[rowIx])
          .idProperty()
          .findFirst();
      if (locId == null) continue;
      localIDs.add(locId);
    }

    return localIDs;
  }

  //----------------------------------------------------------delete
  Future<List<int>> locIDs(String sheetName) async {
    List<int> ids = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .aKeyEqualTo('row')
        .and()
        .sheetIdGreaterThan(-1)
        .sheetIdProperty()
        .findAll();
    return ids;
  }

  Future deleteRowsOfSheet(String sheetName) async {
    List<int> todelIDs = await locIDs(sheetName);
    await isar.writeTxn((isar) {
      return isar.sheets.deleteAll(todelIDs); // delete
    });
  }

  Future deleteRow(Sheet sheet) async {
    await isar.writeTxn((isar) {
      return isar.sheets.delete(sheet.id); // delete
    });
  }

  Future sheeetsClear() async {
    await isar.writeTxn((isar) async {
      await isar.sheets.clear(); // delete
    });
  }
}
