import 'package:isar/isar.dart';
// flutter pub run build_runner build

part 'rels.g.dart';

@Collection()
class Rel {
  @Id()
  int id = Isar.autoIncrement;

  String sheetName = '';
  int sheetID = -1;
  String relName = '';
  int localId = -1;

  Rel();
}
