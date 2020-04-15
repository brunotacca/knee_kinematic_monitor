import 'package:flutter/material.dart';

class IconSettings {
  // In the interface, but visible only in this library.
  final _icon;

  // Not in the interface, since this is a constructor.
  IconSettings(this._icon);

  // In the interface.
  Icon getIcon() => Icon(_icon, color: Colors.white);
  
}
