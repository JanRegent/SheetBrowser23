import 'package:clipboard/clipboard.dart';
import 'package:csv/csv.dart';
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

  IconButton csvrow2clipboard() {
    return IconButton(
        onPressed: () {
          String res = const ListToCsvConverter().convert([
            [',b', 3.1, 42],
            ['n\n']
          ]);
          res = const ListToCsvConverter().convert([
            [
              'ID?',
              'pb8',
              '118',
              'Včera se v 05:56:36 SEČ odpojila od modulu Zvezda na Mezinárodní kosmické stanici nákladní loď Progress MS-20. V 09:04 provedla brzdící manévr a 33 minut později vstoupila do atmosféry Země. Trosky dopadly okolo 09:45 SEČ do vod Tichého oceánu. Uvolnila prostor Progressu MS-22.',
              'aaaa28',
              'ssss8'
            ]
          ]);
          FlutterClipboard.copy(res).then((value) => {});
        },
        icon: const Icon(Icons.copy));
  }

  Widget homeBody(ref, BuildContext context) {
    return Column(
      children: [
        isloadingListTile(),
        al.linkIconOpenUrlNoDoc(
            appendUrl4launcher(
                ['Brunton Paul', '11', 'cccc2GET88', 'aaaa288', 'ssss88']),
            context),
        csvrow2clipboard()
      ],
    );
  }
}
