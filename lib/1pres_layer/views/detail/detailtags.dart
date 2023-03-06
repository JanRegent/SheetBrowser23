import 'package:flutter/material.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';

import '../../../data_layer/getsheetdl.dart';
import '../../alib/alib.dart';

//------------------------------------------------------tags

final TextEditingController addTagsController = TextEditingController();

addTagsDialog(BuildContext context, Map rowmap, int localId) async {
  List<String> tags = rowmap['tags'];
  addTagsController.text = tags.join(',');
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tags comma delimited'),
          content: TextField(
            controller: addTagsController,
            decoration: const InputDecoration(hintText: "Enter Text"),
          ),
          actions: [
            ElevatedButton(
                child: const Icon(Icons.cancel),
                onPressed: () async {
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
                child: const Icon(Icons.star),
                onPressed: () async {
                  if (addTagsController.text.contains('*')) return;
                  if (addTagsController.text.isEmpty) {
                    addTagsController.text = '*';
                  } else {
                    addTagsController.text = '*,${addTagsController.text}';
                  }
                }),
            ElevatedButton(
              child: const Icon(Icons.save),
              onPressed: () async {
                Navigator.of(context).pop();
                al.message(context, 'Adding tags');
                rowmap['tags'] = addTagsController.text.split(',');
                await appendTagsCommunity(
                    rowmap['sheetName'], rowmap['ID'], addTagsController.text);
                await sheetDb.updateOps
                    .updateTags(localId, addTagsController.text);
                rowmap['tags'] = addTagsController.text;
              },
            )
          ],
        );
      });
}
