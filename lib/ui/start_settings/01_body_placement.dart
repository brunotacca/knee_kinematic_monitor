import 'package:flutter/material.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:provider/provider.dart';

class BodyPlacementSetting extends StatelessWidget {
  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    Color color = Colors.white;
    IconData icon = Icons.directions_walk;

    if (homePageStore.bodyPlacementPageDone) {
      color = Colors.lightGreenAccent;
      icon = Icons.directions_run;
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
              "Body Configuration - How to Place the Device on the Body",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            RaisedButton(
              child: Text("Cool thanks!"),
              onPressed: () {
                homePageStore.setBodyPlacementPageDone(true);
              },
            )
          ],
        ),
      ),
    );
  }
}
