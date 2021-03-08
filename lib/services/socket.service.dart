import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:ChatApp/globals/enviorement.dart';
import 'package:ChatApp/services/auth.service.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
  void connect() async {
    final String cookie = await AuthService.getToken();
    this._socket = IO.io('${Enviorements.socketUrl}', {
      "transports": ["websocket"],
      "autoConnect": true,
      "forceNew": true,
      "extraHeaders": {
        "Cookie": cookie,
      }
    });

    this._socket.on("connect", (_) {
      print("connected");
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on("disconnect", (_) {
      print("disconnected");
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
