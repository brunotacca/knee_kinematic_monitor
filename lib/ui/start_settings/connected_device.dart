import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:provider/provider.dart';

import 'lesson.dart';

class ConnectedDeviceSetting extends StatefulWidget {
  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.device_hub;

    return Icon(icon, color: color);
  }

  @override
  _ConnectedDeviceSettingState createState() => _ConnectedDeviceSettingState();
}

class _ConnectedDeviceSettingState extends State<ConnectedDeviceSetting> {
  List lessons;

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  bool firstScan = false;

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    ListTile makeListTile(Lesson lesson) => ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(border: new Border(right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            lesson.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    // tag: 'hero',
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: lesson.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(lesson.level, style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            print('connect');
          },
        );

    Card makeCard(Lesson lesson) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(lesson),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );

    //return Container(child: makeBody);

    print('build ${homePageStore.flutterBlueIsScanning}');

    Future.delayed(Duration(milliseconds: 400), () {
      if (!homePageStore.flutterBlueIsScanning) {
        print('calling scan ');
        FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
      }
    });

    FlutterBlue.instance.isScanning.listen((b) {
      print('Is scanning: $b');
      homePageStore.flutterBlueIsScanning = b;
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
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
                      /*onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        r.device.connect();
                        return DeviceScreen(device: r.device);
                      })),*/
                      onTap: () {
                        //r.device.connect();
                        r.device.state.last.then((v) {
                          if (v != BluetoothDeviceState.connected) {
                            print('connecting...');
                            r.device.connect();
                          } else {
                            print('disconnecting...');
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

List getLessons() {
  return [
    Lesson(
        title: "Introduction to Driving",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 20,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Observation at Junctions",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Reverse parallel Parking",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Reversing around the corner",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Incorrect Use of Signal",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Engine Challenges",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Self Driving Car",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key key, this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback onTap;

  Future<Widget> _buildTrailing(BuildContext context) async {
    if (result.device.name.length > 0) {
      String text = "";
      Color color = Colors.white;
      Icon icon = Icon(Icons.link_off);
      BluetoothDeviceState bsState = await result.device.state.first;
      print("$bsState");
      if (bsState == BluetoothDeviceState.connected) {
        text = "CONNECTED";
        color = Colors.lightGreenAccent;
        icon = Icon(Icons.link);
      } else {
        text = "CONNECT";
        color = Colors.red;
        icon = Icon(Icons.link_off);
      }

      return IconButton(
        icon: icon,
        color: color,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      );
      /*return RaisedButton(
        child: Text(text),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      );*/
    } else {
      return Container();
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
      return Text(
        result.device.id.toString(),
        style: Theme.of(context).primaryTextTheme.subtitle,
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
        //leading: Text(result.rssi.toString()),
        trailing: FutureBuilder<Widget>(
          future: _buildTrailing(context),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData)
              return snapshot.data;
            else
              return IconButton(
                icon: Icon(Icons.link_off),
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
