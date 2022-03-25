part of '../core_check_internet.dart';

class CheckConnection {
  static late StreamSubscription<InternetConnectionStatus> listener;
  init(BuildContext context) {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.GROUNDED,
              title: "Network Status",
              duration: const Duration(seconds: 3),
              message: "Your device has been connected Internet",
            ).show(context);
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
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
      },
    );
  }

  checkInternetConnection(BuildContext context) async {
    bool _check = true;
    if (!await InternetConnectionChecker().hasConnection) {
      await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoInternetScreen()))
          .then((value) => _check = value);
      if (_check == true) {
        init(context);
      }
      return _check;
    }
    init(context);
    return _check;
  }

  dispose() {
    listener.cancel();
  }
}
