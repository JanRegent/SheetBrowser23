import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetbrowser/1pres_layer/alib/alib.dart';
import 'package:sheetbrowser/data_layer/getsheetdl.dart';

import '../../data_layer/isloading/isloading.dart';

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider((ref) => 0);

class SidebarHome extends ConsumerWidget {
  const SidebarHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home page')),
      body: homeBody(ref, context),
    );
  }

  // await getAppendStarredManually(
  //     ['cccc2GET8', 'aaaa28', 'ssss8', 'pb8', '118'], context);

  Widget homeBody(ref, BuildContext context) {
    return Column(
      children: [
        isloadingListTile(),
        al.linkIconOpenUrlNoDoc(
            appendUrl4launcher(['cccc2GET88', 'aaaa288', 'ssss88', 'pb', '11']),
            context)
      ],
    );
  }
}
