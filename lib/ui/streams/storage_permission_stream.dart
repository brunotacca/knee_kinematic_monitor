import 'dart:async';
import 'package:knee_kinematic_monitor/stores/monitorpage.store.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';

class StoragePermissionStream {
  StoragePermissionStream({HomePageStore homePageStore, MonitorPageStore monitorPageStore}) {
    t = Timer.periodic(Duration(seconds: 2), (t) async {
      bool p = await Permission.storage.isGranted;
      if (homePageStore != null) if (homePageStore.storagePermission != p) {
        homePageStore.setStoragePermission(p);
        _controller.sink.add(p);
        return;
      }
      if (monitorPageStore != null) if (monitorPageStore.storagePermission != p) {
        monitorPageStore.setStoragePermission(p);
        _controller.sink.add(p);
        return;
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
