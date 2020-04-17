import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class GpsSetting extends StatelessWidget {
  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    Color color = Colors.white;
    IconData icon = Icons.location_off;

    if (homePageStore.gpsPageDone) {
      color = Colors.lightGreenAccent;
      icon = Icons.location_on;
    }

    return Icon(icon, color: color);
  }

  Future<void> _fetchLocationData(BuildContext context) async {
    final geolocator = Geolocator()..forceAndroidLocationManager = true;
    final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
    final homePageStore = Provider.of<HomePageStore>(context);

    homePageStore.setGeolocationStatus(await geolocator.checkGeolocationPermissionStatus());
    homePageStore.setLocationServiceEnabled(await geolocator.isLocationServiceEnabled());

    final StreamSubscription<Position> positionStream =
        geolocator.getPositionStream(locationOptions).listen((Position position) {
      print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    });

    Future.delayed(Duration(seconds: 20), () {
      print('cancelling subscription');
      positionStream.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    return FutureBuilder<GeolocationStatus>(
      future: Geolocator().checkGeolocationPermissionStatus(),
      builder: (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        _fetchLocationData(context);

        if (snapshot.data == GeolocationStatus.denied) {
          return Text("Location services disabled\nEnable location services for this App using the device settings.");
        }

        return GpsStatusScreen();
      },
    );

    /*
    return Scaffold(
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
    */
  }
}

class GpsStatusScreen extends StatelessWidget {
  Icon getIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.location_off;

    return Icon(icon, color: color, size: 200.0);
  }

  Text getText(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    String text = "";

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
