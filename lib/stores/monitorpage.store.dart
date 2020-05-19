import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'monitorpage.store.g.dart';

class MonitorPageStore = _MonitorPageStore with _$MonitorPageStore;

abstract class _MonitorPageStore with Store {
  
  String lastDeviceConnectedId = "";

  @observable
  BluetoothState bluetoothState = BluetoothState.unknown;

  @observable
  BluetoothDevice selectedBluetoothDevice;
  @action
  void setSelectedBluetoothDevice(BluetoothDevice device) {
    selectedBluetoothDevice = device;
  }

  @observable
  BluetoothDeviceState selectedBluetoothDeviceState;
  @action
  void setSelectedBluetoothDeviceState(BluetoothDeviceState state) {
    selectedBluetoothDeviceState = state;
  }

  @observable
  List<BluetoothDevice> connectedDevices = [];
  @action
  void setConnectedDevices(List<BluetoothDevice> devices) {
    connectedDevices = devices;
  }

  @observable
  bool locationServiceEnabled;

  @observable
  GeolocationStatus geolocationStatus = GeolocationStatus.unknown;

  @observable
  bool storagePermission;

  @action
  void setStoragePermission(bool b) {
    storagePermission = b;
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

  @observable
  BluetoothCharacteristic bcReceiver;
  @observable
  BluetoothCharacteristic bcTransmitter;
  @observable
  Stream<List<int>> transmitterDataStream;

  @action
  void setBcReceiver(BluetoothCharacteristic rx) {
    bcReceiver = rx;
  }
  @action
  void setBcTransmitter(BluetoothCharacteristic tx) {
    bcTransmitter = tx;
  }
  @action
  void setTransmitterDataStream(Stream<List<int>> str) {
    transmitterDataStream = str;
  }

}
