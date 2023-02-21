import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';



class ErrorPage2 extends StatefulWidget {
  final String errorPageMess2;
  final Object configFileTemplate;
  const ErrorPage2(this.errorPageMess2, this.configFileTemplate,{Key? key}) : super(key: key);

  @override
  State<ErrorPage2> createState() => _ErrorPage2State();
}

class _ErrorPage2State extends State<ErrorPage2> {
  late final String errMess;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Error Page'),
            backgroundColor: Colors.lime,
          ),
          body: Center(
              child: Column(
            children: [
              Text(widget.errorPageMess2),
              JsonViewer(widget.configFileTemplate.toString())
            ],
          ))),
      builder: EasyLoading.init(),
    );

    //Text(helpMess('$errMess\n\n${widget.errorPageMess2}'))));
  }
}
