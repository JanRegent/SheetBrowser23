import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/starred/starredvals.dart';

import '../_sheetdb.dart';

RxMap starredMap = RxMap();

class StarredBL extends SheetDb {
  StarredBL(super.isar);

  Future<StarredVal?> readStarredVal(String sheetName, int sheetIDin) async {
    StarredVal? starredVal = await isar.starredVals
        .filter()
        .sheetNameEqualTo(sheetName)
        .and()
        .sheetIDEqualTo(sheetIDin)
        .findFirst();

    return starredVal;
  }

  Future<String> readStars(String sheetName, int sheetIDin) async {
    StarredVal? starredVal = await isar.starredVals
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

  Future addStarr(String sheetName, int sheetIDin) async {
    StarredVal? starredVal = await readStarredVal(sheetName, sheetIDin);

    starredVal ??= StarredVal()
      ..sheetName = sheetName
      ..sheetID = sheetIDin;

    try {
      starredVal.stars += '*';
      await isar.writeTxn((isar) async {
        await isar.starredVals.put(starredVal!);
      });
    } catch (e, s) {
      logDb.createErr('sheetDB.starredValss.starredBL.addStarr', e.toString(),
          s.toString());
      return '';
    }
  }

  Future minusStar1(String sheetName, int sheetIDin) async {
    StarredVal? starredVal = await readStarredVal(sheetName, sheetIDin);

    try {
      if (starredVal!.stars.isEmpty) return;
      starredVal.stars =
          starredVal.stars.substring(0, starredVal.stars.length - 1);
      await isar.writeTxn((isar) async {
        await isar.starredVals.put(starredVal);
      });
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredBL.minusStar1', e.toString(), s.toString());
      return '';
    }
  }

  Future clearStars(String sheetName, int sheetIDin) async {
    StarredVal? starredVal = await readStarredVal(sheetName, sheetIDin);

    try {
      if (starredVal!.stars.isEmpty) return;
      starredVal.stars = '';
      await isar.writeTxn((isar) async {
        await isar.starredVals.put(starredVal);
      });
    } catch (e, s) {
      logDb.createErr(
          'sheetDB.starredBL.clearStars', e.toString(), s.toString());
      return '';
    }
  }
}
