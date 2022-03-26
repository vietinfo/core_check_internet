import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_check_internet/core_check_internet.dart';

class ListenChangeConnection {
  final StreamController<bool> loaddingController =
      StreamController<bool>.broadcast();
  Stream<bool> get loaddingStream => loaddingController.stream;
  Sink<bool> get loaddingSink => loaddingController.sink;
  bool _firstRun = true;
  listenChangeConnection() async {
    CheckInternetConnection().checkConnectionAvailability().then((value) {
      if (!value) {
        Connectivity()
            .onConnectivityChanged
            .listen((ConnectivityResult result) {
          if (_firstRun == true) {
            loaddingSink.add(true);
            _firstRun = false;
          }
        });
      } else {
        _firstRun = false;
      }
    });
  }
}
