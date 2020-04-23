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

  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.location_off;

    //print(homePageStore.geolocationStatus);

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
    final homePageStore = Provider.of<HomePageStore>(context);
    if (homePageStore.geolocator == null) homePageStore.geolocator = widget.geolocator;

    return FutureBuilder<bool>(
      future: handleLocationPermsStatus(),
      builder: (BuildContext context, snapshot) {
        //print(snapshot);
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

    //print(homePageStore.geolocationStatus);

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
      text = "indisponível, desabilitado ou bloqueado.";
    }
    if ([GeolocationStatus.granted].contains(homePageStore.geolocationStatus)) {
      if (!homePageStore.locationServiceEnabled) {
        text = "desligado.\nPor favor ligue.";
      } else {
        text = "ligado.";
      }
    }

    return Text(
      "GPS (Serviço de Localização) está " + text,
      style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  Widget getGeoInfo(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    if ([GeolocationStatus.granted].contains(homePageStore.geolocationStatus) && homePageStore.locationServiceEnabled) {
      if (homePageStore.position != null) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Lat: ${homePageStore.position.latitude} Long: ${homePageStore.position.latitude}",
                style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  homePageStore.getPlacemarkFormatted(),
                  style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      } else {
        return Text(
          "Localização desconhecida",
          style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        );
      }
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

    final StreamSubscription<Position> positionStream =
        homePageStore.geolocator.getPositionStream(locationOptions).listen((Position position) async {
      //print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
      homePageStore.setPostion(position);
      homePageStore.lastPlacemark =
          await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: "pt_BR");
    });
    positionStream.onDone(() => positionStream.cancel());

    return Stack(
      children: <Widget>[
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () async {
                  openAppSettings();
                  //var hasOpened = openAppSettings();
                  //debugPrint('App Settings opened: ' + hasOpened.toString());
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
                Observer(builder: (_) => getGeoInfo(context)),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Container(
              constraints: BoxConstraints.tight(Size(50.0, 40.0)),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: Observer(
                      builder: (_) => Icon(
                        Icons.arrow_forward_ios,
                        color: (homePageStore.gpsPageDone ? Colors.lightGreenAccent : Colors.white),
                      ),
                    ),
                    onPressed: () {
                      homePageStore.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
