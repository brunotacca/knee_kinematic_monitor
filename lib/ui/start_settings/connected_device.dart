import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:knee_kinematic_monitor/ui/monitor/monitor_page.dart';
import 'package:provider/provider.dart';

class ConnectedDeviceSetting extends StatefulWidget {
  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.device_hub;

    if (homePageStore.connectedDevicePageDone)
      color = Colors.lightGreenAccent;
    else
      color = Colors.redAccent;

    return Icon(icon, color: color);
  }

  @override
  _ConnectedDeviceSettingState createState() => _ConnectedDeviceSettingState();
}

class _ConnectedDeviceSettingState extends State<ConnectedDeviceSetting> {
  @override
  void initState() {
    super.initState();
  }

  bool firstScan = false;

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    print('build ${homePageStore.flutterBlueIsScanning}');

    FlutterBlue.instance.isScanning.listen((b) {
      print('Is scanning: $b');
      homePageStore.flutterBlueIsScanning = b;
    });

    Future.delayed(Duration(milliseconds: 400), () {
      if (!homePageStore.flutterBlueIsScanning) {
        print('calling scan ');
        FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
      }
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Observer(
            builder: (_) => (!homePageStore.canGoNextPage)
                ? Container()
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                          itemCount:
                              homePageStore.connectedDevices.length > 3 ? 3 : homePageStore.connectedDevices.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                homePageStore.connectedDevices[index].name,
                                style: Theme.of(context).primaryTextTheme.subtitle,
                              ),
                              trailing: RaisedButton(
                                color: Colors.lightGreenAccent,
                                child: Text("Monitorar"),
                                onPressed: () {
                                  print('pressed');
                                  homePageStore.selectedBluetoothDevice = homePageStore.connectedDevices[index];
                                  homePageStore.selectedBluetoothDeviceState = BluetoothDeviceState.connected;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MonitorPage()));
                                  /*onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    r.device.connect();
                                    return DeviceScreen(device: r.device);
                                  })),*/
                                },
                              ),
                            );
                          },
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
          ),
          RefreshIndicator(
            onRefresh: () => FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
            child: SingleChildScrollView(
              child: StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () {
                            //print("tap $r");
                            r.device.state.first.then((v) {
                              //print("v: $v");
                              if (v == BluetoothDeviceState.disconnected) {
                                //print('connecting...');
                                r.device.connect();
                              } else {
                                //print('disconnecting...');
                                r.device.disconnect();
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key key, this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback onTap;

  Widget _buildTrailing(BuildContext context, BluetoothDeviceState state) {
    if (result.device.name.length > 0) {
      Color color = Colors.white;
      Icon icon = Icon(Icons.link_off);
      //BluetoothDeviceState bsState = await result.device.state.first;
      if (state == BluetoothDeviceState.connected) {
        color = Colors.lightGreenAccent;
        icon = Icon(Icons.link);
      } else {
        color = Colors.red;
        icon = Icon(Icons.link_off);
      }

      return IconButton(
        icon: icon,
        color: color,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      );
    } else {
      return IconButton(
        icon: Icon(Icons.not_interested),
        color: Colors.grey,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      );
    }
  }

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).primaryTextTheme.title,
          ),
          Text(
            "(" + result.rssi.toString() + ") " + result.device.id.toString(),
            style: Theme.of(context).primaryTextTheme.subtitle,
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).primaryTextTheme.title,
          ),
          Text(
            "(" + result.rssi.toString() + ") " + result.device.id.toString(),
            style: Theme.of(context).primaryTextTheme.subtitle,
          )
        ],
      );
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).primaryTextTheme.caption),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).primaryTextTheme.caption.apply(color: Colors.white),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'.toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: Color.fromRGBO(74, 85, 106, .8),
      child: ExpansionTile(
        backgroundColor: Color.fromRGBO(74, 85, 106, .8),
        title: _buildTitle(context),
        trailing: StreamBuilder<BluetoothDeviceState>(
          stream: result.device.state,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final homePageStore = Provider.of<HomePageStore>(context);

              FlutterBlue.instance.connectedDevices.then((d) {
                homePageStore.connectedDevices = d;
                if (d.length > 0)
                  homePageStore.setConnectedDevicePageDone(true);
                else
                  homePageStore.setConnectedDevicePageDone(false);
              });

              return _buildTrailing(context, snapshot.data);
            } else
              return IconButton(
                icon: Icon(Icons.not_listed_location),
                onPressed: () {},
              );
          },
        ),
        children: <Widget>[
          _buildAdvRow(context, 'Complete Local Name', result.advertisementData.localName),
          _buildAdvRow(context, 'Tx Power Level', '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
          _buildAdvRow(context, 'Manufacturer Data',
              getNiceManufacturerData(result.advertisementData.manufacturerData) ?? 'N/A'),
          _buildAdvRow(
              context,
              'Service UUIDs',
              (result.advertisementData.serviceUuids.isNotEmpty)
                  ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                  : 'N/A'),
          _buildAdvRow(context, 'Service Data', getNiceServiceData(result.advertisementData.serviceData) ?? 'N/A'),
        ],
      ),
    );
  }
}
