import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';

class StoragePermissionStream {

  StoragePermissionStream(HomePageStore homePageStore) {
    t = Timer.periodic(Duration(seconds: 2), (t) async {
      bool p = await Permission.storage.isGranted;
      if (homePageStore.storagePermission != p) {
        homePageStore.setStoragePermission(p);
        _controller.sink.add(p);
      }
    });
  }

  void dispose() {
    _controller.close();
    t.cancel();
  }

  Timer t;
  final _controller = StreamController<bool>();
  Stream<bool> get stream => _controller.stream;
}
