import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  String route = Get.parameters['route'] ?? '';

  // @override
  // onInit() async {
  //   super.onInit();
  //   route = Get.parameters['route'] ?? '';
  // }

  selectPage(int i) {
    currentIndex.value = i;
    update();
  }
}
