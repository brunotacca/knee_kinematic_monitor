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
  int extraPermissionPageIndex = -1;
  int connectedDevicePageIndex = -1;
  PageController pageController;
  Geolocator geolocator;
  List<Placemark> lastPlacemark;

  String getPlacemarkFormatted() {
    if (lastPlacemark != null && lastPlacemark.isNotEmpty)
      return "" +
          lastPlacemark[0].thoroughfare +
          " " +
          lastPlacemark[0].subThoroughfare +
          "\n" +
          lastPlacemark[0].subAdministrativeArea +
          " - " +
          lastPlacemark[0].administrativeArea +
          ", " +
          lastPlacemark[0].country +
          ". ";
    else
      return "";
  }

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
  bool extraPermissionPageDone = false;

  @observable
  BluetoothState bluetoothState = BluetoothState.unknown;

  @observable
  bool locationServiceEnabled;

  @observable
  GeolocationStatus geolocationStatus = GeolocationStatus.unknown;

  @observable
  bool storagePermission;

  @observable
  int currentPageIndex = 0;

  @observable
  Position position;

  @action
  void setStoragePermission(bool b) {
    storagePermission = b;
  }

  @action
  void setPostion(Position pos) {
    position = pos;
  }

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
  setExtraPermissionPageDone(bool done) {
    extraPermissionPageDone = done;
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

    if (currentPageIndex > 0) waiting = Colors.orangeAccent;

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
    if (currentPageIndex == extraPermissionPageIndex) {
      return storagePermission ? ok : err;
    }

    return Colors.grey;
  }

  @computed
  bool get canGoNextPage {
    if (currentPageIndex == introductionPageIndex && introductionPageDone) return true;
    if (currentPageIndex == bodyPlacementPageIndex && bodyPlacementPageDone) return true;
    if (currentPageIndex == gpsPageIndex && gpsPageDone) return true;
    if (currentPageIndex == bluetoothPageIndex && bluetoothPageDone) return true;
    if (currentPageIndex == extraPermissionPageIndex && storagePermission) return true;
    if (currentPageIndex == connectedDevicePageIndex && connectedDevicePageDone) return true;
    return false;
  }

  @computed
  int get pageViewItemCountManaged {
    if (canGoNextPage && currentPageIndex != connectedDevicePageIndex) {
      return currentPageIndex + 2;
    } else {
      return currentPageIndex + 1;
    }
  }
}
