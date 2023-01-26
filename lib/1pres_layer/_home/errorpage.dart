import 'package:flutter/material.dart';

import '../../2business_layer/approotdata.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String errMess;
  @override
  void initState() {
    super.initState();
    errMess = AppDataPrefs.getString('errorLastDL')!;
  }

  String helpMess(String errMess) {
    if (errMess == 'Error:[DL] Could not connect to server') {
      return 'Has Sheet public access rights: \n "Anyone with the link"?'
          '\n\n'
          'Error:[DL] Could not connect to server';
    }
    return errMess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Error Page'),
          backgroundColor: Colors.lime,
        ),
        body: Center(child: Text(helpMess(errMess))));
  }
}
