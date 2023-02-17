import 'package:isar/isar.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/2business_layer/models/relsbl/rels.dart';
import 'package:sheetbrowser/data_layer/getsheetdl.dart';

import '../../appdata/approotdata.dart';
import '../sheetdb/_sheetdb.dart';
import '../sheetdb/sheet.dart';

class StarredBL extends SheetDb {
  StarredBL(super.isar);

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
      if (starredVal!.relName == null) return '';
      return starredVal.relName;
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
      ..localId = sheet.id;

    try {
      starredVal.relName = '*';
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
      starredVal.relName += '*';
      await isar.writeTxn((isar) async {
        await isar.rels.put(starredVal!);
      });
      return starredVal.relName;
    } catch (e, s) {
      logDb.createErr('sheetDB.starredValss.starredBL.addStarr', e.toString(),
          s.toString());
      return '';
    }
  }

  Future<String> minusStar1(String sheetName, int sheetIDin) async {
    Rel? starredVal = await readStarredVal(sheetName, sheetIDin);

    try {
      if (starredVal!.relName.isEmpty) return starredVal.relName;
      starredVal.relName =
          starredVal.relName.substring(0, starredVal.relName.length - 1);
      await isar.writeTxn((isar) async {
        await isar.rels.put(starredVal);
      });
      return starredVal.relName;
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredBL.minusStar1', e.toString(), s.toString());
      return starredVal!.relName;
    }
  }

  Future clearStars(String sheetName, int sheetIDin) async {
    Rel? starredVal = await readStarredVal(sheetName, sheetIDin);

    try {
      if (starredVal!.relName.isEmpty) return;
      starredVal.relName = '';
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

  Future createStarDb() async {
    List<dynamic> rowsArr = [];
    List<String> colsHeader = [];
    try {
      String fileId = blUti.url2fileid(AppDataPrefs.getRootSheetId());
      String sheetName =
          blUti.url2fileid(AppDataPrefs.getString('starredSheetName')!);

      rowsArr = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
          .getSheet();

      if (rowsArr.isEmpty) {
        logDb.createWarning('createStarDb()',
            'Starred sheet is empty. [setting] StarredSheetName?  or AppDataPrefs.getRootSheetId()?');
        return;
      }
      colsHeader = blUti.toListString(rowsArr[0]);
      if (colsHeader.isEmpty) {
        logDb.createWarning(
            'createStarDb()', 'Starred sheet header is empty. [setting] ');
        return;
      }

      rowsArr.removeAt(0);

      if (rowsArr.isEmpty) {
        logDb.createWarning('createStarDb()',
            'Starred sheet is empty. [setting] StarredSheetName?  or AppDataPrefs.getRootSheetId()?');

        return;
      }
    } catch (_) {}

    int sheetIDix = colsHeader.indexOf('sheetID');
    int sheetNameIx = colsHeader.indexOf('sheetName');

    if (sheetIDix == -1 || sheetNameIx == -1) {
      logDb.createWarning('createStarDb()',
          'Starred sheet header: sheetID or sheetName columns is missting. [setting]?');
      return;
    }

    await starsClear();

    List<Rel> stars = [];
    try {
      for (var rowIx = 0; rowIx < rowsArr.length; rowIx++) {
        int sheetID = -1;
        try {
          sheetID = int.tryParse(rowsArr[rowIx][sheetIDix])!;
        } catch (_) {
          continue;
        }
        String sheetName = '';
        try {
          sheetName = rowsArr[rowIx][sheetNameIx];
        } catch (_) {
          continue;
        }

        int localId = await sheetDb.readIdBySheetID(sheetName, sheetID);
        if (localId == -1) continue;
        stars.add(Rel()
          ..sheetID = sheetID
          ..sheetName = sheetName
          ..relName = '*'
          ..localId = localId);
      }
    } catch (_) {}

    if (stars.isEmpty) return;

    try {
      await isar.writeTxn((isar) async {
        await sheetDb.isar.rels.putAll(stars); // insert
      });
      return 'OK';
    } catch (_) {
      return;
    }
  }
}
