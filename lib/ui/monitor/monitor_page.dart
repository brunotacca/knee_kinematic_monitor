import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator/geolocator.dart';
import 'package:knee_kinematic_monitor/stores/global_settings.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:knee_kinematic_monitor/stores/monitorpage.store.dart';
import 'package:knee_kinematic_monitor/ui/monitor/raw_data.dart';
import 'package:knee_kinematic_monitor/ui/monitor/status_info.dart';
import 'package:knee_kinematic_monitor/ui/streams/geolocator_stream.dart';
import 'package:knee_kinematic_monitor/ui/streams/storage_permission_stream.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitorPage extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final geolocator = Geolocator()..forceAndroidLocationManager = true;

  @override
  _MonitorPageState createState() => _MonitorPageState();

  void connectToPredefinedDevice(BuildContext context) {
    final monitorPageStore = Provider.of<MonitorPageStore>(context, listen: false);
    final homePageStore = Provider.of<HomePageStore>(context, listen: false);

    if (monitorPageStore.selectedBluetoothDevice == null) {
      flutterBlue.startScan(timeout: Duration(seconds: 10)).then((sr) {
        print("Found Something...: ");
        for (final r in sr) {
          print("R: $r");
          if (r.device.name == AppGlobalSettings.deviceName) {
            r.device.disconnect().then((v) {
              r.device.connect().then((v) {
                monitorPageStore.setSelectedBluetoothDevice(r.device);
                monitorPageStore.setSelectedBluetoothDeviceState(BluetoothDeviceState.connected);
                homePageStore.setSelectedBluetoothDevice(r.device);
                homePageStore.setSelectedBluetoothDeviceState(BluetoothDeviceState.connected);
                lookupForUARTService(context, r.device);
              });
            });
            break;
          }
        }
      });
    }
  }

  void lookupForUARTService(BuildContext context, BluetoothDevice device) {
    final monitorPageStore = Provider.of<MonitorPageStore>(context, listen: false);
    final homePageStore = Provider.of<HomePageStore>(context, listen: false);

    if (device.name == AppGlobalSettings.deviceName) {
      monitorPageStore.selectedBluetoothDevice = device;
      monitorPageStore.selectedBluetoothDeviceState = BluetoothDeviceState.connected;
      homePageStore.selectedBluetoothDevice = device;
      homePageStore.selectedBluetoothDeviceState = BluetoothDeviceState.connected;

      device.discoverServices().then((listBS) {
        listBS.forEach((service) {
          //print("Service: " + service.uuid.toString());
          //print("--------------------");
          if (service.uuid.toString() == AppGlobalSettings.UART_SERVICE_UUID) {
            service.characteristics.forEach((characteristic) {
              //print("> Characteristic: " + characteristic.uuid.toString());
              if (characteristic.uuid.toString() == AppGlobalSettings.UART_TX_CHAR_UUID) {
                monitorPageStore.bcTransmitter = characteristic;
                //characteristic.setNotifyValue(!characteristic.isNotifying);
                /*
                print("TRANSMITTER!");
                characteristic.setNotifyValue(true).then((v) {
                  print("TRANSMITTER val: $v");
                }).catchError((e) {
                  print("TRANSMITTER err: $e");
                }).whenComplete(() {
                  print("TRANSMITTER completed future.");
                });

                Future.delayed(Duration(seconds: 5), (){
                  characteristic.write(utf8.encode("hello"), withoutResponse: true).then((value) {
                    print("RECEIVER wrote");
                  }).catchError((e) {
                    print("RECEIVER err: $e");
                  }).whenComplete(() {
                    print("RECEIVER completed future.");
                  });
                });
                */
              }
              if (characteristic.uuid.toString() == AppGlobalSettings.UART_RX_CHAR_UUID) {
                monitorPageStore.bcReceiver = characteristic;
                characteristic.setNotifyValue(true);
                monitorPageStore.receiverValueStream = characteristic.value;
                if (monitorPageStore.receiverValueStreamSubscription != null) {
                  monitorPageStore.receiverValueStreamSubscription.cancel();
                  monitorPageStore.receiverValueStreamSubscription = null;
                }
                print("HERE");
                monitorPageStore.receiverValueStreamSubscription = monitorPageStore.receiverValueStream.listen((event) {
                  //print("event: " + utf8.decode(event));
                  interpretReceivedData(context, event);
                });

                /*
                print("RECEIVER!");
                characteristic.setNotifyValue(true).then((v) {
                  print("RECEIVER v: $v");
                }).catchError((e) {
                  print("RECEIVER err: $e");
                }).whenComplete(() {
                  print("RECEIVER completed future;");
                });

                characteristic.value.listen((event) {
                  print("value: "+utf8.decode(event));
                  //event.map((e) => utf8.decode(e));
                });

                characteristic.write(utf8.encode("hello")).then((value) {
                  print("RECEIVER wrote");
                }).catchError((e) {
                  print("RECEIVER err: $e");
                }).whenComplete(() {
                  print("RECEIVER completed future.");
                });
                */
              }
              /*
              print("> > Properties: " + characteristic.properties.toString());
              print("> --------------------");
              characteristic.descriptors.forEach((d) {
                print("> > Descriptor: " + d.toString());
              });
              
              print("> --------------------");
              */
            });
          }
          //print("--------------------");
        });
      });
    }
  }

  interpretReceivedData(BuildContext context, List<int> data) {
    final monitorPageStore = Provider.of<MonitorPageStore>(context, listen: false);

    if (data.contains(0)) {
      data[data.lastIndexOf(0)] = 32; // swap null terminator (0) to space (32)
    }

    String strData = utf8.decode(data).trim();
    monitorPageStore.rawDataReceivedList.add(strData);
    if (strData.contains(AppGlobalSettings.UART_MSG_DELIMITER)) {
      monitorPageStore.setLastFullMessageReceived(monitorPageStore.rawDataReceivedList.join());
      monitorPageStore.rawDataReceivedList.clear();
    }
  }
}

