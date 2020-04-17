import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:ppgcc_flutter_iot_ble_data_gatherer/stores/homepage.store.dart';

class GeolocatorStatusStream {

  GeolocatorStatusStream(HomePageStore homePageStore, Geolocator geolocator) {
    t = Timer.periodic(Duration(seconds: 2), (t) async {
      GeolocationStatus s = await geolocator.checkGeolocationPermissionStatus();
      bool e = await geolocator.isLocationServiceEnabled();
      if (homePageStore.geolocationStatus != s
      || homePageStore.locationServiceEnabled != e) {
        homePageStore.setGeolocationStatus(s);
        homePageStore.setLocationServiceEnabled(e);
        _controller.sink.add(e);
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
