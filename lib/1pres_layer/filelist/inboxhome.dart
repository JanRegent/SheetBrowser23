// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'inboxrightpopmenu.dart';
import 'filelistcard.dart';

// ignore: must_be_immutable
class InboxHomePage extends StatefulWidget {
  final List<dynamic> filelist;
  const InboxHomePage(this.filelist, {Key? key}) : super(key: key);

  @override
  State<InboxHomePage> createState() => _InboxHomePageState();
}

class _InboxHomePageState extends State<InboxHomePage>
    with WidgetsBindingObserver {
  String filelistName = '';
  @override
  void initState() {
    super.initState();
  }

  Widget filelistBody() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey[50],
        child: ListView.builder(
            itemCount: widget.filelist.length,
            itemBuilder: (context, index) {
              return Center(
                  child: filelistCard(context, widget.filelist[index]));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(filelistName),
          backgroundColor: Colors.lightBlue,
          actions: [rightPopup(context)],
        ),
        body: filelistBody());
  }
}
