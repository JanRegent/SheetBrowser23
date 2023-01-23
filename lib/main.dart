import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetbrowse/routerswitch.dart';

import '2business_layer/approotdata.dart';
import 'data_layer/backgrounscompleter.dart';

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  await AppDataPrefs.init();
  await AppDataPrefs.appRootConfigLoad();
  backgroundCompleter();
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: SheetBrowserApp()),
  );
}

class SheetBrowserApp extends StatelessWidget {
  const SheetBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: RouterSwitch());
  }
}
