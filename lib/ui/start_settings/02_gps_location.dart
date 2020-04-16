import 'package:flutter/material.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:provider/provider.dart';

class GpsSetting extends StatelessWidget {
  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    Color color = Colors.white;
    IconData icon = Icons.location_off;

    if (homePageStore.gpsPageDone) {
      color = Colors.lightGreenAccent;
      icon = Icons.location_on;
    }

    return Icon(icon, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "GPS Configuration - Check GPS Service",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            RaisedButton(
              child: Text("Cool thanks!"),
              onPressed: () {
                homePageStore.setGpsPageDone(true);
              },
            )
          ],
        ),
      ),
    );
  }
}
