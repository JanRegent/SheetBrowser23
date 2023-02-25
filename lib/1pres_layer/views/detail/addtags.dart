import 'package:flutter/material.dart';

import '../../../data_layer/getsheetdl.dart';
import '../../alib/alib.dart';

final TextEditingController addTagsController = TextEditingController();

addTagsDialog(BuildContext context, Map rowmap) async {
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
              },
            )
          ],
        );
      });
}