class _MonitorPageState extends State<MonitorPage> {
  MonitorPageStore monitorStore;

  @override
  void dispose() {
    if (monitorStore != null && monitorStore.receiverValueStreamSubscription != null) {
      monitorStore.receiverValueStreamSubscription.cancel();
      monitorStore.receiverValueStreamSubscription = null;
    }
    super.dispose();
  }

  void configureListeners(BuildContext context) {
    final monitorPageStore = Provider.of<MonitorPageStore>(context);
    monitorStore = monitorPageStore;
    final homePageStore = Provider.of<HomePageStore>(context);

    // ------------------- Bluetooth
    widget.flutterBlue.isAvailable.then((b) {
      if (b) {
        widget.flutterBlue.state.listen((state) {
          if (state != monitorPageStore.bluetoothState) {
            monitorPageStore.setBluetoothState(state);

            // ------------------ Connected Devices
            if (state == BluetoothState.on) {
              widget.flutterBlue.connectedDevices.then((cd) {
                monitorPageStore.connectedDevices = cd;
                homePageStore.connectedDevices = cd;
                print("cd: " + cd.toString());
                if (cd.length > 0) {
                  cd.forEach((device) {
                    widget.lookupForUARTService(context, device);
                  });
                } else {
                  widget.connectToPredefinedDevice(context);
                }
              });
            } else {
              monitorPageStore.setConnectedDevices([]);
              monitorPageStore.selectedBluetoothDevice = null;
              monitorPageStore.selectedBluetoothDeviceState = null;
            }
          }
        });
      } else {
        monitorPageStore.setBluetoothState(BluetoothState.unavailable);
      }
    });

    // ------------------- Storage
    final storageStream = StoragePermissionStream(monitorPageStore: monitorPageStore).stream;
    storageStream.listen((b) {});

    // ------------------- GPS
    final geoStream = GeolocatorStatusStream(monitorPageStore: monitorPageStore, geolocator: widget.geolocator).stream;
    geoStream.listen((b) {});
  }

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>> build");
    final monitorPageStore = Provider.of<MonitorPageStore>(context);

    SharedPreferences.getInstance().then((sp) {
      var v = sp.getBool("startSettingsDone");
      if (v != null && v == false) sp.setBool("startSettingsDone", true);
      var d = sp.getString("lastDeviceConnectedId");
      if (d != null && d.isNotEmpty) {
        monitorPageStore.lastDeviceConnectedId = d;
      }
    });

    configureListeners(context);

    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: AutoSizeText(
            "Monitor de Parametros Cinemáticos",
            maxLines: 1,
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon, this.about, this.content});

  final String title;
  final IconData icon;
  final String about;
  final Widget content;
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: 'INFO',
    icon: Icons.info_outline,
    about: "Informações sobre permissões e dispositivos",
    content: StatusInfo(),
  ),
  const Choice(
    title: 'JOELHO',
    icon: Icons.directions_walk,
    about: "Parametros cinemáticos do jolho",
    content: Placeholder(
      color: Colors.green,
    ),
  ),
  const Choice(
    title: 'DADOS',
    icon: Icons.storage,
    about: "Dados puros sendo enviados pelo dispositivo",
    content: RawData(),
  ),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).primaryTextTheme.subtitle2;
    return Card(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              AutoSizeText(choice.about, style: textStyle),
              Spacer(),
              Icon(choice.icon, size: 30.0, color: Colors.white),
            ],
          ),
          choice.content,
        ],
      ),
    );
  }
}
