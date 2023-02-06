import 'package:isar/isar.dart';

part 'sheet.g.dart';

// dart  run build_runner build

@Collection()
class Sheet {
  @Id()
  int id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String aSheetName = '';
  int sheetId = -1;

  @Index(type: IndexType.value)
  String aKey = 'row';
  List<String> listStr = [];
  String starred = '';

  @Index(type: IndexType.value)
  String zfileId = '';

  Future toStrings() async {
    '''
    -----------------------------------------------------sheet
    id          $id
    aSheetName  $aSheetName
  
    aKey    $aKey

    listStr
    $listStr                

    zfileId     $zfileId
  ''';
  }
}

enum Status {
  draft,
  pending,
  sent,
}
