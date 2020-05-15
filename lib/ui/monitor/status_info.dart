import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:knee_kinematic_monitor/stores/monitorpage.store.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';

class StatusInfo extends StatelessWidget {
  const StatusInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>> build");

    final monitorPageStore = Provider.of<MonitorPageStore>(context);

    return Expanded(
      child: Padding(
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
              child: Observer(
                builder: (_) => Text(
                  monitorPageStore.selectedBluetoothDevice == null ? "" : monitorPageStore.selectedBluetoothDevice.name,
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      print("popping");
                      Navigator.pop(context);
                    } else {
                      print("pushing");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                  icon: Icon(Icons.settings, color: Colors.white),
                  label: Text(
                    "Configurações",
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                ),
              ],
            ),
          ],
        ),
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
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
            Text(
              feature.about,
              style: Theme.of(context).primaryTextTheme.bodyText2,
            )
          ],
        ),
        trailing: Observer(
          builder: (_) => Icon(
            feature.icon,
            color: _getColor(context),
          ),
        ),
      ),
    );
  }

  _getColor(BuildContext context) {
    final monitorPageStore = Provider.of<MonitorPageStore>(context);

    features[0].status =
        (monitorPageStore.geolocationStatus == GeolocationStatus.granted && monitorPageStore.locationServiceEnabled);
    features[1].status = monitorPageStore.bluetoothState == BluetoothState.on;
    features[2].status = monitorPageStore.storagePermission;
    features[3].status = monitorPageStore.selectedBluetoothDeviceState == BluetoothDeviceState.connected;

    return feature.status == null ? Colors.white : feature.status ? Colors.lightGreenAccent : Colors.redAccent;
  }
}
