import 'package:flutter/material.dart';

class BodyPlacementSetting extends StatefulWidget {
  @override
  _BodyPlacementSettingState createState() => _BodyPlacementSettingState();
}

class _BodyPlacementSettingState extends State<BodyPlacementSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Body Configuration - How to Place the Device on the Body",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
