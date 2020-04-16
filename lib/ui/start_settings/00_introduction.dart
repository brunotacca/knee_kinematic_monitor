import 'package:flutter/material.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';
import 'package:provider/provider.dart';

class IntroductionPage extends StatelessWidget {
  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    Color color = Colors.white;
    IconData icon = Icons.favorite_border;

    if (homePageStore.introductionPageDone) {
      color = Colors.redAccent;
      icon = Icons.favorite;
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
              "Introduction Page - Instructions about the app",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            RaisedButton(
              child: Text("Cool thanks!"),
              onPressed: () {
                homePageStore.setIntroductionPageDone(true);
              },
            )
          ],
        ),
      ),
    );
  }
}
