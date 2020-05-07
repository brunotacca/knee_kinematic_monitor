import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:knee_kinematic_monitor/stores/monitorpage.store.dart';

class GeolocatorStatusStream {
  GeolocatorStatusStream({HomePageStore homePageStore, MonitorPageStore monitorPageStore, Geolocator geolocator}) {
    t = Timer.periodic(Duration(seconds: 2), (t) async {
      GeolocationStatus s = await geolocator.checkGeolocationPermissionStatus();
      bool e = await geolocator.isLocationServiceEnabled();
      if (homePageStore != null) if (homePageStore.geolocationStatus != s ||
          homePageStore.locationServiceEnabled != e) {
        homePageStore.setGeolocationStatus(s);
        homePageStore.setLocationServiceEnabled(e);
        _controller.sink.add(e);
        return;
      }
      if (monitorPageStore != null) if (monitorPageStore.geolocationStatus != s ||
          monitorPageStore.locationServiceEnabled != e) {
        monitorPageStore.setGeolocationStatus(s);
        monitorPageStore.setLocationServiceEnabled(e);
        _controller.sink.add(e);
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
