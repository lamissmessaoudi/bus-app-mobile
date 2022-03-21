import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/activation/activation_page.dart';
import 'package:softun_bus_mobile/screens/activation/welcome_page.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_page.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_page.dart';
import 'package:softun_bus_mobile/screens/profile/profile_controller.dart';
import 'package:softun_bus_mobile/screens/profile/profile_page.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  String route = Get.parameters['route'] ?? '';
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> pages = [];
  final controller = Get.put(ProfileController());

  @override
  onInit() async {
    super.onInit();
    pages = [
      route == Routes.homeColab
          ? HomeColabPage()
          : route == Routes.homeDriver
              ? HomeDriverPage()
              : WelcomePage(),
      ProfilePage(),
      ActivationPage(),
      // WelcomePage(),
    ];
  }

  selectPage(int i) {
    currentIndex.value = i;
    update();
  }
}
