import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              "assets/images/Graphic.svg",
              height: 150,
              width: 150,
              color: Colors.blue,
              package: "core_check_internet",
            ),
          ),
          // Positioned.fill(
          //     child: Align(
          //   alignment: Alignment.center,
          //   child: SvgPicture.asset(
          //     "assets/images/cloud.svg",
          //     height: 150,
          //     width: 150,
          //     color: Colors.blue,
          //     package: "core_check_internet",
          //   ),
          // )),
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              "assets/images/Graphic.svg",
              height: 150,
              width: 150,
              color: Colors.blue,
              package: "core_check_internet",
            ),
          ),
          const Positioned.fill(
              child: Center(
            child: Text(
              "Please wait ...",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Montserrat-Regular",
                  color: Colors.black54),
            ),
          ))
        ],
      ),
    );
  }
}
