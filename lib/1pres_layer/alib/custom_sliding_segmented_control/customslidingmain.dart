import './example_1.dart';
import './example_10.dart';
import './example_11.dart';
import './example_2.dart';
import './example_4.dart';
import './example_5.dart';
import './example_6.dart';
import './example_9.dart';
import 'package:flutter/material.dart';

//https://flutterawesome.com/custom-sliding-segmented-control-with-flutter/
class CustomSlidingPage extends StatelessWidget {
  const CustomSlidingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examples'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 16),
            Example1(),
            SizedBox(height: 16),
            Example2(),
            SizedBox(height: 16),
            Example4(),
            SizedBox(height: 16),
            Example5(),
            SizedBox(height: 16),
            Example6(),
            SizedBox(height: 16),
            SizedBox(height: 16),
            SizedBox(height: 16),
            Example9(),
            SizedBox(height: 16),
            Example10(),
            SizedBox(height: 16),
            Example11(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
