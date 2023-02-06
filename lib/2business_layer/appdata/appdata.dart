import 'package:isar/isar.dart';
// flutter pub run build_runner build

part 'appdata.g.dart';

@Collection()
class Appdata {
  @Id()
  int id = Isar.autoIncrement;

  String key = '';
  String value = '';
  String sheetName = '';

  Appdata();
}
