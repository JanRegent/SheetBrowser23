import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

part 'log.g.dart'; // flutter pub run build_runner build

/*
https://stackoverflow.com/questions/72655458/how-to-open-the-isar-inspector
Set inspector:true in Isar.open()
Isar.open(
      schemas: [...],
      directory: dir.path,
      inspector: true,
    );
Download and install the isar inspector here for windows and here for mac

Look for this link in the logs ws://127.0.0.1:63001/addadada=/ copy it.

flutter: ╔════════════════════════════════════════╗
flutter: ║          ISAR CONNECT STARTED          ║
flutter: ╟────────────────────────────────────────╢
flutter: ║ Open the Isar Inspector and enter the  ║
flutter: ║ following URL to connect:              ║
flutter: ╟────────────────────────────────────────╢
flutter: ║   ws://127.0.0.1:63001/addadada=/      ║
flutter: ╚════════════════════════════════════════╝

*/

@Collection()
class Log {
  @Id()
  int id = Isar.autoIncrement;
  String aDateTime = DateTime.now().toIso8601String();
  String clasFunc = '';
  String aStep = '';
  String descr = '';
  String mess = '';
  String error = '';
  String stackTrace = '';
  Log();

  void print() {
    debugPrint('''
  id $id
  aFunc $clasFunc
  aStep $aStep
  descr $descr
  mess  $mess

  stackTrace 
      $stackTrace
''');
  }

  @override
  String toString() {
    return 'Log(id: $id, aFunc: $clasFunc, aStep: $aStep, descr: $descr, mess: $mess, error: $error, stackTrace: $stackTrace)';
  }
}

class LogDb {
  final Isar isar;
  LogDb(this.isar);

  Future create(Log log) async {
    try {
      await isar.writeTxn((isar) async {
        log.id = await isar.logs.put(log); // insert
      });
      return 'OK';
    } catch (e) {
      debugPrint(e.toString());
      // logi('--- LocalStore: ', '-----------------isar');
      // logi('updateSheetView(String ', sheetView.aQuerystringKey);
      // logi('updateSheetView(String ', e.toString());
      return '';
    }
  }

  Future createErr(String clasFunc, error, stackTrace,
      {String description = ''}) async {
    try {
      Log log = Log()
        ..clasFunc = clasFunc
        ..error = error
        ..stackTrace = stackTrace.toString();
      await isar.writeTxn((isar) async {
        await isar.logs.put(log); // insert
      });
      return 'OK';
    } catch (e) {
      debugPrint(e.toString());
      // logi('--- LocalStore: ', '-----------------isar');
      // logi('updateSheetView(String ', sheetView.aQuerystringKey);
      // logi('updateSheetView(String ', e.toString());
      return '';
    }
  }

  Future clear() async {
    await isar.writeTxn((isar) async {
      await isar.logs.clear();
    });
  }
}
