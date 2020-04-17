import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'homepage.store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {
  int introductionPageIndex = -1;
  int bodyPlacementPageIndex = -1;
  int gpsPageIndex = -1;
  int bluetoothPageIndex = -1;
  int connectedDevicePageIndex = -1;
  PageController pageController;

  @observable
  bool introductionPageDone = false;
  @observable
  bool bodyPlacementPageDone = false;
  @observable
  bool gpsPageDone = false;
  @observable
  bool bluetoothPageDone = false;
  @observable
  bool connectedDevicePageDone = false;

  @observable
  BluetoothState bluetoothState = BluetoothState.unknown;

  @observable
  bool locationServiceEnabled;

  @observable
  GeolocationStatus geolocationStatus = GeolocationStatus.unknown;

  @observable
  int currentPageIndex = 0;

  @observable
  int stepsCompleted = 0;

  @action
  void setBluetoothState(BluetoothState state) {
    bluetoothState = state;
  }

  @action
  void setGeolocationStatus(GeolocationStatus status) {
    geolocationStatus = status;
  }

  @action
  void setLocationServiceEnabled(bool status) {
    locationServiceEnabled = status;
  }

  @action
  void setCurrentPageIndex(int index) {
    currentPageIndex = index;
  }

  @action
  setIntroductionPageDone(bool done) {
    introductionPageDone = done;
  }

  @action
  setBodyPlacementPageDone(bool done) {
    bodyPlacementPageDone = done;
  }

  @action
  setGpsPageDone(bool done) {
    gpsPageDone = done;
  }

  @action
  setBluetoothPageDone(bool done) {
    bluetoothPageDone = done;
  }

  @action
  setConnectedDevicePageDone(bool done) {
    connectedDevicePageDone = done;
  }

  @computed
  Color get progressBarColor {
    Color ok = Colors.lightGreenAccent;
    Color waiting = Colors.grey;
    Color err = Colors.redAccent;

    if(currentPageIndex>0) waiting = Colors.orangeAccent;

    if (currentPageIndex == introductionPageIndex) return introductionPageDone ? ok : waiting;
    if (currentPageIndex == bodyPlacementPageIndex) return bodyPlacementPageDone ? ok : waiting;
    if (currentPageIndex == gpsPageIndex) {
      return gpsPageDone ? ok : err;
    }
    if (currentPageIndex == bluetoothPageIndex) {
      if (bluetoothState == BluetoothState.off ||
          bluetoothState == BluetoothState.unavailable ||
          bluetoothState == BluetoothState.unauthorized) {
        return err;
      }
      return bluetoothPageDone ? ok : waiting;
    }
    if (currentPageIndex == connectedDevicePageIndex) {
      return connectedDevicePageDone ? ok : err;
    }

    return Colors.grey;
  }

  @computed
  bool get canGoNextPage {
    if(currentPageIndex==0 && introductionPageDone) return true;
    if(currentPageIndex==1 && bodyPlacementPageDone) return true;
    if(currentPageIndex==2 && gpsPageDone) return true;
    if(currentPageIndex==3 && bluetoothPageDone) return true;
    if(currentPageIndex==4 && connectedDevicePageDone) return true;
    return false;
  }

  @computed 
  int get pageViewItemCountManaged {
    if(canGoNextPage && currentPageIndex!=connectedDevicePageIndex) {
      return currentPageIndex+2;
    } else {
      return currentPageIndex+1;
    }
  }


}
