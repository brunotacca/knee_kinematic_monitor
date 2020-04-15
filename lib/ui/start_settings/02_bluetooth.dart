import 'package:flutter/material.dart';

class BluetoothSetting extends StatefulWidget {
  @override
  _BluetoothSettingState createState() => _BluetoothSettingState();
}

class _BluetoothSettingState extends State<BluetoothSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Bluetooth Configuration",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
