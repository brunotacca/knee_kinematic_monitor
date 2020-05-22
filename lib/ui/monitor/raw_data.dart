import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    super.dispose();
  }

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
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.accelX.toString(), style: textStyle))),
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.accelY.toString(), style: textStyle))),
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.accelZ.toString(), style: textStyle))),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Giroscópio", style: textStyle)),
                    ),
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.gyrosX.toString(), style: textStyle))),
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.gyrosY.toString(), style: textStyle))),
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.gyrosZ.toString(), style: textStyle))),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Magnetômetro", style: textStyle)),
                    ),
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.magneX.toString(), style: textStyle))),
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.magneY.toString(), style: textStyle))),
                    Center(child: Observer(builder: (_) => Text(monitorPageStore.lastSensorMessage.magneZ.toString(), style: textStyle))),
                  ],
                ),
              ],
            ),
            Spacer(),
            Text("Last message received:", style: textStyle),
            Observer(
              builder: (_) => AutoSizeText(
                monitorPageStore.lastSensorMessage == null ? "-" : monitorPageStore.lastSensorMessage.rawMsg,
                style: textStyle,
              ),
            ),
            /*Container(
              child: StreamBuilder<List<int>>(
                stream: monitorPageStore.receiverValueStream, 
                initialData: [],
                builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                  print("snapshot: $snapshot");
                  print("snapshot: " + snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.active) {
                    //In this method we'll interpret received data
                    print("--------------------------------------------------------");
                    String stringData = 'Esperando por dados...';
                    if (snapshot.hasData) {
                      stringData = "Recebido: " + utf8.decode(snapshot.data);
                    }
                    print("Data: " + stringData);
                    print("--------------------------------------------------------");
                    //interpretReceivedData(context, snapshot.data);
                    return AutoSizeText(
                      stringData,
                      style: textStyle,
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),*/
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
