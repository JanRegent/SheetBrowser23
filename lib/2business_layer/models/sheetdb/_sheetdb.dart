import 'package:isar/isar.dart';

import 'package:sheetbrowser/2business_layer/models/sheetdb/sheet.dart';
import 'package:sheetbrowser/2business_layer/models/starbl/star.dart';
import 'package:sheetbrowser/2business_layer/models/tag.dart';

import '../../../1pres_layer/alib/uti.dart';
import '../log.dart';
import '../starbl/_starbl.dart';
import 'colsdb.dart';
import 'rowmap.dart';

late SheetDb sheetDb;

late LogDb logDb;
late TagsDb tagsDb;

Future dbInit() async {
  final isar = await Isar.open(
    schemas: [SheetSchema, LogSchema, TagSchema, StarSchema],
    name: 'pbFielistDB',
    relaxedDurability: true,
    inspector: false,
  );
  logDb = LogDb(isar);
  sheetDb = SheetDb(isar);
  await sheetDb.init();

  tagsDb = TagsDb(isar);
}

class SheetDb {
  final Isar isar;
  SheetDb(this.isar);

  late ColsDb colsDb;
  late StarredBL starredBL;
  late RowMap rowMap;

  Future init() async {
    colsDb = ColsDb(isar);
    rowMap = RowMap(isar);
    starredBL = StarredBL(isar);
  }

  Future create(Sheet newSheet) async {
    try {
      await isar.writeTxn((isar) async {
        newSheet.id = await isar.sheets.put(newSheet); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('sheetDB.create', e.toString(), s.toString());
      return '';
    }
  }

  //----------------------------------------------------------------

  Future createRows(String sheetName, String fileId, List<dynamic> rowsArr,
      List<String> colsHeader) async {
    try {
      await sheetDb.colsDb.createColsHeader(sheetName, fileId, colsHeader);
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.createRows.createColsHeader', e.toString(), s.toString());
      return;
    }

    List<Sheet> rows = [];

    int rowIx = 0;
    try {
      int sheetIDix = colsHeader.indexOf('ID');
      for (rowIx = 0; rowIx < rowsArr.length; rowIx++) {
        int sheetID = -1;
        try {
          sheetID = int.tryParse(rowsArr[rowIx][sheetIDix])!;
        } catch (e) {
          //rint('$sheetName $e');
          continue;
        }
        Sheet sheet = Sheet()
          ..zfileId = fileId
          ..aSheetName = sheetName
          ..aKey = 'row'
          ..sheetId = sheetID
          ..rowArr = blUti.toListString(rowsArr[rowIx]);
        rows.add(sheet);
      }
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.createRows.for rows.add', e.toString(), s.toString(),
          descr: 'rowIx $rowIx of rowsArr.length ${rowsArr.length}');
    }

    if (rows.isEmpty) {
      logDb.createErr('sheetDB.createRows.putAll',
          'Error: wrong data sheet $sheetName', 'empty rows[]');
      return;
    }
    try {
      await isar.writeTxn((isar) async {
        await isar.sheets.putAll(rows); // insert
      });
      return 'OK';
    } catch (e, s) {
      logDb.createErr('sheetDB.createRows.putAll', e.toString(), s.toString());
      return;
    }
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

  Future<List<List<String>?>> readRowsAll(String sheetName) async {
    final rows = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .aKeyEqualTo('row')
        .rowArrProperty()
        .findAll();
    return rows;
  }

  Future<List<Sheet>> readSheetsAll(String sheetName) async {
    final rows = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .aKeyEqualTo('row')
        .findAll();
    return rows;
  }

  Future<List<Sheet>> readAllRows() async {
    final rows = await isar.sheets.filter().aKeyEqualTo('row').findAll();
    return rows;
  }

  Future<List<String>> readSheetNames() async {
    final sheets =
        await isar.sheets.where(distinct: true).anyASheetName().findAll();
    List<String> sheetNames = [];
    for (Sheet sheet in sheets) {
      sheetNames.add(sheet.aSheetName);
    }
    return sheetNames;
  }

  Future<List<Map>> readFullText(String str) async {
    List<Sheet> sheets = await isar.sheets
        .filter()
        .aKeyEqualTo('row')
        .and()
        .rowArrAnyContains(str)
        .findAll();

    return await rowMap.readRowMapsBySheets(sheets);
  }

  Future<Sheet> readSheetID(String sheetName, int sheetID) async {
    try {
      return (await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .sheetIdEqualTo(sheetID)
          .findFirst())!;
    } catch (_) {
      return Sheet()..id = -1;
    }
  }

  Future<int> readIdBySheetID(String sheetName, int sheetID) async {
    try {
      return (await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .sheetIdEqualTo(sheetID)
          .idProperty()
          .findFirst())!;
    } catch (_) {
      return -1;
    }
  }

  Future<Sheet?> readbyLocalId(int localId) async {
    try {
      return await isar.sheets.get(localId);
    } catch (_) {
      return Sheet()..id = -1;
    }
  }

  Future<List<int>> readRowsLocalIds(String sheetName) async {
    if (sheetName.isNotEmpty) {
      return await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .aKeyEqualTo('row')
          .idProperty()
          .findAll();
    } else {
      return await isar.stars.where().idProperty().findAll();
    }
  }
  //-------------------------------------------------------------news

  Future<List<int>> readNews(String yyyyMMdd) async {
    List<int> ids = await isar.sheets
        .filter()
        .aKeyEqualTo('row')
        .and()
        .rowArrAnyContains(yyyyMMdd)
        .idProperty()
        .findAll();

    return ids;
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
