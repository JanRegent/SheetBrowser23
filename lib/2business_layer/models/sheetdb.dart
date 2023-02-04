import 'package:sheetbrowser/2business_layer/models/tag.dart';

import '../../data_layer/isloading/isloading.dart';
import '../../1pres_layer/alib/uti.dart';

import 'package:isar/isar.dart';

import 'sheet.dart';
import 'log.dart';

late SheetDb sheetDb;
late LogDb logDb;
late TagsDb tagsDb;

Future dbInit() async {
  //db = openIsar();

  final isar = await Isar.open(
    schemas: [SheetSchema, LogSchema, TagSchema],
    name: 'pbFielistDB',
    relaxedDurability: true,
    inspector: false,
  );
  logDb = LogDb(isar);
  sheetDb = SheetDb(isar);
  tagsDb = TagsDb(isar);
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

  //------------------------------------------------------------cols

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

  Map<String, List<String>> colsHeadersMap = {};

  Future colsHeadersMapBuild() async {
    final colRows =
        await isar.sheets.filter().aKeyEqualTo('colsHeader').findAll();

    for (var sheetNameIx = 0; sheetNameIx < colRows.length; sheetNameIx++) {
      colsHeadersMap[colRows[sheetNameIx].aSheetName!] =
          colRows[sheetNameIx].listStr!;
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

  Future<List<String>> sheetNamesGet() async {
    List<String> sheetNames = await isar.sheets
        .filter()
        .aKeyEqualTo('colsHeader')
        .aSheetNameProperty()
        .findAll() as List<String>;

    return sheetNames;
  }

  //----------------------------------------------------------------

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
    String todayStr = blUti.todayStr();
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
          ..listStr = blUti.toListString(rowsArr[rowIx]);
        rows.add(sheet);

        if (sheet.listStr!.contains(todayStr)) {
          await createTodayNews(sheet);
        }
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

  Future createTodayNews(Sheet sheet) async {
    try {
      sheet.aKey = '__newToday__';
      await isar.writeTxn((isar) async {
        await isar.sheets.put(sheet);
      });
    } catch (e, s) {
      logDb.createErr('sheetDB.createTodayNews', e.toString(), s.toString());
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

  Future<List<Sheet>> readAllRows() async {
    final rows = await isar.sheets.filter().aKeyEqualTo('row').findAll();
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

  Future<List<Map>> readRowMaps(List<int> ids) async {
    List<Map> rowmaps = [];
    await colsHeadersMapBuild();
    for (var idIx = 0; idIx < ids.length; idIx++) {
      Sheet? sheet = await isar.sheets.get(ids[idIx]);
      List<String> colHeader = colsHeadersMap[sheet!.aSheetName]!;
      Map rowmap = {};
      for (var colIx = 0; colIx < colHeader.length; colIx++) {
        try {
          rowmap[colHeader[colIx]] = sheet.listStr![colIx];
          //todo: different len of cols and listStr row
        } catch (_) {}
      }
      rowmaps.add(rowmap);
    }
    return rowmaps;
  }

  Future<List<Map>> readRowMapsSheet(String sheetName) async {
    List<int> ids = await isar.sheets
        .filter()
        .aSheetNameEqualTo(sheetName)
        .and()
        .aKeyEqualTo('row')
        .idProperty()
        .findAll();

    return readRowMaps(ids);
  }

  Map row2Map(List<dynamic> keys, List<dynamic> datarow) {
    Map row = {};
    for (var i = 0; i < keys.length; i++) {
      try {
        row[keys[i]] = datarow[i];
      } catch (_) {
        row[keys[i]] = '';
      }
    }
    return row;
  }

  //-------------------------------------------------------------news
  List<List<String>> readNewsCols = [];
  Future<List<Map>> readNewsToday() async {
    List<Map> rowsMaps = [];
    readNewsCols = [];

    List<Sheet> newsTodaySheets =
        await isar.sheets.filter().aKeyEqualTo('__newToday__').findAll();

    for (var newIx = 0; newIx < newsTodaySheets.length; newIx++) {
      String sheetName = newsTodaySheets[newIx].aSheetName!;
      isloadingPhaseMessage.value = sheetName;
      List<String> colsHeader = await readColsHeader(sheetName) as List<String>;
      rowsMaps.add(row2Map(
          colsHeader, blUti.toListDynamic(newsTodaySheets[newIx].listStr!)));
    }

    return rowsMaps;
  }

  Future deleteNewsToday() async {
    List<int> todelIDs = await isar.sheets
        .filter()
        .aKeyEqualTo('__newToday__')
        .sheetIdProperty()
        .findAll();
    await isar.writeTxn((isar) {
      return isar.sheets.deleteAll(todelIDs); // delete
    });
  }

  Future<List<Map>> readNews(String yyyyMMdd) async {
    List<Map> rowsMaps = [];

    List<String> sheetNames = await readSheetNames();
    for (String sheetName in sheetNames) {
      isloadingPhaseMessage.value = sheetName;
      //---------------------------------------------ColsHeader
      List<String> colsHeader = await readColsHeader(sheetName) as List<String>;
      if (!colsHeader.contains('sheetName')) {
        colsHeader.add('sheetName');
      }
      //---------------------------------------------dateinsert rows
      List<int> ids = await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .aKeyEqualTo('row')
          .and()
          .listStrAnyContains(yyyyMMdd)
          .idProperty()
          .findAll();

      rowsMaps.addAll(await readRowMaps(ids));
    }

    return rowsMaps;
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
