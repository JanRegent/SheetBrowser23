import 'package:clipboard/clipboard.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../2business_layer/appdata/approotdata.dart';
import '../../data_layer/isloading/backgrounscompleter.dart';
import '../alib/uti.dart';

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider((ref) => 0);

class SidebarHome extends StatefulWidget {
  const SidebarHome({super.key});

  @override
  State<SidebarHome> createState() => _SidebarHomeState();
}

class _SidebarHomeState extends State<SidebarHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home page')),
      body: homeBody(context),
    );
  }

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

  ListTile backgroundCompleterLastDateListTile() {
    return ListTile(
        leading: Obx(() => Text(' ${isloadingAction.value}',
            style: const TextStyle(fontSize: 18))),
        title: Obx(() => Text(' ${isloadingPhaseMessage.value}',
            style: const TextStyle(fontSize: 18))),
        trailing: IconButton(
            onPressed: () async {
              await appDataPrefs.setString('backgroundCompleter-lastDate',
                  'loading for ${blUti.todayStr()}');
              setState(() {
                backgroundCompleterIsRunning = true;
              });

              backgroundCompleter();
              setState(() {
                backgroundCompleterIsRunning = false;
              });
            },
            icon: const Icon(Icons.refresh)));
  }

  Widget homeBody(BuildContext context) {
    return Column(
      children: [
        backgroundCompleterIsRunning
            ? const Text('Updating, please wait a few minutes...')
            : backgroundCompleterLastDateListTile()
      ],
    );
  }
}
