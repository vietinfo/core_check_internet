import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:core_check_internet/core/no_internet_crl.dart';
import 'package:core_check_internet/core_check_internet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInterScreenState();
}

class _NoInterScreenState extends State<NoInternetScreen> {
  final GlobalKey<ScaffoldState> _scafState = GlobalKey<ScaffoldState>();
  late StreamSubscription<InternetConnectionStatus> listener;
  @override
  void initState() {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        if (status == InternetConnectionStatus.connected) {
          Navigator.pop(context, true);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (!await InternetConnectionChecker().hasConnection) {
          CheckConnection().dispose();
          Navigator.pop(context, false);
          return true;
        }
        return true;
      },
      child: Scaffold(
        key: _scafState,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: size.height / 2,
                  ),
                  Positioned(
                    top: 10,
                    child: SvgPicture.asset(
                      "assets/images/Graphic.svg",
                      height: 150,
                      width: 150,
                      color: Colors.blue,
                      package: "core_check_internet",
                    ),
                  ),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/cloud.svg",
                      height: 150,
                      width: 150,
                      color: Colors.blue,
                      package: "core_check_internet",
                    ),
                  )),
                  Positioned(
                    bottom: 10,
                    child: SvgPicture.asset(
                      "assets/images/Graphic.svg",
                      height: 150,
                      width: 150,
                      color: Colors.blue,
                      package: "core_check_internet",
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: const [
                          Text(
                            "No Internet!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: "Montserrat-Regular",
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "It seems there is something wrong with your internet connection. Please connect to the internet ~.~!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat-Regular",
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox.shrink()
                    // SizedBox(
                    //     width: 150,
                    //     child: ElevatedButton(
                    //         onPressed: () async {
                    //           await _checkInternet();
                    //           if (_controller.check.value) {
                    //             Navigator.pop(_scafState.currentContext!);
                    //             // Navigator.pop(context);
                    //           }
                    //         },
                    //         child: const Text("Retry")))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
