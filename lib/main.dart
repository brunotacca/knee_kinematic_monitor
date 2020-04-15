import 'package:flutter/material.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/home_page.dart';
//import 'package:ppgcc_flutter_iot_ble_data_gatherer/ui/list_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      //home: new ListPage(title: 'Lessons'),
      home: new HomePage(),
    );
  }
}

