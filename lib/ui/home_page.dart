import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:knee_kinematic_monitor/stores/global_settings.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:knee_kinematic_monitor/ui/start_settings/introduction.dart';
import 'package:knee_kinematic_monitor/ui/start_settings/body_placement.dart';
import 'package:knee_kinematic_monitor/ui/start_settings/gps_location.dart';
import 'package:knee_kinematic_monitor/ui/start_settings/extra_permission.dart';
import 'package:knee_kinematic_monitor/ui/start_settings/bluetooth.dart';
import 'package:knee_kinematic_monitor/ui/start_settings/connected_device.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  static final introductionPage = IntroductionPage();
  static final bodyPlacementSetting = BodyPlacementSetting();
  static final gpsSetting = GpsSetting();
  static final bluetoothSetting = BluetoothSetting();
  static final extraPermissionSetting = ExtraPermissionSetting();
  static final connectedDeviceSetting = ConnectedDeviceSetting();

  static final _settingsItems = [
    introductionPage,
    bodyPlacementSetting,
    gpsSetting,
    bluetoothSetting,
    extraPermissionSetting,
    connectedDeviceSetting
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();

  final _currentPageNotifier = ValueNotifier<int>(0);

  bool _askedPerms = false;

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    homePageStore.introductionPageIndex = HomePage._settingsItems.indexOf(HomePage.introductionPage);
    homePageStore.bodyPlacementPageIndex = HomePage._settingsItems.indexOf(HomePage.bodyPlacementSetting);
    homePageStore.gpsPageIndex = HomePage._settingsItems.indexOf(HomePage.gpsSetting);
    homePageStore.bluetoothPageIndex = HomePage._settingsItems.indexOf(HomePage.bluetoothSetting);
    homePageStore.extraPermissionPageIndex = HomePage._settingsItems.indexOf(HomePage.extraPermissionSetting);
    homePageStore.connectedDevicePageIndex = HomePage._settingsItems.indexOf(HomePage.connectedDeviceSetting);

    HomePage.bluetoothSetting.configureListeners(context);
    HomePage.gpsSetting.configureListeners(context);
    HomePage.extraPermissionSetting.configureListeners(context);
    if (homePageStore.pageController == null) homePageStore.pageController = _pageController;

    if (!_askedPerms)
      Future.delayed(Duration(seconds: AppGlobalSettings.countdownDuration), () {
        homePageStore.allPermissionsNeeded.request().then((v) {
          _askedPerms = true;
        });
      });

    // REMOVE ------------------------------------------------------------- #TODO
    bool debug = false;
    if (debug && homePageStore.currentPageIndex == 0)
      Future.delayed(Duration(seconds: 1), () {
        homePageStore.setIntroductionPageDone(true);
        homePageStore.setBodyPlacementPageDone(true);
        homePageStore.setGpsPageDone(true);
        homePageStore.setBluetoothPageDone(true);
        homePageStore.setExtraPermissionPageDone(true);
        Future.delayed(Duration(seconds: 2), () {
          homePageStore.pageController.animateToPage(
            homePageStore.extraPermissionPageIndex,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        });
        Future.delayed(Duration(seconds: 6), () {
          homePageStore.pageController.animateToPage(
            homePageStore.connectedDevicePageIndex,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        });
      });
    // --------------------------------------------------------------------

    _buildPageView() {
      return Expanded(
        child: Container(
          child: Observer(
            builder: (_) => PageView.builder(
              itemCount: homePageStore.pageViewItemCountManaged,
              controller: homePageStore.pageController,
              itemBuilder: (BuildContext context, int index) {
                return HomePage._settingsItems[index];
              },
              onPageChanged: (int index) {
                homePageStore.setCurrentPageIndex(index);
                //print("page changed "+homePageStore.currentPageIndex.toString());
                _currentPageNotifier.value = index;
              },
            ),
          ),
        ),
      );
    }

    _buildLinearProgressIndicator() {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Observer(
          builder: (_) => LinearProgressPageIndicator(
            itemCount: HomePage._settingsItems.length,
            currentPageNotifier: _currentPageNotifier,
            progressColor: homePageStore.progressBarColor,
            backgroundColor: Color.fromRGBO(158, 166, 186, 0.1),
            width: constraints.maxWidth,
            height: 10,
          ),
        ),
      );
    }

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: AutoSizeText(
        "Monitor de Parametros Cinemáticos",
        maxLines: 1,
      ),
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
            Observer(
              builder: (_) => IconButton(
                icon: HomePage.introductionPage.getBottomIcon(context),
                onPressed: () {},
              ),
            ),
            Observer(
              builder: (_) => IconButton(
                icon: HomePage.bodyPlacementSetting.getBottomIcon(context),
                onPressed: () {},
              ),
            ),
            Observer(
              builder: (_) => IconButton(
                icon: HomePage.gpsSetting.getBottomIcon(context),
                onPressed: () {},
              ),
            ),
            Observer(
              builder: (_) => IconButton(
                icon: HomePage.bluetoothSetting.getBottomIcon(context),
                onPressed: () {},
              ),
            ),
            Observer(
              builder: (_) => IconButton(
                icon: HomePage.extraPermissionSetting.getBottomIcon(context),
                onPressed: () {},
              ),
            ),
            Observer(
              builder: (_) => IconButton(
                icon: HomePage.connectedDeviceSetting.getBottomIcon(context),
                onPressed: () {},
              ),
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
