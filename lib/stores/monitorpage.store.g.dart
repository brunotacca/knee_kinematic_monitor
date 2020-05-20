// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitorpage.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MonitorPageStore on _MonitorPageStore, Store {
  final _$bluetoothStateAtom = Atom(name: '_MonitorPageStore.bluetoothState');

  @override
  BluetoothState get bluetoothState {
    _$bluetoothStateAtom.context.enforceReadPolicy(_$bluetoothStateAtom);
    _$bluetoothStateAtom.reportObserved();
    return super.bluetoothState;
  }

  @override
  set bluetoothState(BluetoothState value) {
    _$bluetoothStateAtom.context.conditionallyRunInAction(() {
      super.bluetoothState = value;
      _$bluetoothStateAtom.reportChanged();
    }, _$bluetoothStateAtom, name: '${_$bluetoothStateAtom.name}_set');
  }

  final _$selectedBluetoothDeviceAtom =
      Atom(name: '_MonitorPageStore.selectedBluetoothDevice');

  @override
  BluetoothDevice get selectedBluetoothDevice {
    _$selectedBluetoothDeviceAtom.context
        .enforceReadPolicy(_$selectedBluetoothDeviceAtom);
    _$selectedBluetoothDeviceAtom.reportObserved();
    return super.selectedBluetoothDevice;
  }

  @override
  set selectedBluetoothDevice(BluetoothDevice value) {
    _$selectedBluetoothDeviceAtom.context.conditionallyRunInAction(() {
      super.selectedBluetoothDevice = value;
      _$selectedBluetoothDeviceAtom.reportChanged();
    }, _$selectedBluetoothDeviceAtom,
        name: '${_$selectedBluetoothDeviceAtom.name}_set');
  }

  final _$selectedBluetoothDeviceStateAtom =
      Atom(name: '_MonitorPageStore.selectedBluetoothDeviceState');

  @override
  BluetoothDeviceState get selectedBluetoothDeviceState {
    _$selectedBluetoothDeviceStateAtom.context
        .enforceReadPolicy(_$selectedBluetoothDeviceStateAtom);
    _$selectedBluetoothDeviceStateAtom.reportObserved();
    return super.selectedBluetoothDeviceState;
  }

  @override
  set selectedBluetoothDeviceState(BluetoothDeviceState value) {
    _$selectedBluetoothDeviceStateAtom.context.conditionallyRunInAction(() {
      super.selectedBluetoothDeviceState = value;
      _$selectedBluetoothDeviceStateAtom.reportChanged();
    }, _$selectedBluetoothDeviceStateAtom,
        name: '${_$selectedBluetoothDeviceStateAtom.name}_set');
  }

  final _$connectedDevicesAtom =
      Atom(name: '_MonitorPageStore.connectedDevices');

  @override
  List<BluetoothDevice> get connectedDevices {
    _$connectedDevicesAtom.context.enforceReadPolicy(_$connectedDevicesAtom);
    _$connectedDevicesAtom.reportObserved();
    return super.connectedDevices;
  }

  @override
  set connectedDevices(List<BluetoothDevice> value) {
    _$connectedDevicesAtom.context.conditionallyRunInAction(() {
      super.connectedDevices = value;
      _$connectedDevicesAtom.reportChanged();
    }, _$connectedDevicesAtom, name: '${_$connectedDevicesAtom.name}_set');
  }

  final _$locationServiceEnabledAtom =
      Atom(name: '_MonitorPageStore.locationServiceEnabled');

  @override
  bool get locationServiceEnabled {
    _$locationServiceEnabledAtom.context
        .enforceReadPolicy(_$locationServiceEnabledAtom);
    _$locationServiceEnabledAtom.reportObserved();
    return super.locationServiceEnabled;
  }

  @override
  set locationServiceEnabled(bool value) {
    _$locationServiceEnabledAtom.context.conditionallyRunInAction(() {
      super.locationServiceEnabled = value;
      _$locationServiceEnabledAtom.reportChanged();
    }, _$locationServiceEnabledAtom,
        name: '${_$locationServiceEnabledAtom.name}_set');
  }

  final _$geolocationStatusAtom =
      Atom(name: '_MonitorPageStore.geolocationStatus');

  @override
  GeolocationStatus get geolocationStatus {
    _$geolocationStatusAtom.context.enforceReadPolicy(_$geolocationStatusAtom);
    _$geolocationStatusAtom.reportObserved();
    return super.geolocationStatus;
  }

  @override
  set geolocationStatus(GeolocationStatus value) {
    _$geolocationStatusAtom.context.conditionallyRunInAction(() {
      super.geolocationStatus = value;
      _$geolocationStatusAtom.reportChanged();
    }, _$geolocationStatusAtom, name: '${_$geolocationStatusAtom.name}_set');
  }

  final _$storagePermissionAtom =
      Atom(name: '_MonitorPageStore.storagePermission');

  @override
  bool get storagePermission {
    _$storagePermissionAtom.context.enforceReadPolicy(_$storagePermissionAtom);
    _$storagePermissionAtom.reportObserved();
    return super.storagePermission;
  }

  @override
  set storagePermission(bool value) {
    _$storagePermissionAtom.context.conditionallyRunInAction(() {
      super.storagePermission = value;
      _$storagePermissionAtom.reportChanged();
    }, _$storagePermissionAtom, name: '${_$storagePermissionAtom.name}_set');
  }

  final _$bcReceiverAtom = Atom(name: '_MonitorPageStore.bcReceiver');

  @override
  BluetoothCharacteristic get bcReceiver {
    _$bcReceiverAtom.context.enforceReadPolicy(_$bcReceiverAtom);
    _$bcReceiverAtom.reportObserved();
    return super.bcReceiver;
  }

  @override
  set bcReceiver(BluetoothCharacteristic value) {
    _$bcReceiverAtom.context.conditionallyRunInAction(() {
      super.bcReceiver = value;
      _$bcReceiverAtom.reportChanged();
    }, _$bcReceiverAtom, name: '${_$bcReceiverAtom.name}_set');
  }

  final _$bcTransmitterAtom = Atom(name: '_MonitorPageStore.bcTransmitter');

  @override
  BluetoothCharacteristic get bcTransmitter {
    _$bcTransmitterAtom.context.enforceReadPolicy(_$bcTransmitterAtom);
    _$bcTransmitterAtom.reportObserved();
    return super.bcTransmitter;
  }

  @override
  set bcTransmitter(BluetoothCharacteristic value) {
    _$bcTransmitterAtom.context.conditionallyRunInAction(() {
      super.bcTransmitter = value;
      _$bcTransmitterAtom.reportChanged();
    }, _$bcTransmitterAtom, name: '${_$bcTransmitterAtom.name}_set');
  }

  final _$receiverValueStreamAtom =
      Atom(name: '_MonitorPageStore.receiverValueStream');

  @override
  Stream<List<int>> get receiverValueStream {
    _$receiverValueStreamAtom.context
        .enforceReadPolicy(_$receiverValueStreamAtom);
    _$receiverValueStreamAtom.reportObserved();
    return super.receiverValueStream;
  }

  @override
  set receiverValueStream(Stream<List<int>> value) {
    _$receiverValueStreamAtom.context.conditionallyRunInAction(() {
      super.receiverValueStream = value;
      _$receiverValueStreamAtom.reportChanged();
    }, _$receiverValueStreamAtom,
        name: '${_$receiverValueStreamAtom.name}_set');
  }

  final _$_MonitorPageStoreActionController =
      ActionController(name: '_MonitorPageStore');

  @override
  void setSelectedBluetoothDevice(BluetoothDevice device) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setSelectedBluetoothDevice(device);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedBluetoothDeviceState(BluetoothDeviceState state) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setSelectedBluetoothDeviceState(state);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnectedDevices(List<BluetoothDevice> devices) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setConnectedDevices(devices);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStoragePermission(bool b) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setStoragePermission(b);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBluetoothState(BluetoothState state) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setBluetoothState(state);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGeolocationStatus(GeolocationStatus status) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setGeolocationStatus(status);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocationServiceEnabled(bool status) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setLocationServiceEnabled(status);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBcReceiver(BluetoothCharacteristic rx) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setBcReceiver(rx);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBcTransmitter(BluetoothCharacteristic tx) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setBcTransmitter(tx);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReceiverValueStream(Stream<List<int>> str) {
    final _$actionInfo = _$_MonitorPageStoreActionController.startAction();
    try {
      return super.setReceiverValueStream(str);
    } finally {
      _$_MonitorPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'bluetoothState: ${bluetoothState.toString()},selectedBluetoothDevice: ${selectedBluetoothDevice.toString()},selectedBluetoothDeviceState: ${selectedBluetoothDeviceState.toString()},connectedDevices: ${connectedDevices.toString()},locationServiceEnabled: ${locationServiceEnabled.toString()},geolocationStatus: ${geolocationStatus.toString()},storagePermission: ${storagePermission.toString()},bcReceiver: ${bcReceiver.toString()},bcTransmitter: ${bcTransmitter.toString()},receiverValueStream: ${receiverValueStream.toString()}';
    return '{$string}';
  }
}
