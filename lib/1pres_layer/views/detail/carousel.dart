import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter/material.dart';

import 'detailpage.dart';

class Carousel extends StatefulWidget {
  final List<int> ids;
  final Map configRowFilelistRow;
  final int startRow;
  const Carousel(this.ids, this.configRowFilelistRow, this.startRow,
      {super.key});

  @override
  State<StatefulWidget> createState() {
    return CarouselState();
  }
}

class CarouselState extends State<Carousel> {
  final CarouselController _controller = CarouselController();
  // ignore: unused_field
  int _current = 0;

  late List<Widget> sliders;
  @override
  void initState() {
    super.initState();

    var slides = List.generate(
      widget.ids.length,
      (index) {
        //return Text(index.toString());
        Map rowmap = {};
        rowmap[index] = index.toString();
        return DetailPage(rowmap, widget.configRowFilelistRow);
      },
    );

    sliders = slides
        .map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 200,
                child: Center(
                  child: item,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manually Controlled Slider')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FlutterCarousel(
                items: sliders,
                options: CarouselOptions(
                  initialPage: 3,
                  onPageChanged: (int index, CarouselPageChangedReason reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  viewportFraction: 1.0,
                  autoPlay: false,
                  floatingIndicator: false,
                  enableInfiniteScroll: true,
                  controller: _controller,
                  slideIndicator: CircularWaveSlideIndicator(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: _controller.previousPage,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Text((_current + 1).toString()),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: _controller.nextPage,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class Slide {
//   Slide({
//     required this.title,
//     required this.height,
//     required this.color,
//   });

//   final Color color;
//   final double height;
//   final String title;
// }

// var slides = List.generate(
//   widget.ids.length,
//   (index) => Slide(
//     title: 'Slide ${index + 1}',
//     height: 100.0 + index * 50,
//     color: Colors.primaries[index % Colors.primaries.length],
//   ),
// );

// final List<Widget> sliders = slides
//     .map(
//       (item) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4.0),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//           child: Container(
//             color: item.color,
//             width: double.infinity,
//             height: item.height,
//             child: Center(
//               child: Text(
//                 item.title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     )
//     .toList();
