// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepage.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageStore on _HomePageStore, Store {
  final _$bluetoothStateAtom = Atom(name: '_HomePageStore.bluetoothState');

  @override
  Observable<BluetoothState> get bluetoothState {
    _$bluetoothStateAtom.context.enforceReadPolicy(_$bluetoothStateAtom);
    _$bluetoothStateAtom.reportObserved();
    return super.bluetoothState;
  }

  @override
  set bluetoothState(Observable<BluetoothState> value) {
    _$bluetoothStateAtom.context.conditionallyRunInAction(() {
      super.bluetoothState = value;
      _$bluetoothStateAtom.reportChanged();
    }, _$bluetoothStateAtom, name: '${_$bluetoothStateAtom.name}_set');
  }

  final _$currentPageIndexAtom = Atom(name: '_HomePageStore.currentPageIndex');

  @override
  Observable<int> get currentPageIndex {
    _$currentPageIndexAtom.context.enforceReadPolicy(_$currentPageIndexAtom);
    _$currentPageIndexAtom.reportObserved();
    return super.currentPageIndex;
  }

  @override
  set currentPageIndex(Observable<int> value) {
    _$currentPageIndexAtom.context.conditionallyRunInAction(() {
      super.currentPageIndex = value;
      _$currentPageIndexAtom.reportChanged();
    }, _$currentPageIndexAtom, name: '${_$currentPageIndexAtom.name}_set');
  }

  final _$_HomePageStoreActionController =
      ActionController(name: '_HomePageStore');

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
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'bluetoothState: ${bluetoothState.toString()},currentPageIndex: ${currentPageIndex.toString()}';
    return '{$string}';
  }
}
