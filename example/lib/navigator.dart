import 'package:example/navigator_crl.dart';
import 'package:flutter/material.dart';
import 'package:core_check_internet/core_check_internet.dart';

class NavigatorScreen extends StatefulWidget {
  static const String routeName = '/NavigatorScreen';
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  final NavigatorController _navigatorController =
      Get.put(NavigatorController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      body: Scaffold(
        body: Obx(
          () {
            if (_navigatorController.list.isEmpty) {
              return const Center(
                child: Text("Rỗng"),
              );
            }
            return ListView.builder(
                itemBuilder: (context, index) =>
                    Text(_navigatorController.list[index]),
                itemCount: _navigatorController.list.length);
          },
        ),
      ),
      callBack: () async {
        await _navigatorController.fetch();
      },
    );
  }
}
