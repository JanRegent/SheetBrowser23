import 'package:flutter/material.dart';
import 'package:sheetbrowser/2business_layer/models/sheetdb/_sheetdb.dart';

import '../../../../data_layer/getsheetdl.dart';
import '../../../alib/alib.dart';

//------------------------------------------------------tags

final TextEditingController addTagsController = TextEditingController();

addTagsDialog(BuildContext context, Map rowmap, int localId) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add tags comma delimited'),
          content: TextField(
            controller: addTagsController,
            decoration: const InputDecoration(hintText: "Enter Text"),
          ),
          actions: [
            ElevatedButton(
              child: const Text('SUBMIT'),
              onPressed: () async {
                Navigator.of(context).pop();
                al.message(context, 'Adding tags');
                await appendTagsCommunity(
                    rowmap['sheetName'], rowmap['ID'], addTagsController.text);
                await sheetDb.updateOps
                    .updateTags(localId, addTagsController.text);
              },
            )
          ],
        );
      });
}
