import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheetbrowser/2business_layer/appdata/appversion.dart';
import 'package:sheetbrowser/2business_layer/buildversion.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _chatResult = true;
  // ignore: unused_field
  String _searchAreaResult = 'Germany';
  bool _titleOnTop = false;

  @override
  Widget build(BuildContext context) {
    final titleOnTopSwitch = SettingRow(
        rowData: SettingsYesNoConfig(
            initialValue: _titleOnTop, title: 'Title on top'),
        config: const SettingsRowConfiguration(showAsSingleSetting: true),
        onSettingDataRowChange: (newVal) => setState(() {
              _titleOnTop = newVal;
            }));

    final legalStuff = Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
              child: Text('Legal',
                  style: TextStyle(
                    color: CupertinoColors.systemBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ))),
          SettingRow(
            config: SettingsRowConfiguration(
                showTitleLeft: !_titleOnTop, showTopTitle: _titleOnTop),
            rowData: SettingsURLConfig(
                title: 'Privacy', url: 'https://yourprivacystuff.de'),
            onSettingDataRowChange: () => {},
          ),
          SizedBox(height: _titleOnTop ? 10.0 : 0.0),
          SettingRow(
            config: SettingsRowConfiguration(
                showTitleLeft: !_titleOnTop, showTopTitle: _titleOnTop),
            rowData: SettingsButtonConfig(
                title: 'Licenses',
                tick: true,
                functionToCall: () => showLicensePage(
                    context: context,
                    applicationName: 'example',
                    applicationVersion: 'v1.1',
                    useRootNavigator: true)),
            onSettingDataRowChange: () => {},
          ),
        ],
      ),
    );

    bool selected = true;
    final backroundCompleter = ActionChip(
        backgroundColor: Colors.brown.shade200,
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        // ignore: dead_code
        avatar: selected ? const CircularProgressIndicator() : null,
        label: Text(
          // ignore: dead_code
          selected ? "Cancel" : "Download",
          style: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          selected = !selected;
          setState(() {});
        },
        elevation: 8);

    final privacySettings = Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
              child: Text(
                'Privacy Settings',
                style: TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              )),
          SettingRow(
            config: SettingsRowConfiguration(
                showTitleLeft: !_titleOnTop, showTopTitle: _titleOnTop),
            rowData: SettingsYesNoConfig(
                initialValue: _chatResult, title: 'Allow Chat'),
            onSettingDataRowChange: onChatSettingChange,
          ),
        ],
      ),
    );

    final modifyProfileTile = Material(
        color: Colors.transparent,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                  child: Text(
                    'Profile Options',
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  )),
              SettingRow(
                rowData: SettingsButtonConfig(
                  title: 'Delete Profile',
                  tick: true,
                  functionToCall: () {},
                ),
                style: const SettingsRowStyle(
                    backgroundColor: CupertinoColors.lightBackgroundGray),
                config: SettingsRowConfiguration(
                    showAsTextField: false,
                    showTitleLeft: !_titleOnTop,
                    showTopTitle: _titleOnTop,
                    showAsSingleSetting: false),
                onSettingDataRowChange: () => {},
              )
            ]));
    Column version() {
      return Column(
        children: const [
          Text('buildVersion: $buildVersion'),
          Text('appVersion:   $appVersion'),
        ],
      );
    }

    Widget buildSegment(String text) {
      return Text(
        text,
        style: const TextStyle(fontSize: 22, color: Colors.black),
      );
    }

    int? groupValue = 0;
    Container segmentedButton() {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: CupertinoSlidingSegmentedControl<int>(
          backgroundColor: CupertinoColors.white,
          thumbColor: CupertinoColors.activeGreen,
          padding: const EdgeInsets.all(8),
          groupValue: groupValue,
          children: {
            0: buildSegment("Flutter"),
            1: buildSegment("React"),
            2: buildSegment("Native"),
          },
          onValueChanged: (value) {
            setState(() {
              groupValue = value;
            });
          },
        ),
      );
    }

    final List<Widget> widgetList = [
      version(),
      segmentedButton(),
      titleOnTopSwitch,
      backroundCompleter,
      const SizedBox(height: 15.0),
      privacySettings,
      const SizedBox(height: 15.0),
      legalStuff,
      const SizedBox(height: 15.0),
      Row(children: [Expanded(child: modifyProfileTile)]),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('App settings')),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: widgetList)),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  void onChatSettingChange(bool data) {
    setState(() {
      _chatResult = data;
    });
  }

  void onSearchAreaChange(String data) {
    setState(() {
      _searchAreaResult = data;
    });
  }
}
