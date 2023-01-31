import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetbrowser/routerswitch.dart';

import '1pres_layer/_home/errorpage.dart';
import '2business_layer/approotdata.dart';

import '2business_layer/models/sheetdb.dart';
import 'data_layer/backgrounscompleter.dart';

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();
  await dbInit();
  try {
    await AppDataPrefs.init();
    await AppDataPrefs.appRootConfigLoad();

    backgroundCompleter();
    runApp(
      const ProviderScope(child: SheetBrowserApp()),
    );
  } catch (e) {
    runApp(
      const ErrorPage(),
    );
  }
}

class SheetBrowserApp extends StatelessWidget {
  const SheetBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: RouterSwitch());
  }
}
