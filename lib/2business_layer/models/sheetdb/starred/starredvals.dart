import 'package:isar/isar.dart';
// flutter pub run build_runner build

part 'starredvals.g.dart';

@Collection()
class StarredVal {
  @Id()
  int id = Isar.autoIncrement;

  String sheetName = '';
  int sheetID = -1;
  String stars = '';

  StarredVal();
}
