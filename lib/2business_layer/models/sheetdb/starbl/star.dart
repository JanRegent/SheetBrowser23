import 'package:isar/isar.dart';
// flutter pub run build_runner build

part 'star.g.dart';

@Collection()
class Star {
  @Id()
  int id = Isar.autoIncrement;

  String sheetName = '';
  int sheetID = -1;
  String stars = '';

  Star();
}
