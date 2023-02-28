import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetbrowser/routerswitch.dart';

import '1pres_layer/_home/help/errorpage.dart';
import '2business_layer/appdata/approotdata.dart';

import '2business_layer/models/sheetdb/_sheetdb.dart';

import 'data_layer/isloading/backgrounscompleter.dart';

//chatGPT
//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
//https://platform.openai.com/account/api-keys
//https://medium.com/@flutterqueen/chatgpt-extension-for-vs-code-12fde2c2ef74

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  if (!await mainInit()) return;

  try {
    runApp(
      const ProviderScope(child: SheetBrowserApp()),
    );
  } catch (e, s) {
    logDb.createErr('main().RouterSwitch()', e.toString(), s.toString());
    runApp(
      const ErrorPage2('main().RouterSwitch()', ''),
    );
  }
}

Future<bool> mainInit() async {
  EasyLoading.init();

  try {
    await dbInit();
  } catch (e) {
    runApp(
      ErrorPage2('Error.dbInit:$e', ''),
    );

    return false;
  }

  try {
    await AppDataPrefs.init();
  } catch (e, s) {
    logDb.createErr('main().AppDataPrefs.init()', e.toString(), s.toString());

    runApp(
      const ErrorPage2('main().AppDataPrefs.init()', ''),
    );
    return false;
  }

  try {
    await AppDataPrefs.apikeyRootSheetIdLoad();
  } catch (e, s) {
    logDb.createErr(
        'main().AppDataPrefs.appRootConfigLoad()', e.toString(), s.toString());

    if (appDataPrefsApdataLoadingError.contains('apikey')) {
      runApp(
        ErrorPage2(
            appDataPrefsApdataLoadingError, const {"apikey": "My  apikey"}),
      );
    } else {
      runApp(
        ErrorPage2(appDataPrefsApdataLoadingError,
            const {"rootSheetId": "My root sheet Id"}),
      );
    }

    return false;
  }

  backgroundCompleter(() {});

  return true;
}

class SheetBrowserApp extends StatelessWidget {
  const SheetBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RouterSwitch(),
      builder: EasyLoading.init(),
    );
  }
}
