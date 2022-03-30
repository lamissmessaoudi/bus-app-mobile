import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/home/home_controller.dart';
import 'package:softun_bus_mobile/widgets/custom_animated_bottom_bar.dart';

Widget buildBottomBar() {
  final controller = Get.put(HomeController());
  return Obx(
    () => CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: controller.currentIndex.value,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => controller.selectPage(index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Acceuil'),
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profil'),
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.location_on_sharp),
          title: Text(
            'Visualiser ',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

//for pages outside Home like demandes
Widget buildNavBar() {
  final controller = Get.put(HomeController());
  return Obx(
    () => CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: controller.currentIndex.value,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => controller.naviagtePage(index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Acceuil'),
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profil'),
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.location_on_sharp),
          title: Text(
            'Visualiser ',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
