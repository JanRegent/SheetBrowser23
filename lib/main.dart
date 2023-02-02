import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetbrowser/routerswitch.dart';

import '1pres_layer/_home/errorpage.dart';
import '2business_layer/appdata/approotdata.dart';

import '2business_layer/models/sheetdb.dart';
import 'data_layer/backgrounscompleter.dart';

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  if (!await mainInit()) return;

  try {
    runApp(
      const ProviderScope(child: SheetBrowserApp()),
    );
  } catch (e) {
    runApp(
      const ErrorPage2('main().RouterSwitch()'),
    );
  }
}

Future<bool> mainInit() async {
  try {
    await dbInit();
  } catch (e) {
    runApp(
      const ErrorPage2('main().dbInit()'),
    );
    return false;
  }

  try {
    await AppDataPrefs.init();
  } catch (e) {
    runApp(
      const ErrorPage2('main().AppDataPrefs.init()'),
    );
    return false;
  }

  try {
    await AppDataPrefs.apikeyRootSheetIdLoad();
  } catch (e) {
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
