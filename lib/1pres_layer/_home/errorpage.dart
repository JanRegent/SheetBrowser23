import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ErrorPage extends StatelessWidget {
  final String errorPageMess;
  const ErrorPage(this.errorPageMess, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: ErrorPage2(errorPageMess),
    );
  }
}

class ErrorPage2 extends StatefulWidget {
  final String errorPageMess2;
  const ErrorPage2(this.errorPageMess2, {Key? key}) : super(key: key);

  @override
  State<ErrorPage2> createState() => _ErrorPage2State();
}

class _ErrorPage2State extends State<ErrorPage2> {
  late final String errMess;
  @override
  void initState() {
    super.initState();
   
  }

  // String helpMess(String errMess) {
  //   if (errMess == 'Error:[DL] Could not connect to server') {
  //     return 'Has Sheet public access rights: \n "Anyone with the link"?'
  //         '\n\n'
  //         'Error:[DL] Could not connect to server';
  //   }
  //   return errMess;
  // }

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
            child: Text(widget.errorPageMess2))),
      builder: EasyLoading.init(),
    );

  
            
            //Text(helpMess('$errMess\n\n${widget.errorPageMess2}'))));
  }
}
