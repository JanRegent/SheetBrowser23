import 'package:isar/isar.dart';
// flutter pub run build_runner build

part 'starredvals.g.dart';

@Collection()
class StarredVals {
  @Id()
  int id = Isar.autoIncrement;

  String sheetName = '';
  String key = '';
  String value = '';

  StarredVals();
}
