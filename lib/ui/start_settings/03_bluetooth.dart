import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/start_settings/icon_settings.dart';

final homePageStore = HomePageStore();

class BluetoothSetting extends StatelessWidget implements IconSettings {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();

  @override
  Icon getIcon() {
    Color color = Colors.blueAccent;
    print("I: " + homePageStore.currentPageIndex.value.toString());
    if (homePageStore.currentPageIndex.value == 3) color = Colors.pinkAccent;
    return Icon(Icons.bluetooth_disabled, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
      stream: flutterBlue.state,
      initialData: BluetoothState.unknown,
      builder: (c, snapshot) {
        final state = snapshot.data;
        return BluetoothStatusScreen(state: state);
      },
    );
  }
}

class BluetoothStatusScreen extends StatelessWidget {
  const BluetoothStatusScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: (state == BluetoothState.off) ? Colors.red : Colors.lightBlueAccent,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}' +
                  ((state == BluetoothState.off) ? "\nPlease, turn it on." : ""),
              style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
