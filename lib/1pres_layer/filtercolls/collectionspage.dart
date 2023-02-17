import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_layout/pluto_layout.dart';

import '../filelist/filelistcard.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  Widget collCard() {
    return filelistCard(context, getConfigRowSheetName('dailyNotes'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
      ),
      body: PlutoLayout(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.escape):
              PlutoLayoutActions.hideAllTabView(),
          LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit1):
              PlutoLayoutActions.rotateTabView(
            PlutoLayoutId.left,
          ),
          LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit2):
              PlutoLayoutActions.rotateTabView(
            PlutoLayoutId.right,
          ),
          LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowUp):
              PlutoLayoutActions.increaseTabView(),
          LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowDown):
              PlutoLayoutActions.decreaseTabView(),
        },
        body: PlutoLayoutContainer(child: collCard()
            //Text('Body container'),
            ),
        top: PlutoLayoutContainer(
          child: PlutoLayoutTabs(
            items: [
              PlutoLayoutTabItem(
                id: 'top1',
                title: 'top1',
                tabViewWidget: const Text('top1'),
              ),
              PlutoLayoutTabItem(
                id: 'top2',
                title: 'top2',
                tabViewWidget: const Text('top2'),
              ),
            ],
          ),
        ),
        left: PlutoLayoutContainer(
          child: PlutoLayoutTabs(
            items: [
              PlutoLayoutTabItem(
                id: 'left1',
                title: 'left1',
                tabViewWidget: const Text('left1'),
              ),
              PlutoLayoutTabItem(
                id: 'left2',
                title: 'left2',
                tabViewWidget: const Text('left2'),
              ),
            ],
          ),
        ),
        right: PlutoLayoutContainer(
          child: PlutoLayoutTabs(
            items: [
              PlutoLayoutTabItem(
                id: 'right1',
                title: 'right1',
                tabViewWidget: const Text('right1'),
              ),
              PlutoLayoutTabItem(
                id: 'right2',
                title: 'right2',
                tabViewWidget: const Text('right2'),
              ),
            ],
          ),
        ),
        bottom: PlutoLayoutContainer(
          child: PlutoLayoutTabs(
            items: [
              PlutoLayoutTabItem(
                id: 'bottom1',
                title: 'bottom1',
                tabViewWidget: const Text('bottom1'),
              ),
              PlutoLayoutTabItem(
                id: 'bottom2',
                title: 'bottom2',
                tabViewWidget: const Text('bottom2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
