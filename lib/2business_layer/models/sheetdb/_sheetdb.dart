import 'package:isar/isar.dart';

import 'package:sheetbrowser/2business_layer/models/sheetdb/sheet.dart';

import '../../appdata/approotdata.dart';
import '../log.dart';
import 'colsdb.dart';
import 'createops.dart';
import 'readops.dart';
import 'rowmap.dart';

late SheetDb sheetDb;

late LogDb logDb;

Future dbInit() async {
  final isar = await Isar.open(
    schemas: [SheetSchema, LogSchema],
    name: 'pbFielistDB',
    relaxedDurability: true,
    inspector: false,
  );

  logDb = LogDb(isar);
  sheetDb = SheetDb(isar);
  await sheetDb.init();
}

class SheetDb {
  final Isar isar;
  CreateOps createOps = CreateOps();
  ReadOps readOps = ReadOps();

  SheetDb(this.isar);

  late ColsDb colsDb;

  late RowMap rowMap;

  Future init() async {
    createOps.isar = isar;
    readOps.isar = isar;
    colsDb = ColsDb(isar);
    rowMap = RowMap(isar);
  }

  //----------------------------------------------------------------
  List<String> selectRowContains() {
    String? str = AppDataPrefs.getString('select row contains');
    return str!.split(',');
  }

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

  //---------------------------------------------------update
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

  Future sheeetsClear() async {
    await isar.writeTxn((isar) async {
      await isar.sheets.clear(); // delete
    });
  }
}
