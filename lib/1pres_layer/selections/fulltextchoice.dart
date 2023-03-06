import 'package:flutter/material.dart';

import '../../2business_layer/appdata/approotdata.dart';
import '../alib/uti.dart';
import 'fulltextsearchpage.dart';

class FulltextChoicePage extends StatelessWidget {
  const FulltextChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('By date or word?'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            child: const Text('By Date'),
            onPressed: () async {
              List<String> keysNames = blUti.lastNdays(5);
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SearchPage('By Date', keysNames),
                  ));
            },
          ),
          ElevatedButton(
            child: const Text('By words'),
            onPressed: () async {
              String keyNamesStr =
                  await appData.appDataGetString('fulltextHintWords');
              List<String> keyNames = keyNamesStr.split(',');
              // ignore: use_build_context_synchronously
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SearchPage('By words', keyNames),
                  ));
            },
          )
        ],
      )),
    );
  }
}
