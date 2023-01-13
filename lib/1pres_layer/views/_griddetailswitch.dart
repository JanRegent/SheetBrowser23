import 'package:flutter/material.dart';

import '../../2app_layer/getdata.dart';
import 'detail/carousel.dart';
import 'plutogrid/gridtable.dart';

class GtridDetailSwitch extends StatefulWidget {
  const GtridDetailSwitch({super.key});

  @override
  State<GtridDetailSwitch> createState() => _GtridDetailSwitchState();
}

class _GtridDetailSwitchState extends State<GtridDetailSwitch> {
  String layout = 'detail';
  Row titleSwitch() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              layout = 'grid';
              setState(() {});
            },
            icon: const Icon(Icons.grid_4x4)),
        IconButton(
            onPressed: () {
              layout = 'detail';
              setState(() {});
            },
            icon: const Icon(Icons.list))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: titleSwitch(),
          //   actions: [
          //   // sheetRightPopup(context, widget.rowmap)
          // ]
        ),
        body: DefaultTextStyle(
          style: Theme.of(context).textTheme.displayMedium!,
          textAlign: TextAlign.center,
          child: FutureBuilder<List>(
            future:
                getSheetValues(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                if (layout == 'detail') {
                  return Carousel(snapshot.data!);
                } else {
                  return const PlutoGridExamplePage();
                  // (snapshot.data!);
                }
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
        ));
  }
}
