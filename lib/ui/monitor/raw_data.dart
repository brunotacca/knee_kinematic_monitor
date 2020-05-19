import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:knee_kinematic_monitor/stores/monitorpage.store.dart';
import 'package:provider/provider.dart';

class RawData extends StatefulWidget {
  const RawData({Key key}) : super(key: key);

  @override
  _RawDataState createState() => _RawDataState();
}

class _RawDataState extends State<RawData> {
  @override
  void dispose() {
    theTransmmiterStream = null;
    super.dispose();
  }

  interpretReceivedData(BuildContext context, String data) async {
    if (data == "abt_HANDS_SHAKE") {
      //Do something here or send next command to device
      sendTransparentData(context, 'Hello');
    } else {
      print("Determine what to do with $data");
    }
  }

  sendTransparentData(BuildContext context, String dataString) async {
    final monitorPageStore = Provider.of<MonitorPageStore>(context);
    //Encoding the string
    List<int> data = utf8.encode(dataString);
    if (monitorPageStore.selectedBluetoothDeviceState == BluetoothDeviceState.connected) {
      await monitorPageStore.bcReceiver.write(data);
    }
  }

  Stream<List<int>> theTransmmiterStream;

  @override
  Widget build(BuildContext context) {
    final monitorPageStore = Provider.of<MonitorPageStore>(context);
    theTransmmiterStream = monitorPageStore.transmitterDataStream;

    theTransmmiterStream.listen((event) {
      print("event: $event");
    });

    Future.delayed(Duration(seconds: 2), (){
      monitorPageStore.bcReceiver.write(utf8.encode("dataString"));
    });

    return Container(
      child: Text(
          "oi"), /*StreamBuilder<List<int>>(
        stream: theStream, //here we're using our char's value
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print("monitorPageStore.transmitterDataStream: "+monitorPageStore.transmitterDataStream.toString());
            //In this method we'll interpret received data
            print("snapshot: $snapshot");
            print("--------------------------------------------------------");
            print("--------------------------------------------------------");
            print("snapshot: "+snapshot.data.toString());
            interpretReceivedData(context, "?");
            return Center(child: Text('We are finding the data..'));
          } else {
            return SizedBox();
          }
        },
      ),*/
    );
  }
}
