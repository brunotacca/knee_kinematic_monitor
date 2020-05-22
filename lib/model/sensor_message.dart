import "dart:math" show pi;

import 'package:knee_kinematic_monitor/stores/global_settings.dart';

class SensorMessage {

  String rawMsg = "";
  String _msg = "";

  int counter = 0;
  DateTime timestamp;

  int sensorNumber = 0;

  double accelX = 0.0;
  double accelY = 0.0;
  double accelZ = 0.0;

  double gyrosX = 0.0;
  double gyrosY = 0.0;
  double gyrosZ = 0.0;

  double magneX = 0.0;
  double magneY = 0.0;
  double magneZ = 0.0;

  double fusionX = 0.0;
  double fusionY = 0.0;
  double fusionZ = 0.0;

  /*
  Message Format:
  "C" + sample counter (0->900 resets after reaching max)
  "S" + <SENSOR-NUMBER-1digit> + accel.xyz + gyros.xyz + magn.xyz
  "F" + fusion.xyz
  "#"
  */
  SensorMessage(String msg) {

    if(msg!=null
    && msg.contains(AppGlobalSettings.UART_MSG_SENSORDATA_COUNTER)
    && msg.contains(AppGlobalSettings.UART_MSG_SENSORDATA_SENSOR)
    && msg.contains(AppGlobalSettings.UART_MSG_SENSORDATA_FUSION)) {

      _msg = rawMsg = msg;

      //print("MSG1: "+_msg);
      _extractCounterTime();
      //print("MSG2: "+_msg);
      _extractSensorNumber();
      //print("MSG3: "+_msg);
      _extractAccelerometerData();
      //print("MSG4: "+_msg);
      _extractGyroscopeData();
      //print("MSG5: "+_msg);
      _extractMagnetometerData();
      //print("MSG6: "+_msg);
      _extractFusionData();
      //print("MSG7: "+_msg);
      //print(this.toString());

      if(_msg.length==1 && _msg.contains(AppGlobalSettings.UART_MSG_DELIMITER)) {
        //print("SUCESS!!");
      } else {
        print("ERROR, MISSING: $msg");
      }

    }

  }

  void _extractCounterTime() {
    timestamp = DateTime.now();
    String counterString = _msg.substring(_msg.indexOf(AppGlobalSettings.UART_MSG_SENSORDATA_COUNTER)+1, _msg.indexOf(AppGlobalSettings.UART_MSG_SENSORDATA_SENSOR));
    counter = int.parse(counterString);
    _msg = _msg.substring(_msg.indexOf(AppGlobalSettings.UART_MSG_SENSORDATA_SENSOR));
  }

  void _extractSensorNumber() {
    String sensorNumberString = _msg.substring(_msg.indexOf(AppGlobalSettings.UART_MSG_SENSORDATA_SENSOR)+1, _msg.indexOf(AppGlobalSettings.UART_MSG_SENSORDATA_SENSOR)+2);
    sensorNumber = int.parse(sensorNumberString);
    _msg = _msg.replaceRange(0, _msg.indexOf(AppGlobalSettings.UART_MSG_SENSORDATA_SENSOR)+2, "");
  }

  void _extractAccelerometerData() {
    String x = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");
    String y = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");
    String z = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");

    accelX = double.parse(x);
    accelY = double.parse(y);
    accelZ = double.parse(z);
  }

  void _extractGyroscopeData() {
    String x = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");
    String y = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");
    String z = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");

    gyrosX = double.parse(x);
    gyrosY = double.parse(y);
    gyrosZ = double.parse(z);
  }

  void _extractMagnetometerData() {
    String x = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");
    String y = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");
    String z = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");

    magneX = double.parse(x);
    magneY = double.parse(y);
    magneZ = double.parse(z);
  }

  void _extractFusionData() {
    String x = _msg.substring(1, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");
    String y = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");
    String z = _msg.substring(0, _msg.indexOf(".")+3);
    _msg = _msg.replaceRange(0, _msg.indexOf(".")+3, "");

    fusionX = _radToDegree(double.parse(x));
    fusionY = _radToDegree(double.parse(y));
    fusionZ = _radToDegree(double.parse(z));
  }

  double _radToDegree(double rad) {
    return rad * (180.0 / pi);
  }

  @override
  String toString() {
    return "C: $counter S:$sensorNumber Ax: $accelX Ay: $accelY Az: $accelZ Gx: $gyrosX Gy: $gyrosY Gz: $gyrosZ Mx: $magneX My: $magneY Mz: $magneZ Fx: $fusionX Fy: $fusionY Fz: $fusionZ";
  }

}