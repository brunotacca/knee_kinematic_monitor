import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import '../streams/storage_permission_stream.dart';

class ExtraPermissionSetting extends StatefulWidget {
  final geolocator = Geolocator()..forceAndroidLocationManager = true;

  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.phonelink_setup;

    if (homePageStore.storagePermission != null && homePageStore.storagePermission) {
      color = Colors.lightGreenAccent;
    } else {
      color = Colors.red;
      icon = Icons.phonelink_lock;
    }

    return Icon(icon, color: color);
  }

  void configureListeners(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    final storageStream = StoragePermissionStream(homePageStore: homePageStore).stream;
    storageStream.listen((active) {
      if (homePageStore.currentPageIndex > homePageStore.extraPermissionPageIndex) {
        if (!active) {
          homePageStore.pageController.animateToPage(
            homePageStore.extraPermissionPageIndex,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        }
      }

      homePageStore.setExtraPermissionPageDone(homePageStore.storagePermission);
    });
  }

  @override
  _ExtraPermissionSettingState createState() => _ExtraPermissionSettingState();
}

class _ExtraPermissionSettingState extends State<ExtraPermissionSetting> {
  Future<bool> handlePermsStatus() async {
    final homePageStore = Provider.of<HomePageStore>(context);
    var statusStorage = await Permission.storage.request();
    if (statusStorage == PermissionStatus.granted) {
      homePageStore.setStoragePermission(true);
    } else {
      homePageStore.setStoragePermission(false);
    }

    if (homePageStore.storagePermission != null && homePageStore.storagePermission) {
      homePageStore.setExtraPermissionPageDone(true);
    }

    return (homePageStore.storagePermission);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: handlePermsStatus(),
      builder: (BuildContext context, snapshot) {
        //print(snapshot);
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ExtraPermissionScreen();
        }
      },
    );
  }
}

class ExtraPermissionScreen extends StatelessWidget {
  Icon getIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    Color color = Colors.white;
    IconData icon = Icons.phonelink_setup;

    if (homePageStore.storagePermission != null && homePageStore.storagePermission) {
      color = Colors.lightGreenAccent;
    } else {
      color = Colors.red;
      icon = Icons.phonelink_lock;
    }

    return Icon(icon, color: color, size: 200.0);
  }

  Text getText(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);
    String text = "";

    if (homePageStore.storagePermission != null && homePageStore.storagePermission) {
      text = "corretas.";
    } else {
      text = "indisponíveis ou não autorizadas.";
    }

    return Text(
      "As permissões extras estão " + text,
      style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    return Stack(
      children: <Widget>[
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () async {
                  openAppSettings();
                },
              )
            ],
          ),
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
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Container(
              constraints: BoxConstraints.tight(Size(50.0, 40.0)),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: Observer(
                      builder: (_) => Icon(
                        Icons.arrow_forward_ios,
                        color: (homePageStore.extraPermissionPageDone ? Colors.lightGreenAccent : Colors.white),
                      ),
                    ),
                    onPressed: () {
                      homePageStore.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
