import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:knee_kinematic_monitor/ui/home_page.dart';
import 'package:knee_kinematic_monitor/ui/loading_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomePageStore>(
          create: (_) => HomePageStore(),
        )
      ],
      child: new MaterialApp(
        theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
        home: new LoadingPage(),
      ),
    );
  }
}
