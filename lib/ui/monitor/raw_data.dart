import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:knee_kinematic_monitor/stores/global_settings.dart';
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

  interpretReceivedData(BuildContext context, List<int> data) async {
    final monitorPageStore = Provider.of<MonitorPageStore>(context);

    String strData = utf8.decode(data);

    monitorPageStore.rawDataReceivedList.add(strData);
    if (strData.contains(AppGlobalSettings.UART_MSG_DELIMITER)) {
      monitorPageStore.lastFullMessageReceived = monitorPageStore.rawDataReceivedList.join();
      monitorPageStore.rawDataReceivedList.clear();
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
    final TextStyle textStyle = Theme.of(context).primaryTextTheme.bodyText2;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              defaultColumnWidth: FlexColumnWidth(1.0),
              columnWidths: {0: FlexColumnWidth(3.0)},
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Sensor", style: textStyle)),
                    ),
                    Center(child: Text(" X ", style: textStyle)),
                    Center(child: Text(" Y ", style: textStyle)),
                    Center(child: Text(" Z ", style: textStyle)),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Acelerômetro", style: textStyle)),
                    ),
                    Center(child: Text(" ? ", style: textStyle)),
                    Center(child: Text(" ? ", style: textStyle)),
                    Center(child: Text(" ? ", style: textStyle)),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Giroscópio", style: textStyle)),
                    ),
                    Center(child: Text(" ? ", style: textStyle)),
                    Center(child: Text(" ? ", style: textStyle)),
                    Center(child: Text(" ? ", style: textStyle)),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Magnetômetro", style: textStyle)),
                    ),
                    Center(child: Text(" ? ", style: textStyle)),
                    Center(child: Text(" ? ", style: textStyle)),
                    Center(child: Text(" ? ", style: textStyle)),
                  ],
                ),
              ],
            ),
            Divider(
              height: 100,
            ),
            Observer(
              builder: (_) => AutoSizeText(
                monitorPageStore.lastFullMessageReceived == null ? "-" : monitorPageStore.lastFullMessageReceived,
                style: textStyle,
              ),
            ),
            Container(
              child: StreamBuilder<List<int>>(
                stream: monitorPageStore.receiverValueStream, //here we're using our char's value
                initialData: [],
                builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    //In this method we'll interpret received data
                    print("snapshot: $snapshot");
                    print("snapshot: " + snapshot.data.toString());
                    print("--------------------------------------------------------");
                    String stringData = 'Esperando por dados...';
                    if (snapshot.hasData) {
                      stringData = "Recebido: " + utf8.decode(snapshot.data);
                    }
                    print("--------------------------------------------------------");
                    interpretReceivedData(context, snapshot.data);
                    return AutoSizeText(
                      stringData,
                      style: textStyle,
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RawDataWidget extends StatelessWidget {
  const RawDataWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("oi");
  }
}
