import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/00_introduction.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/01_body_placement.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/02_gps_location.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/03_bluetooth.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/04_connected_device.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  
  static final introductionPage = IntroductionPage();
  static final bodyPlacementSetting = BodyPlacementSetting();
  static final gpsSetting = GpsSetting();
  static final bluetoothSetting = BluetoothSetting();
  static final connectedDeviceSetting = ConnectedDeviceSetting();

  static final _settingsItems = [
    introductionPage,
    bodyPlacementSetting,
    gpsSetting,
    bluetoothSetting,
    connectedDeviceSetting
  ];

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    homePageStore.introductionPageIndex = _settingsItems.indexOf(introductionPage);
    homePageStore.bodyPlacementPageIndex = _settingsItems.indexOf(bodyPlacementSetting);
    homePageStore.gpsPageIndex = _settingsItems.indexOf(gpsSetting);
    homePageStore.bluetoothPageIndex = _settingsItems.indexOf(bluetoothSetting);
    homePageStore.connectedDevicePageIndex = _settingsItems.indexOf(connectedDeviceSetting);

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
              homePageStore.setCurrentPageIndex(index);
              _currentPageNotifier.value = index;
            },
          ),
        ),
      );
    }

    Color _getProgressIndicatorColor() {
      if (homePageStore.currentPageIndex == 0) {
        return Colors.grey;
      } else {
        if(homePageStore.bluetoothState == BluetoothState.off 
        || homePageStore.bluetoothState == BluetoothState.unavailable
        || homePageStore.bluetoothState == BluetoothState.unauthorized) {
          return Colors.red;
        }
      }
      return Colors.lightGreenAccent;
    }

    _buildLinearProgressIndicator() {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Observer(
          builder: (_) => LinearProgressPageIndicator(
            itemCount: _settingsItems.length,
            currentPageNotifier: _currentPageNotifier,
            progressColor: _getProgressIndicatorColor(),
            backgroundColor: Color.fromRGBO(158, 166, 186, 0.1),
            width: constraints.maxWidth,
            height: 10,
          ),
        ),
      );
    }

    Color _getBottomBarIconColor(int iconIndex) {
      return (_currentPageNotifier.value >= iconIndex ? Colors.lightGreenAccent : Colors.white);
    }

    Icon _getBottomBarFavoriteIcon() {
      return (_currentPageNotifier.value == 0
          ? Icon(Icons.favorite_border, color: Colors.white)
          : Icon(Icons.favorite, color: Colors.red));
    }

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
              icon: Icon(Icons.location_off, color: _getBottomBarIconColor(2)),
              onPressed: () {},
            ),
            Observer(
              builder: (_) => IconButton(
                icon: bluetoothSetting.getBottomIcon(context),
                onPressed: () {},
              ),
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
}
