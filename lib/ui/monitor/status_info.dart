import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator/geolocator.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:provider/provider.dart';

class StatusInfo extends StatelessWidget {
  const StatusInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    features[0].status =
        (homePageStore.geolocationStatus == GeolocationStatus.granted && homePageStore.locationServiceEnabled);
    features[1].status = homePageStore.bluetoothState == BluetoothState.on;
    features[2].status = homePageStore.storagePermission;
    features[3].status = homePageStore.selectedBluetoothDeviceState == BluetoothDeviceState.connected;

    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map(
                  (f) => FeatureCard(
                    feature: f,
                  ),
                )
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              homePageStore.selectedBluetoothDevice.name,
              style: Theme.of(context).primaryTextTheme.body1,
            ),
          ),
        ],
      ),
    );
  }
}

class Feature {
  Feature({this.title, this.icon, this.about, this.status});

  final String title;
  final IconData icon;
  final String about;
  bool status;
}

List<Feature> features = <Feature>[
  Feature(
    title: 'GPS',
    icon: Icons.location_on,
    about: "Permissão do GPS, serviço de localização.",
    status: false,
  ),
  Feature(
    title: 'Bluetooth',
    icon: Icons.bluetooth,
    about: "Permissão do bluetooth, serviço de comunicação.",
    status: false,
  ),
  Feature(
    title: 'Armazenamento',
    icon: Icons.storage,
    about: "Permissão de armazenmento, persistência dos dados.",
    status: false,
  ),
  Feature(
    title: 'Dispositivo',
    icon: Icons.device_hub,
    about: "Comunicação com o dispositivo bluetooth.",
    status: false,
  ),
];

class FeatureCard extends StatelessWidget {
  const FeatureCard({Key key, this.feature}) : super(key: key);

  final Feature feature;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
      color: Color.fromRGBO(74, 85, 106, .8),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              feature.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).primaryTextTheme.title,
            ),
            Text(
              feature.about,
              style: Theme.of(context).primaryTextTheme.body1,
            )
          ],
        ),
        trailing: Icon(
          feature.icon,
          color: feature.status ? Colors.lightGreenAccent : Colors.redAccent,
        ),
      ),
    );
  }
}
