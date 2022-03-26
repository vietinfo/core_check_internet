import 'package:core_check_internet/core/listen_change_connection.dart';
import 'package:core_check_internet/core/loading_ui.dart';
import 'package:core_check_internet/core_check_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoInternetScreen extends StatefulWidget {
  final Widget body;
  const NoInternetScreen({Key? key, required this.body}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInterScreenState();
}

class _NoInterScreenState extends State<NoInternetScreen> {
  final GlobalKey<ScaffoldState> _scafState = GlobalKey<ScaffoldState>();
  final ListenChangeConnection _listenChangeConnection =
      ListenChangeConnection();
  @override
  void initState() {
    _listenChangeConnection.listenChangeConnection();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<bool>(
        stream: _listenChangeConnection.loaddingStream,
        initialData: true,
        builder: (context, snapshot) {
          return FutureBuilder<bool>(
              future: CheckInternetConnection().checkConnectionAvailability(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoadingScreen();
                if (snapshot.hasData && snapshot.data!) return widget.body;
                return Scaffold(
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
                );
              });
        });
  }
}
