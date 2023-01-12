import 'package:flutter/material.dart';

import '../../2app_layer/getdata.dart';
import 'detail/carousel.dart';

class GtridDetailPage extends StatefulWidget {
  const GtridDetailPage({super.key});

  @override
  State<GtridDetailPage> createState() => _GtridDetailPageState();
}

class _GtridDetailPageState extends State<GtridDetailPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List>(
        future:
            getSheetValues(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return Carousel(snapshot.data!);
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
