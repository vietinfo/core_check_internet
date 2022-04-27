import 'package:get/get.dart';

class NavigatorController extends GetxController {
  final RxList<String> list = <String>[].obs;
  // @override
  // void onInit() {
  //   fetch();
  //   super.onInit();
  // }

  fetch() async {
    await Future.delayed(const Duration(seconds: 4));
    print("dsdsds");
    list.value = [
      "3232",
      "dsds",
      "aa",
      "ggs",
      "dsds",
      "gsgs",
      "gsds",
      "dsda",
    ];
  }
}
