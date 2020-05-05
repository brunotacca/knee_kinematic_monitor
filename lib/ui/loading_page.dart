import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:knee_kinematic_monitor/ui/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'monitor/monitor_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var initiated;

  @override
  void initState() {
    super.initState();
    print("initState");
  }

  void fetchSharedPreferences(BuildContext context) async {
    final homePageStore = Provider.of<HomePageStore>(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var b = prefs.getBool('startSettingsDone');

    homePageStore.setStartSettingsDone(b != null ? b : false);

    if (b) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MonitorPage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build LoadingPage");
    fetchSharedPreferences(context);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(
                  child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  AutoSizeText(
                    "Monitor de Parâmetros Cinemáticos",
                    style: Theme.of(context).primaryTextTheme.title,
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                  Divider(
                    height: 50,
                  ),
                  AutoSizeText(
                    "Carregando configurações...",
                    style: Theme.of(context).primaryTextTheme.subtitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
