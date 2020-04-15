import 'package:mobx/mobx.dart';
import 'package:flutter_blue/flutter_blue.dart';
part 'homepage.store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {
  @observable
  Observable<BluetoothState> bluetoothState;

  @observable
  Observable<int> currentPageIndex = Observable(0);

  @action
  void setBluetoothState(BluetoothState state) {
    bluetoothState.value = state;
  }

  @action 
  void setCurrentPageIndex(int index) {
    currentPageIndex.value = index;
  }

}