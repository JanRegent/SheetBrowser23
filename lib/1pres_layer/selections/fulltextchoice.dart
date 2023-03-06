import 'package:flutter/material.dart';

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
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const SearchPage('By Date'),
                  ));
            },
          ),
          ElevatedButton(
            child: const Text('By words'),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const SearchPage('By words'),
                  ));
            },
          )
        ],
      )),
    );
  }
}
