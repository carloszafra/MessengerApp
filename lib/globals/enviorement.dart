import 'dart:io';

class Enviorements {
  static String apiUrl = Platform.isAndroid
      ? "http://192.168.1.103:3000/api/" // 192.168.1.103 192.168.1.103
      : "http://localhost:3000/api/";

  static String socketUrl = Platform.isAndroid
      ? "http://192.168.1.103:3000"
      : "http://localhost:3000";
}
