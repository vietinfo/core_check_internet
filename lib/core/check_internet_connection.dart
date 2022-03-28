part of '../core_check_internet.dart';

class CheckInternetConnection {
  CheckInternetConnection._();
  static final CheckInternetConnection _instance = CheckInternetConnection._();
  factory CheckInternetConnection() => _instance;
  static late StreamSubscription<ConnectivityResult> listener;
  late bool _checkFirst = true;
  late bool checkCurrentInternet = true;
  init(BuildContext context) {
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        Flushbar(
          title: "Network Status",
          isDismissible: false,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.GROUNDED,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
          message: "You are disconnected from the internet.",
        ).show(context);
        checkFirst(false);
        checkCurrentInternet = false;
      }
      listener = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.wifi:
            if (_checkFirst) break;
            checkConnectionAvailability().then((value) {
              if (value) {
                checkCurrentInternet = true;
                Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  title: "Network Status",
                  duration: const Duration(seconds: 3),
                  message: "Your device has been connected Internet",
                ).show(context);
              } else {
                checkCurrentInternet = false;
                Flushbar(
                  title: "Network Status",
                  isDismissible: false,
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                  message: "You are disconnected from the internet.",
                ).show(context);
              }
            });
            break;
          case ConnectivityResult.ethernet:
            if (_checkFirst) break;
            checkConnectionAvailability().then((value) {
              if (value) {
                checkCurrentInternet = true;
                Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  title: "Network Status",
                  duration: const Duration(seconds: 3),
                  message: "Your device has been connected Internet",
                ).show(context);
              } else {
                checkCurrentInternet = false;
                Flushbar(
                  title: "Network Status",
                  isDismissible: false,
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                  message: "You are disconnected from the internet.",
                ).show(context);
              }
            });
            break;
          case ConnectivityResult.mobile:
            if (_checkFirst) break;
            checkConnectionAvailability().then((value) {
              checkCurrentInternet = true;
              if (value) {
                Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  title: "Network Status",
                  duration: const Duration(seconds: 3),
                  message: "Your device has been connected Internet",
                ).show(context);
              } else {
                checkCurrentInternet = false;
                Flushbar(
                  title: "Network Status",
                  isDismissible: false,
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                  message: "You are disconnected from the internet.",
                ).show(context);
              }
            });
            break;
          default:
            checkCurrentInternet = false;
            Flushbar(
              title: "Network Status",
              isDismissible: false,
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.GROUNDED,
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
              message: "You are disconnected from the internet.",
            ).show(context);

            break;
        }
        checkFirst(false);
      });
    });
  }

  checkFirst(check) {
    _checkFirst = check;
  }

  Future<bool> checkConnectionAvailability() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    return false;
  }

  dispose() {
    listener.cancel();
  }
}
