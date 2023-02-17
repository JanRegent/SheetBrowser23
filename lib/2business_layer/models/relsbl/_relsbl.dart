import 'package:isar/isar.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/2business_layer/models/relsbl/rels.dart';
import 'package:sheetbrowser/data_layer/getsheetdl.dart';

import '../../appdata/approotdata.dart';
import '../sheetdb/_sheetdb.dart';
import '../sheetdb/sheet.dart';

class SelsBL extends SheetDb {
  SelsBL(super.isar);

  Future<Rel?> readStarredVal(String sheetName, int sheetIDin) async {
    Rel? starredVal = await isar.rels
        .filter()
        .sheetNameEqualTo(sheetName)
        .and()
        .sheetIDEqualTo(sheetIDin)
        .findFirst();

    return starredVal;
  }

  Future<String> readStars(String sheetName, int sheetIDin) async {
    Rel? starredVal = await isar.rels
        .filter()
        .sheetNameEqualTo(sheetName)
        .and()
        .sheetIDEqualTo(sheetIDin)
        .findFirst();
    try {
      // ignore: unnecessary_null_comparison
      if (starredVal!.selName == null) return '';
      return starredVal.selName;
    } catch (_) {
      return '';
    }
  }

  Future<int> starExists(String sheetName, int sheetIDin) async {
    int? id = await isar.rels
        .filter()
        .sheetNameEqualTo(sheetName)
        .and()
        .sheetIDEqualTo(sheetIDin)
        .idProperty()
        .findFirst();
    try {
      // ignore: unnecessary_null_comparison
      if (id == null) return -1;
      return id;
    } catch (_) {
      return -1;
    }
  }

  Future appendStar(String sheetName, int sheetIDin) async {
    int id = await starExists(sheetName, sheetIDin);
    if (id > -1) return;
    Sheet sheet = await readSheetID(sheetName, sheetIDin);
    Rel starredVal = Rel()
      ..sheetName = sheetName
      ..sheetID = sheetIDin
      ..selName = '*'
      ..localId = sheet.id;

    try {
      starredVal.selName = '*';
      await isar.writeTxn((isar) async {
        await isar.rels.put(starredVal);
      });
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredValss.starredBL.setStar', e.toString(), s.toString());
    }
  }

  Future<String> addStar(String sheetName, int sheetIDin) async {
    Rel? starredVal = await readStarredVal(sheetName, sheetIDin);

    starredVal ??= Rel()
      ..sheetName = sheetName
      ..sheetID = sheetIDin;

    try {
      starredVal.selName += '*';
      await isar.writeTxn((isar) async {
        await isar.rels.put(starredVal!);
      });
      return starredVal.selName;
    } catch (e, s) {
      logDb.createErr('sheetDB.starredValss.starredBL.addStarr', e.toString(),
          s.toString());
      return '';
    }
  }

  Future<String> minusStar1(String sheetName, int sheetIDin) async {
    Rel? starredVal = await readStarredVal(sheetName, sheetIDin);

    try {
      if (starredVal!.selName.isEmpty) return starredVal.selName;
      starredVal.selName =
          starredVal.selName.substring(0, starredVal.selName.length - 1);
      await isar.writeTxn((isar) async {
        await isar.rels.put(starredVal);
      });
      return starredVal.selName;
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredBL.minusStar1', e.toString(), s.toString());
      return starredVal!.selName;
    }
  }

  Future clearStars(String sheetName, int sheetIDin) async {
    Rel? starredVal = await readStarredVal(sheetName, sheetIDin);

    try {
      if (starredVal!.selName.isEmpty) return;
      starredVal.selName = '';
      await isar.writeTxn((isar) async {
        await isar.rels.put(starredVal);
      });
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredBL.clearStars', e.toString(), s.toString());
      return '';
    }
  }

  //-----------------------------------------------------4 starred detail
  Future<List<Rel>> readStarredIDs(String sheetName) async {
    if (sheetName.isNotEmpty) {
      return await isar.rels.filter().sheetNameEqualTo(sheetName).findAll();
    } else {
      return await isar.rels.where().findAll();
    }
  }

  Future<List<int>> readStarredLocalIds(String sheetName) async {
    if (sheetName.isNotEmpty) {
      return await isar.rels
          .filter()
          .sheetNameEqualTo(sheetName)
          .localIdProperty()
          .findAll();
    } else {
      return await isar.rels.where().idProperty().findAll();
    }
  }

  Future starsClear() async {
    await isar.writeTxn((isar) async {
      await isar.rels.clear(); // delete
    });
  }

  //----------------------------------------------------*map
  Map<String, List<int>> starMap = {};
  Future<Map<String, List<int>>> getStarMap() async {
    List<dynamic> rowsArr = [];
    List<String> colsHeader = [];
    try {
      String fileId = blUti.url2fileid(AppDataPrefs.getRootSheetId());
      String sheetName = '*';

      rowsArr = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
          .getSheet();

      if (rowsArr.isEmpty) {
        logDb.createWarning('createStarDb()',
            'Starred sheet is empty. [setting] "*" sheet exists?  or AppDataPrefs.getRootSheetId()?');
        return {};
      }
      colsHeader = blUti.toListString(rowsArr[0]);
      if (colsHeader.isEmpty) {
        logDb.createWarning(
            'createStarDb()', 'Starred sheet header is empty. [setting] ');
        return {};
      }

      rowsArr.removeAt(0);

      if (rowsArr.isEmpty) {
        logDb.createWarning('createStarDb()',
            'Starred sheet is empty. [setting] sheet "*" is empty?  or AppDataPrefs.getRootSheetId()?');

        return {};
      }
    } catch (_) {}

    for (var rowIx = 0; rowIx < rowsArr.length; rowIx++) {
      int sheetID = -1;
      try {
        sheetID = int.tryParse(rowsArr[rowIx][1])!;
      } catch (_) {
        continue;
      }
      String sheetName = '';
      try {
        sheetName = rowsArr[rowIx][0];
      } catch (_) {
        continue;
      }
      List<int> sheetIDs = [];
      try {
        sheetIDs = starMap[sheetName]!;
        sheetIDs.add(sheetID);
      } catch (e) {
        sheetIDs = [sheetID];
      }
      try {
        Set<int> set = sheetIDs.toSet();
        starMap[sheetName] = set.toList();
      } catch (_) {
        continue;
      }
    }

    return starMap;
  }
}
