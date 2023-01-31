import 'package:isar/isar.dart';

part 'sheet.g.dart';

// dart  run build_runner build

@collection
class Sheet {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index(type: IndexType.value)
  String? sheetName;
  late int sheetId;

  @Index(type: IndexType.value)
  String? key;
  List<String>? listStr;
  List<int>? listInt;

  @enumerated
  Status status = Status.pending;

  @Index(type: IndexType.value)
  String? fileId;
}

@embedded
class Recipient {
  String? name;

  String? address;
}

enum Status {
  draft,
  pending,
  sent,
}
