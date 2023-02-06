import 'package:isar/isar.dart';

import '../../data_layer/isloading/isloading.dart';
import '../../1pres_layer/alib/uti.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/sheet.dart';

import 'sheetdb/_sheetdb.dart';

part 'tag.g.dart'; // flutter pub run build_runner build

@Collection()
class Tag {
  @Id()
  int id = Isar.autoIncrement;

  @Index(unique: true)
  String tag = '';
  List<int> sheetrowIds = [];

  Tag();
}

class TagsDb {
  final Isar isar;
  TagsDb(this.isar);

  Future<int> count() async {
    List<Tag> rows = await isar.tags.where().findAll();
    return rows.length;
  }

  Map<String, List<int>> tagsMap = {};
  Future tagsIndex() async {
    await sheetDb.colsDb.colsHeadersMapBuild();

    List<Sheet?> sheetrows = await sheetDb.readAllRows();

    for (var rIx = 1; rIx < sheetrows.length; rIx = rIx + 1) {
      isloadingPhaseMessage.value = sheetrows[rIx]!.aSheetName;
      await tagsRowParse(sheetrows[rIx]!.aSheetName, sheetrows[rIx]!.rowArr,
          sheetrows[rIx]!.id);
    }
  }

  Future tagsRowParse(String? sheetName, List<String>? row, int id) async {
    const maxTagLen = 20;

    int tagIx = -1;
    try {
      tagIx = sheetDb.colsDb.colsHeadersMap[sheetName]!.indexOf('tags');
      if (tagIx == -1) return;
    } catch (_) {
      return; //null
    }
    List<String> qTags = [];
    try {
      qTags = row![tagIx].split(',');
    } catch (_) {
      return;
    }
    if (qTags.isEmpty) return;

    for (String qTag in qTags) {
      qTag = qTag.trim().toLowerCase();
      if (qTag.isEmpty) continue;
      if (qTag.length > maxTagLen) continue;
      List<int>? ids = [];
      try {
        ids = tagsMap[qTag] ?? [];
      } catch (_) {
        ids = [];
      }
      ids.add(id);
      tagsMap[qTag] = ids;
    }
  }

  Future tagsMapSave() async {
    //----------------------------------------------------------sort
    var mapEntries = tagsMap.entries.toList();
    tagsMap = {};
    mapEntries.sort((a, b) => a.key.compareTo(b.key));
    Map sortedMap = Map.fromEntries(mapEntries);
    mapEntries.clear();
    //----------------------------------------------------------index save
    List<Tag> tagsIn = [];
    for (String tagKey in sortedMap.keys) {
      tagsIn.add(Tag()
        ..tag = tagKey
        ..sheetrowIds = sortedMap[tagKey]!);
    }
    await tagsDb.clear();
    await tagsDb.updateAll(tagsIn);
    sortedMap.clear();
  }

  Future<List<String>> readTags() async {
    List<Tag> rows = await isar.tags.where().findAll();
    Set tags = {};
    for (Tag tag in rows) {
      tags.add(tag.tag.toString());
    }
    return blUti.toListString(tags.toList());
  }

  Future<List<int>> readTagIds(String tag) async {
    List<Tag?> rows = await isar.tags.where().tagEqualTo(tag).findAll();
    List<int> ids = [];
    for (var i = 0; i < rows.length; i++) {
      ids.addAll(rows[i]!.sheetrowIds);
    }
    return ids;
  }

  // Future updateTagsIds(List<int> ids) async {
  //   for (var i = 0; i < ids.length; i++) {
  //     SheetRow? row = await sheetRowsDb.readRowId(ids[i]);
  //     if (row!.tags.isEmpty) continue;
  //     for (var tagStr in row.tags.split(',')) {
  //       Tag tag = Tag()
  //         ..tag = tagStr.trim()
  //         ..sheetrowIds.add(row.id);
  //       await update(tag);
  //     }
  //   }
  // }

  Future update(Tag tagIn) async {
    Tag? tag2 = await isar.tags.where().tagEqualTo(tagIn.tag).findFirst();
    //----------------------------------------new
    if (tag2 == null) {
      await isar.writeTxn((isar) async {
        await isar.tags.put(tagIn); // insert
      });
      return;
    }
    //-----------------------------------------update
    await isar.tags.delete(tag2.id);
    await isar.writeTxn((isar) async {
      await isar.tags.put(tag2); // insert
    });
  }

  Future updateAll(List<Tag> tagsIn) async {
    await isar.writeTxn((isar) async {
      await isar.tags.putAll(tagsIn); // insert
    });
  }

  Future clear() async {
    await isar.writeTxn((isar) async {
      await isar.tags.clear();
    });
  }
}
