import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobx/mobx.dart';

part 'homepage.store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {

  int introductionPageIndex = -1;
  int bodyPlacementPageIndex = -1;
  int gpsPageIndex = -1;
  int bluetoothPageIndex = -1;
  int connectedDevicePageIndex = -1;

  @observable
  BluetoothState bluetoothState = BluetoothState.unknown;

  @observable
  int currentPageIndex = 0;

  @action
  void setBluetoothState(BluetoothState state) {
    bluetoothState = state;
  }

  @action 
  void setCurrentPageIndex(int index) {
    currentPageIndex = index;
  }

}
