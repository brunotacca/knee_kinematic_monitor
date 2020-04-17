import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/streams/geolocator_stream.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class GpsSetting extends StatefulWidget {
  final geolocator = Geolocator()..forceAndroidLocationManager = true;
  final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.location_off;

    print(homePageStore.geolocationStatus);

    if ([GeolocationStatus.denied, GeolocationStatus.disabled].contains(homePageStore.geolocationStatus)) {
      icon = Icons.lock_outline;
      color = Colors.red;
    }
    if ([GeolocationStatus.granted].contains(homePageStore.geolocationStatus)) {
      if (!homePageStore.locationServiceEnabled) {
        icon = Icons.location_off;
        color = Colors.red;
      } else {
        icon = Icons.location_on;
        color = Colors.lightGreenAccent;
      }
    }

    return Icon(icon, color: color);
  }

  void configureListeners(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    final geoStream = GeolocatorStatusStream(homePageStore, geolocator).stream;
    geoStream.listen((active) {
      if (homePageStore.currentPageIndex > homePageStore.gpsPageIndex) {
        if (!active) {
          homePageStore.pageController.animateToPage(
            homePageStore.gpsPageIndex,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        }
      }

      homePageStore.setGpsPageDone(homePageStore.locationServiceEnabled);

    });
  }

  @override
  _GpsSettingState createState() => _GpsSettingState();
}

class _GpsSettingState extends State<GpsSetting> {
  Future<bool> handleLocationPermsStatus() async {
    final homePageStore = Provider.of<HomePageStore>(context);
    if ([GeolocationStatus.unknown, GeolocationStatus.denied].contains(homePageStore.geolocationStatus)) {
      var status = await Permission.location.request();
      if (status == PermissionStatus.granted) status = await Permission.locationAlways.request();
      if (status == PermissionStatus.granted) status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        homePageStore.setGeolocationStatus(await widget.geolocator.checkGeolocationPermissionStatus());
        homePageStore.setLocationServiceEnabled(await widget.geolocator.isLocationServiceEnabled());
      }
    }
    return homePageStore.locationServiceEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: handleLocationPermsStatus(),
      builder: (BuildContext context, snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GpsStatusScreen();
        }
      },
    );

  }
}

class GpsStatusScreen extends StatelessWidget {
  Icon getIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.location_off;

    print(homePageStore.geolocationStatus);

    if ([GeolocationStatus.unknown, GeolocationStatus.denied, GeolocationStatus.disabled]
        .contains(homePageStore.geolocationStatus)) {
      icon = Icons.lock_outline;
      color = Colors.red;
    }
    if ([GeolocationStatus.granted].contains(homePageStore.geolocationStatus)) {
      if (!homePageStore.locationServiceEnabled) {
        icon = Icons.location_off;
        color = Colors.red;
      } else {
        icon = Icons.location_on;
        color = Colors.lightBlueAccent;
      }
    }

    return Icon(icon, color: color, size: 200.0);
  }

  Text getText(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    String text = "";

    if ([GeolocationStatus.unknown, GeolocationStatus.denied, GeolocationStatus.disabled]
        .contains(homePageStore.geolocationStatus)) {
      text = "not available, disabled or denied.";
    }
    if ([GeolocationStatus.granted].contains(homePageStore.geolocationStatus)) {
      if (!homePageStore.locationServiceEnabled) {
        text = "is turned off.\nPlease turn it on.";
      } else {
        text = "on.";
      }
    }

    return Text(
      "GPS (Location Service) is " + text,
      style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              var hasOpened = openAppSettings();
              debugPrint('App Settings opened: ' + hasOpened.toString());
            },
          )
        ],
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Observer(builder: (_) => getIcon(context)),
            Observer(builder: (_) => getText(context)),
            RaisedButton(
              child: Text("Cool thanks!"),
              onPressed: () {
                homePageStore.setGpsPageDone(true);
              },
            )
          ],
        ),
      ),
    );
  }
}
