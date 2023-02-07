import 'package:isar/isar.dart';
import 'package:sheetbrowser/2business_layer/models/starbl/star.dart';

import '../sheetdb/_sheetdb.dart';

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
}