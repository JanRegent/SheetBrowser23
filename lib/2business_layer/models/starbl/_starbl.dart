import 'package:isar/isar.dart';
import 'package:sheetbrowser/1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/2business_layer/models/starbl/star.dart';
import 'package:sheetbrowser/data_layer/getsheetdl.dart';

import '../../appdata/approotdata.dart';
import '../sheetdb/_sheetdb.dart';
import '../sheetdb/sheet.dart';

class StarredBL extends SheetDb {
  StarredBL(super.isar);

  Future<Star?> readStarredVal(String sheetName, int sheetIDin) async {
    Star? starredVal = await isar.stars
        .filter()
        .sheetNameEqualTo(sheetName)
        .and()
        .sheetIDEqualTo(sheetIDin)
        .findFirst();

    return starredVal;
  }

  Future<String> readStars(String sheetName, int sheetIDin) async {
    Star? starredVal = await isar.stars
        .filter()
        .sheetNameEqualTo(sheetName)
        .and()
        .sheetIDEqualTo(sheetIDin)
        .findFirst();
    try {
      // ignore: unnecessary_null_comparison
      if (starredVal!.stars == null) return '';
      return starredVal.stars;
    } catch (_) {
      return '';
    }
  }

  Future<int> starExists(String sheetName, int sheetIDin) async {
    int? id = await isar.stars
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
    Star starredVal = Star()
      ..sheetName = sheetName
      ..sheetID = sheetIDin
      ..localId = sheet.id;

    try {
      starredVal.stars = '*';
      await isar.writeTxn((isar) async {
        await isar.stars.put(starredVal);
      });
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredValss.starredBL.setStar', e.toString(), s.toString());
    }
  }

  Future<String> addStar(String sheetName, int sheetIDin) async {
    Star? starredVal = await readStarredVal(sheetName, sheetIDin);

    starredVal ??= Star()
      ..sheetName = sheetName
      ..sheetID = sheetIDin;

    try {
      starredVal.stars += '*';
      await isar.writeTxn((isar) async {
        await isar.stars.put(starredVal!);
      });
      return starredVal.stars;
    } catch (e, s) {
      logDb.createErr('sheetDB.starredValss.starredBL.addStarr', e.toString(),
          s.toString());
      return '';
    }
  }

  Future<String> minusStar1(String sheetName, int sheetIDin) async {
    Star? starredVal = await readStarredVal(sheetName, sheetIDin);

    try {
      if (starredVal!.stars.isEmpty) return starredVal.stars;
      starredVal.stars =
          starredVal.stars.substring(0, starredVal.stars.length - 1);
      await isar.writeTxn((isar) async {
        await isar.stars.put(starredVal);
      });
      return starredVal.stars;
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredBL.minusStar1', e.toString(), s.toString());
      return starredVal!.stars;
    }
  }

  Future clearStars(String sheetName, int sheetIDin) async {
    Star? starredVal = await readStarredVal(sheetName, sheetIDin);

    try {
      if (starredVal!.stars.isEmpty) return;
      starredVal.stars = '';
      await isar.writeTxn((isar) async {
        await isar.stars.put(starredVal);
      });
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredBL.clearStars', e.toString(), s.toString());
      return '';
    }
  }

  //-----------------------------------------------------4 starred detail
  Future<List<Star>> readStarredIDs(String sheetName) async {
    if (sheetName.isNotEmpty) {
      return await isar.stars.filter().sheetNameEqualTo(sheetName).findAll();
    } else {
      return await isar.stars.where().findAll();
    }
  }

  Future starsClear() async {
    await isar.writeTxn((isar) async {
      await isar.stars.clear(); // delete
    });
  }

  Future starDbFill() async {
    List<dynamic> rowsArr = [];
    List<String> colsHeader = [];
    try {
      String fileId =
          blUti.url2fileid(AppDataPrefs.getString('starredFileUrl')!);
      String sheetName =
          blUti.url2fileid(AppDataPrefs.getString('starredSheetName')!);

      rowsArr = await GoogleSheetsDL(sheetId: fileId, sheetName: sheetName)
          .getSheet();

      if (rowsArr.isEmpty) return;
      colsHeader = blUti.toListString(rowsArr[0]);
      if (colsHeader.isEmpty) return;

      rowsArr.removeAt(0);

      if (rowsArr.isEmpty) return;
    } catch (_) {}

    await starsClear();

    List<Star> stars = [];
    try {
      int sheetIDix = colsHeader.indexOf('sheetID');
      int sheetNameIx = colsHeader.indexOf('sheetName');
      for (var rowIx = 0; rowIx < rowsArr.length; rowIx++) {
        int sheetID = -1;
        try {
          sheetID = int.tryParse(rowsArr[rowIx][sheetIDix])!;
        } catch (_) {
          continue;
        }
        String sheetName = rowsArr[rowIx][sheetNameIx];
        int localId = await sheetDb.readIdBySheetID(sheetName, sheetID);
        if (localId == -1) continue;
        stars.add(Star()
          ..sheetID = sheetID
          ..sheetName = sheetName
          ..localId = localId);
      }
    } catch (_) {}

    if (stars.isEmpty) return;

    try {
      await isar.writeTxn((isar) async {
        await sheetDb.isar.stars.putAll(stars); // insert
      });
      return 'OK';
    } catch (_) {
      return;
    }
  }
}
