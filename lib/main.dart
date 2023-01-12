import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '1pres_layer/views/grid_detailpage.dart';

import '3domain_layer/localdata/appdata.dart';

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPrefs instance.
  await AppDataPrefs.init();
  await AppDataPrefs.appdataLoad();

  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: GtridDetailPage());

    //GtridDetailPage());
  }
}
