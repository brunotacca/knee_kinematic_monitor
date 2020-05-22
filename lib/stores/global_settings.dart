abstract class AppGlobalSettings {
  static int countdownDuration = 1;
  static String deviceName = "KneeSensor";
  static String deviceId = "";

// Arduino Sensor UART:
// #define COPY_UART_SERVICE_UUID(uuid_struct)  COPY_UUID_128(uuid_struct,0x6E, 0x40, 0x00, 0x01, 0xB5, 0xA3, 0xF3, 0x93, 0xE0, 0xA9, 0xE5, 0x0E, 0x24, 0xDC, 0xCA, 0x9E)
// #define COPY_UART_TX_CHAR_UUID(uuid_struct)  COPY_UUID_128(uuid_struct,0x6E, 0x40, 0x00, 0x02, 0xB5, 0xA3, 0xF3, 0x93, 0xE0, 0xA9, 0xE5, 0x0E, 0x24, 0xDC, 0xCA, 0x9E)
// #define COPY_UART_RX_CHAR_UUID(uuid_struct)  COPY_UUID_128(uuid_struct,0x6E, 0x40, 0x00, 0x03, 0xB5, 0xA3, 0xF3, 0x93, 0xE0, 0xA9, 0xE5, 0x0E, 0x24, 0xDC, 0xCA, 0x9E)

  static const UART_SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  static const UART_TX_CHAR_UUID = "6e400002-b5a3-f393-e0a9-e50e24dcca9e";
  static const UART_RX_CHAR_UUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
  static const UART_MSG_SENSORDATA_COUNTER = "C";
  static const UART_MSG_SENSORDATA_SENSOR = "S";
  static const UART_MSG_SENSORDATA_FUSION = "F";
  static const UART_MSG_DELIMITER = "#";

}