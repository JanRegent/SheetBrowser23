import './sheet.dart';
import 'package:isar/isar.dart';

class SheetService {
  late Future<Isar> db;

  SheetService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [SheetSchema], //, BookCategorySchema, AuthorSchema
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> createBook(Sheet newSheet) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.sheets.putSync(newSheet));
  }

  Stream<List<Sheet>> getAllsheets({String? search}) async* {
    final isar = await db;
    final query = isar.sheets.where().filter().keyEqualTo('row').build();

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results;
      }
    }
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
