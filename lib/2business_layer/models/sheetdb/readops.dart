import 'package:dartx/dartx.dart';
import 'package:isar/isar.dart';

import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/sheet.dart';

class ReadOps {
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

    return await sheetDb.rowMap.readRowMapsBySheets(sheets);
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
    List<int> listInt = [];
    if (sheetName.isNotEmpty) {
      listInt = await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetName)
          .and()
          .aKeyEqualTo('row')
          .idProperty()
          .findAll();
    } else {
      //listInt = await isar.rels.where().idProperty().findAll();
    }

    return listInt;
  }

  Future<List<int>> readRowsStar(String sheetNameORempty) async {
    List<int> listInt = [];
    if (sheetNameORempty.isNotEmpty) {
      listInt = await isar.sheets
          .filter()
          .aSheetNameEqualTo(sheetNameORempty)
          .and()
          .aKeyEqualTo('row')
          .and()
          .tagsListAnyEqualTo('*')
          .idProperty()
          .findAll();
    } else {
      listInt = await isar.sheets
          .filter()
          .aKeyEqualTo('row')
          .and()
          .tagsListAnyContains('*')
          .idProperty()
          .findAll();
    }

    return listInt;
  }

  Future<List<int>> readRowsTag(String tag) async {
    if (tag.isEmpty) return [];
    List<int> listInt = [];

    listInt = await isar.sheets
        .filter()
        .aKeyEqualTo('row')
        .and()
        .tagsListAnyContains(tag)
        .idProperty()
        .findAll();

    return listInt;
  }

  Future<List<String>> readTags() async {
    List<List<String>> tagsArr = await isar.sheets
        .filter()
        .aKeyEqualTo('row')
        .tagsListProperty()
        .findAll();
    Set<String> set = {};
    for (var i = 0; i < tagsArr.length; i++) {
      set.addAll(tagsArr[i]);
    }
    return set.sorted().toList();
  }
  //-------------------------------------------------------------news

  Future<List<int>> readSearch(String yyyyMMddORword) async {
    List<int> ids = await isar.sheets
        .filter()
        .aKeyEqualTo('row')
        .and()
        .rowArrAnyContains(yyyyMMddORword)
        .idProperty()
        .findAll();
    return ids;
  }

  Future<String> readSearch2selSheet(String yyyyMMddORword) async {
    List<Sheet> sheets = await isar.sheets
        .filter()
        .aKeyEqualTo('row')
        .and()
        .rowArrAnyContains(yyyyMMddORword)
        .findAll();
    String csv = 'sheetName,sheetID\n';
    for (var i = 0; i < sheets.length; i++) {
      csv += '${sheets[i].aSheetName}, ${sheets[i].sheetId}\n';
    }
    return csv;
  }
}
