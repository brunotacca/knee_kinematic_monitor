import 'package:flutter/material.dart';

class ConnectedDeviceSetting extends StatefulWidget {
  @override
  _ConnectedDeviceSettingState createState() => _ConnectedDeviceSettingState();
}

class _ConnectedDeviceSettingState extends State<ConnectedDeviceSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Device Configuration",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
