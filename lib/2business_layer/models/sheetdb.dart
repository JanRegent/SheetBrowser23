import '../../1pres_layer/acontrolers/isloading.dart';
import '../../1pres_layer/alib/uti.dart';

import 'package:isar/isar.dart';

import 'sheet.dart';
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
      logDb.createErr('sheetDB.create', e.toString(), s.toString());
      return '';
    }
  }

  Future createColsHeader(
      String sheetName, String fileId, List<String> colsHeader) async {
    await deleteColsHeader(sheetName, fileId);
    try {
      await create(Sheet()
        ..zfileId = fileId
        ..aSheetName = sheetName
        ..aKey = 'colsHeader'
        ..listStr = blUti.toListString(colsHeader));
    } catch (e, s) {
      logDb.createErr('sheetDB.create', e.toString(), s.toString());
      return '';
    }
  }

  Future deleteColsHeader(String sheetName, String fileId) async {
    try {
      List<int> ids = await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .aKeyEqualTo('colsHeader')
          .idProperty()
          .findAll();
      if (ids.isNotEmpty) {
        await isar.writeTxn((isar) {
          return isar.sheets.deleteAll(ids); // delete
        });
      }
    } catch (_) {}
  }

  Future createRows(String sheetName, String fileId, List<dynamic> rowsArr,
      List<String> colsHeader) async {
    try {
      await createColsHeader(sheetName, fileId, colsHeader);
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
        } catch (_) {
          continue;
        }
        print(sheetID);
        rows.add(Sheet()
          ..zfileId = fileId
          ..aSheetName = sheetName
          ..aKey = 'row'
          ..sheetId = sheetID
          ..listStr = blUti.toListString(rowsArr[rowIx]));
      }
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.createRows.for rows.add', e.toString(), s.toString(),
          descr: 'rowIx $rowIx of rowsArr.length ${rowsArr.length}');
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
  //----------------------------------------------------------read

  Future<List<String>?> readColsHeader(String sheetName) async {
    late Sheet? row;
    try {
      row = (await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .aKeyEqualTo('colsHeader')
          .findFirst());
    } catch (_) {
      return [];
    }
    if (row?.listStr == null) return [];
    return row?.listStr;
  }

  Future<List<List<String>?>> readRowsAll(String sheetName) async {
    final rows = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .aKeyEqualTo('row')
        .listStrProperty()
        .findAll();
    return rows;
  }

  Future<List<String>> readSheetNames() async {
    final sheets =
        await isar.sheets.where(distinct: true).anyASheetName().findAll();
    List<String> sheetNames = [];
    for (Sheet sheet in sheets) {
      sheetNames.add(sheet.aSheetName!);
    }
    return sheetNames;
  }

  List<List<String>> readNewsCols = [];
  Future<List<List<String>>> readNews(String yyyyMMdd) async {
    List<List<String>> rows = [];

    List<String> sheetNames = await readSheetNames();
    for (String sheetName in sheetNames) {
      phaseMessage.value = sheetName;
      //---------------------------------------------ColsHeader
      List<String> colsHeader = await readColsHeader(sheetName) as List<String>;
      if (!colsHeader.contains('sheetName')) {
        colsHeader.add('sheetName');
      }
      //---------------------------------------------dateinsert rows
      List<Sheet> sheetRows = await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .aKeyEqualTo('row')
          .and()
          .listStrAnyContains(yyyyMMdd)
          .findAll();

      for (var rowIx = 0; rowIx < sheetRows.length; rowIx++) {
        readNewsCols.add(colsHeader);
        rows.add(sheetRows[rowIx].listStr!);
      }
    }

    return rows;
  }

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

  Future deleteAKeyEqualToRow() async {
    List<int> ids = await isar.sheets
        .filter()
        .aKeyEqualTo('row')
        .sheetIdProperty()
        .findAll();

    await isar.writeTxn((isar) {
      return isar.sheets.deleteAll(ids); // delete
    });
  }
}
