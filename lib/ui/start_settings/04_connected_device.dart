import 'package:flutter/material.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:provider/provider.dart';

class ConnectedDeviceSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Future.delayed(Duration(seconds: 5), () => homePageStore.setConnectedDevicePageDone(true));

    return Container(
      child: Center(
        child: Text(
          "Device Configuration - Check device connectivity",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
