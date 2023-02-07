import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetbrowser/routerswitch.dart';

import '1pres_layer/_home/errorpage.dart';
import '2business_layer/appdata/approotdata.dart';

import '2business_layer/models/sheetdb/_sheetdb.dart';
import 'data_layer/getsheetdl.dart';
import 'data_layer/isloading/backgrounscompleter.dart';

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  if (!await mainInit()) return;

  //postAppendStarred(['cccc2', 'aaaa2', 'ssss', 'pb', '11']);
  await getAppendStarred(['cccc2GET', 'aaaa2', 'ssss', 'pb', '11']);

  try {
    runApp(
      const ProviderScope(child: SheetBrowserApp()),
    );
  } catch (e, s) {
    logDb.createErr('main().RouterSwitch()', e.toString(), s.toString());
    runApp(
      const ErrorPage2('main().RouterSwitch()'),
    );
  }
}

Future<bool> mainInit() async {
  try {
    await dbInit();
  } catch (e, s) {
    logDb.createErr('main().dbInit()', e.toString(), s.toString());

    runApp(
      const ErrorPage2('main().dbInit()'),
    );
    return false;
  }
  try {
    await AppDataPrefs.init();
  } catch (e, s) {
    logDb.createErr('main().AppDataPrefs.init()', e.toString(), s.toString());

    runApp(
      const ErrorPage2('main().AppDataPrefs.init()'),
    );
    return false;
  }

  try {
    await AppDataPrefs.apikeyRootSheetIdLoad();
  } catch (e, s) {
    logDb.createErr(
        'main().AppDataPrefs.appRootConfigLoad()', e.toString(), s.toString());

    runApp(
      const ErrorPage2('main().AppDataPrefs.appRootConfigLoad()'),
    );
    return false;
  }

  backgroundCompleter();

  return true;
}

class SheetBrowserApp extends StatelessWidget {
  const SheetBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: RouterSwitch());
  }
}
