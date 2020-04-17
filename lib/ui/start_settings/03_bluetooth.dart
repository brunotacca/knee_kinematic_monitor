import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:provider/provider.dart';

class BluetoothSetting extends StatelessWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();

  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    Color color = Colors.white;
    IconData icon = Icons.bluetooth_searching;
    if (homePageStore.bluetoothState == BluetoothState.off) {
      icon = Icons.bluetooth_disabled;
      color = Colors.red;
    } else if (homePageStore.bluetoothState == BluetoothState.on) {
      icon = Icons.bluetooth_connected;
      color = Colors.lightGreenAccent;
    } else if (homePageStore.bluetoothState == BluetoothState.unavailable) {
      icon = Icons.bluetooth_disabled;
      color = Colors.red;
    } else if (homePageStore.bluetoothState == BluetoothState.unauthorized) {
      icon = Icons.lock;
      color = Colors.red;
    }

    return Icon(icon, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return BluetoothStatusScreen();
  }

  void configureListeners(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    flutterBlue.isAvailable.then((b) {
      if (b) {
        flutterBlue.state.listen((state) {
          if (homePageStore.currentPageIndex > homePageStore.bluetoothPageIndex) {
            if (homePageStore.bluetoothState == BluetoothState.on && state != BluetoothState.on) {
              homePageStore.pageController.animateToPage(
                homePageStore.bluetoothPageIndex,
                duration: Duration(seconds: 1),
                curve: Curves.ease,
              );
            }
          }

          if (state != homePageStore.bluetoothState) homePageStore.setBluetoothState(state);
          if (state == BluetoothState.on) {
            homePageStore.setBluetoothPageDone(true);
          } else {
            homePageStore.setBluetoothPageDone(false);
          }
        }).onError((e) {
          print('err $e');
          homePageStore.setBluetoothPageDone(false);
          if (e.toString().contains("unavailable")) {
            homePageStore.setBluetoothState(BluetoothState.unavailable);
          }
          if (e.toString().contains("unauthorized")) {
            homePageStore.setBluetoothState(BluetoothState.unauthorized);
          }
          //print("Err.State: " + homePageStore.bluetoothState.toString());
        });
      } else {
        homePageStore.setBluetoothState(BluetoothState.unavailable);
      }
    });
  }
}

class BluetoothStatusScreen extends StatelessWidget {
  Icon getIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    Color color = Colors.white;
    IconData icon = Icons.bluetooth_searching;
    //print("I: " + homePageStore.currentPageIndex.toString());
    //print("PageIndex: "+homePageStore.bluetoothPageIndex.toString());
    if (homePageStore.bluetoothState == BluetoothState.off) {
      icon = Icons.bluetooth_disabled;
      color = Colors.red;
    } else if (homePageStore.bluetoothState == BluetoothState.on) {
      icon = Icons.bluetooth_connected;
      color = Colors.lightBlueAccent;
    } else if (homePageStore.bluetoothState == BluetoothState.unavailable) {
      icon = Icons.bluetooth_disabled;
      color = Colors.red;
    } else if (homePageStore.bluetoothState == BluetoothState.unauthorized) {
      icon = Icons.lock;
      color = Colors.red;
    }

    return Icon(icon, color: color, size: 200.0);
  }

  Text getText(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    String text = "";

    //print("I: " + homePageStore.currentPageIndex.toString());
    //print("PageIndex: "+homePageStore.bluetoothPageIndex.toString());
    if (homePageStore.currentPageIndex == homePageStore.bluetoothPageIndex) {
      if (homePageStore.bluetoothState != null) {
        if (homePageStore.bluetoothState == BluetoothState.off) {
          text = "off.\nPlease turn it on.";
        } else if (homePageStore.bluetoothState == BluetoothState.on) {
          text = "on.";
        } else if (homePageStore.bluetoothState == BluetoothState.unavailable) {
          text = "unavaible.\nNot found on your device.";
        } else if (homePageStore.bluetoothState == BluetoothState.unauthorized) {
          text = "unauthorized.\nPlease give the app permissions.";
        } else {
          text = homePageStore.bluetoothState.toString().substring(15);
        }
      }
    }

    return Text(
      "Bluetooth Adapter is " + text,
      style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Observer(builder: (_) => getIcon(context)),
            Observer(builder: (_) => getText(context)),
          ],
        ),
      ),
    );
  }
}
