import 'package:flutter/material.dart';

class GpsSetting extends StatefulWidget {
  @override
  _GpsSettingState createState() => _GpsSettingState();
}

class _GpsSettingState extends State<GpsSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "GPS Configuration",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
