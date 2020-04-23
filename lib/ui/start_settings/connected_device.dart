import 'package:flutter/material.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:provider/provider.dart';

class ConnectedDeviceSetting extends StatefulWidget {

  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.device_hub;

    return Icon(icon, color: color);
  }

  @override
  _ConnectedDeviceSettingState createState() => _ConnectedDeviceSettingState();
}

class _ConnectedDeviceSettingState extends State<ConnectedDeviceSetting> {
  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Connect the device",
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Column(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                child: Text("Cool thanks!"),
                onPressed: () {
                  homePageStore.setConnectedDevicePageDone(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
