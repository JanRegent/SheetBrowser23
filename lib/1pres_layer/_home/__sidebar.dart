import 'package:flutter/material.dart';

import 'package:sidebarx/sidebarx.dart';

import '../../2business_layer/appdata/appsettingspage.dart';
import '../../2business_layer/getdata.dart';

import '../../2business_layer/models/sheetdb/_sheetdb.dart';
import '../../data_layer/isloading/isloading.dart';
import '../filelist/filelistcard.dart';
import '../filelist/inboxhome.dart';
import '../gettags_getnews/searchpage.dart';
import '../gettags_getnews/tagselectpage.dart';
import '../views/plutogrid/_gridpage.dart';
import '_home.dart';

class SidebarXApp extends StatelessWidget {
  SidebarXApp({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SheetsBrowser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    title: const Text('Home Page'),
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  )
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return const SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('SheetsBrowser'),
          ),
        );
      },
      items: [
        SidebarXItem(icon: Icons.home, label: 'Home', onTap: () async {}),
        SidebarXItem(
            icon: Icons.list,
            label: 'Inbox',
            onTap: () async {
              await getFilelist();
              // ignore: use_build_context_synchronously
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => InboxHomePage(filelist),
                  ));
            }),
        SidebarXItem(
            icon: Icons.search,
            label: 'Search',
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const SearchPage(),
                  ));
            }),
        SidebarXItem(
            icon: Icons.star,
            label: 'Starred',
            onTap: () async {
              isloadingPhaseMessage.value = 'Loading starred';
              await currentSheet.getSheet('starred2022', '');
              isloadingPhaseMessage.value = '';
              // ignore: use_build_context_synchronously
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => GridPage(
                            currentSheet.plutoCols,
                            currentSheet.gridrows,
                          )));
            }),
        SidebarXItem(
            icon: Icons.label,
            label: 'Tags',
            onTap: () async {
              isloadingPhaseMessage.value = 'Loading tags';
              List<String> tags = await tagsDb.readTags();
              isloadingPhaseMessage.value = '';
              // ignore: use_build_context_synchronously
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => TagSelectPage(tags),
                  ));
            }),
        SidebarXItem(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const AppSettingsPage(),
                  ));
            }),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          default:
            return const SidebarHome();
        }
      },
    );
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
