// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepage.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageStore on _HomePageStore, Store {
  Computed<Color> _$progressBarColorComputed;

  @override
  Color get progressBarColor => (_$progressBarColorComputed ??=
          Computed<Color>(() => super.progressBarColor))
      .value;
  Computed<bool> _$canGoNextPageComputed;

  @override
  bool get canGoNextPage =>
      (_$canGoNextPageComputed ??= Computed<bool>(() => super.canGoNextPage))
          .value;
  Computed<int> _$pageViewItemCountManagedComputed;

  @override
  int get pageViewItemCountManaged => (_$pageViewItemCountManagedComputed ??=
          Computed<int>(() => super.pageViewItemCountManaged))
      .value;

  final _$startSettingsDoneAtom =
      Atom(name: '_HomePageStore.startSettingsDone');

  @override
  bool get startSettingsDone {
    _$startSettingsDoneAtom.context.enforceReadPolicy(_$startSettingsDoneAtom);
    _$startSettingsDoneAtom.reportObserved();
    return super.startSettingsDone;
  }

  @override
  set startSettingsDone(bool value) {
    _$startSettingsDoneAtom.context.conditionallyRunInAction(() {
      super.startSettingsDone = value;
      _$startSettingsDoneAtom.reportChanged();
    }, _$startSettingsDoneAtom, name: '${_$startSettingsDoneAtom.name}_set');
  }

  final _$introductionPageDoneAtom =
      Atom(name: '_HomePageStore.introductionPageDone');

  @override
  bool get introductionPageDone {
    _$introductionPageDoneAtom.context
        .enforceReadPolicy(_$introductionPageDoneAtom);
    _$introductionPageDoneAtom.reportObserved();
    return super.introductionPageDone;
  }

  @override
  set introductionPageDone(bool value) {
    _$introductionPageDoneAtom.context.conditionallyRunInAction(() {
      super.introductionPageDone = value;
      _$introductionPageDoneAtom.reportChanged();
    }, _$introductionPageDoneAtom,
        name: '${_$introductionPageDoneAtom.name}_set');
  }

  final _$bodyPlacementPageDoneAtom =
      Atom(name: '_HomePageStore.bodyPlacementPageDone');

  @override
  bool get bodyPlacementPageDone {
    _$bodyPlacementPageDoneAtom.context
        .enforceReadPolicy(_$bodyPlacementPageDoneAtom);
    _$bodyPlacementPageDoneAtom.reportObserved();
    return super.bodyPlacementPageDone;
  }

  @override
  set bodyPlacementPageDone(bool value) {
    _$bodyPlacementPageDoneAtom.context.conditionallyRunInAction(() {
      super.bodyPlacementPageDone = value;
      _$bodyPlacementPageDoneAtom.reportChanged();
    }, _$bodyPlacementPageDoneAtom,
        name: '${_$bodyPlacementPageDoneAtom.name}_set');
  }

  final _$gpsPageDoneAtom = Atom(name: '_HomePageStore.gpsPageDone');

  @override
  bool get gpsPageDone {
    _$gpsPageDoneAtom.context.enforceReadPolicy(_$gpsPageDoneAtom);
    _$gpsPageDoneAtom.reportObserved();
    return super.gpsPageDone;
  }

  @override
  set gpsPageDone(bool value) {
    _$gpsPageDoneAtom.context.conditionallyRunInAction(() {
      super.gpsPageDone = value;
      _$gpsPageDoneAtom.reportChanged();
    }, _$gpsPageDoneAtom, name: '${_$gpsPageDoneAtom.name}_set');
  }

  final _$bluetoothPageDoneAtom =
      Atom(name: '_HomePageStore.bluetoothPageDone');

  @override
  bool get bluetoothPageDone {
    _$bluetoothPageDoneAtom.context.enforceReadPolicy(_$bluetoothPageDoneAtom);
    _$bluetoothPageDoneAtom.reportObserved();
    return super.bluetoothPageDone;
  }

  @override
  set bluetoothPageDone(bool value) {
    _$bluetoothPageDoneAtom.context.conditionallyRunInAction(() {
      super.bluetoothPageDone = value;
      _$bluetoothPageDoneAtom.reportChanged();
    }, _$bluetoothPageDoneAtom, name: '${_$bluetoothPageDoneAtom.name}_set');
  }

  final _$connectedDevicePageDoneAtom =
      Atom(name: '_HomePageStore.connectedDevicePageDone');

  @override
  bool get connectedDevicePageDone {
    _$connectedDevicePageDoneAtom.context
        .enforceReadPolicy(_$connectedDevicePageDoneAtom);
    _$connectedDevicePageDoneAtom.reportObserved();
    return super.connectedDevicePageDone;
  }

  @override
  set connectedDevicePageDone(bool value) {
    _$connectedDevicePageDoneAtom.context.conditionallyRunInAction(() {
      super.connectedDevicePageDone = value;
      _$connectedDevicePageDoneAtom.reportChanged();
    }, _$connectedDevicePageDoneAtom,
        name: '${_$connectedDevicePageDoneAtom.name}_set');
  }

  final _$extraPermissionPageDoneAtom =
      Atom(name: '_HomePageStore.extraPermissionPageDone');

  @override
  bool get extraPermissionPageDone {
    _$extraPermissionPageDoneAtom.context
        .enforceReadPolicy(_$extraPermissionPageDoneAtom);
    _$extraPermissionPageDoneAtom.reportObserved();
    return super.extraPermissionPageDone;
  }

  @override
  set extraPermissionPageDone(bool value) {
    _$extraPermissionPageDoneAtom.context.conditionallyRunInAction(() {
      super.extraPermissionPageDone = value;
      _$extraPermissionPageDoneAtom.reportChanged();
    }, _$extraPermissionPageDoneAtom,
        name: '${_$extraPermissionPageDoneAtom.name}_set');
  }

  final _$bluetoothStateAtom = Atom(name: '_HomePageStore.bluetoothState');

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
      Atom(name: '_HomePageStore.selectedBluetoothDevice');

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
      Atom(name: '_HomePageStore.selectedBluetoothDeviceState');

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

  final _$connectedDevicesAtom = Atom(name: '_HomePageStore.connectedDevices');

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
      Atom(name: '_HomePageStore.locationServiceEnabled');

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
      Atom(name: '_HomePageStore.geolocationStatus');

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
      Atom(name: '_HomePageStore.storagePermission');

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

  final _$currentPageIndexAtom = Atom(name: '_HomePageStore.currentPageIndex');

  @override
  int get currentPageIndex {
    _$currentPageIndexAtom.context.enforceReadPolicy(_$currentPageIndexAtom);
    _$currentPageIndexAtom.reportObserved();
    return super.currentPageIndex;
  }

  @override
  set currentPageIndex(int value) {
    _$currentPageIndexAtom.context.conditionallyRunInAction(() {
      super.currentPageIndex = value;
      _$currentPageIndexAtom.reportChanged();
    }, _$currentPageIndexAtom, name: '${_$currentPageIndexAtom.name}_set');
  }

  final _$positionAtom = Atom(name: '_HomePageStore.position');

  @override
  Position get position {
    _$positionAtom.context.enforceReadPolicy(_$positionAtom);
    _$positionAtom.reportObserved();
    return super.position;
  }

  @override
  set position(Position value) {
    _$positionAtom.context.conditionallyRunInAction(() {
      super.position = value;
      _$positionAtom.reportChanged();
    }, _$positionAtom, name: '${_$positionAtom.name}_set');
  }

  final _$_HomePageStoreActionController =
      ActionController(name: '_HomePageStore');

  @override
  void setStartSettingsDone(bool done) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setStartSettingsDone(done);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedBluetoothDevice(BluetoothDevice device) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setSelectedBluetoothDevice(device);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedBluetoothDeviceState(BluetoothDeviceState state) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setSelectedBluetoothDeviceState(state);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnectedDevices(List<BluetoothDevice> devices) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setConnectedDevices(devices);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStoragePermission(bool b) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setStoragePermission(b);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPostion(Position pos) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setPostion(pos);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBluetoothState(BluetoothState state) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setBluetoothState(state);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGeolocationStatus(GeolocationStatus status) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setGeolocationStatus(status);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocationServiceEnabled(bool status) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setLocationServiceEnabled(status);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIntroductionPageDone(bool done) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setIntroductionPageDone(done);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setExtraPermissionPageDone(bool done) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setExtraPermissionPageDone(done);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBodyPlacementPageDone(bool done) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setBodyPlacementPageDone(done);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setGpsPageDone(bool done) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setGpsPageDone(done);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBluetoothPageDone(bool done) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setBluetoothPageDone(done);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setConnectedDevicePageDone(bool done) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setConnectedDevicePageDone(done);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'startSettingsDone: ${startSettingsDone.toString()},introductionPageDone: ${introductionPageDone.toString()},bodyPlacementPageDone: ${bodyPlacementPageDone.toString()},gpsPageDone: ${gpsPageDone.toString()},bluetoothPageDone: ${bluetoothPageDone.toString()},connectedDevicePageDone: ${connectedDevicePageDone.toString()},extraPermissionPageDone: ${extraPermissionPageDone.toString()},bluetoothState: ${bluetoothState.toString()},selectedBluetoothDevice: ${selectedBluetoothDevice.toString()},selectedBluetoothDeviceState: ${selectedBluetoothDeviceState.toString()},connectedDevices: ${connectedDevices.toString()},locationServiceEnabled: ${locationServiceEnabled.toString()},geolocationStatus: ${geolocationStatus.toString()},storagePermission: ${storagePermission.toString()},currentPageIndex: ${currentPageIndex.toString()},position: ${position.toString()},progressBarColor: ${progressBarColor.toString()},canGoNextPage: ${canGoNextPage.toString()},pageViewItemCountManaged: ${pageViewItemCountManaged.toString()}';
    return '{$string}';
  }
}
