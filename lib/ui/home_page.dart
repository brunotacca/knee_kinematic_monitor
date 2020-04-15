import 'package:flutter/material.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/00_introduction.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/01_body_placement.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/02_bluetooth.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/03_gps_location.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/04_connected_device.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _settingsItems = [
    IntroductionPage(),
    BodyPlacementSetting(),
    BluetoothSetting(),
    GpsSetting(),
    ConnectedDeviceSetting()
  ];

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text("Cinematic Data Gatherer"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    final makeBody = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildPageView(),
        _buildLinearProgressIndicator(),
      ],
    );

    final makeBottom = Container(
      height: 45.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: _getBottomBarFavoriteIcon(),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.directions_walk, color: _getBottomBarIconColor(1)),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.bluetooth_disabled, color: _getBottomBarIconColor(2)),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.location_off, color: _getBottomBarIconColor(3)),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.device_hub, color: _getBottomBarIconColor(4)),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }

  _buildPageView() {
    return Expanded(
      child: Container(
        child: PageView.builder(
            itemCount: _settingsItems.length,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              return _settingsItems[index];
            },
            onPageChanged: (int index) {
              setState(() {
                _currentPageNotifier.value = index;
              });
            }),
      ),
    );
  }

  _buildLinearProgressIndicator() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => LinearProgressPageIndicator(
        itemCount: _settingsItems.length,
        currentPageNotifier: _currentPageNotifier,
        progressColor: (_currentPageNotifier.value==0)?Colors.grey:Colors.lightGreenAccent,
        backgroundColor: Color.fromRGBO(158, 166, 186, 0.1),
        width: constraints.maxWidth,
        height: 10,
      ),
    );
  }

  Color _getBottomBarIconColor(int iconIndex) {
    return (_currentPageNotifier.value >= iconIndex ? Colors.lightGreenAccent : Colors.white);
  }
  Icon _getBottomBarFavoriteIcon() {
    return (_currentPageNotifier.value == 0 ? Icon(Icons.favorite_border, color: Colors.white) : Icon(Icons.favorite, color: Colors.red));
  }
}
