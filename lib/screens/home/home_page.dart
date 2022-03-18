import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/activation/activation_page.dart';
import 'package:softun_bus_mobile/screens/activation/welcome_page.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_page.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_page.dart';
import 'package:softun_bus_mobile/screens/home/home_controller.dart';
import 'package:softun_bus_mobile/screens/profile/profile_page.dart';
import 'package:softun_bus_mobile/widgets/custom_animated_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomBar(),
      body: ConnectivityContainer(
        child: GetBuilder<HomeController>(
            init: HomeController(),
            initState: (_) {},
            builder: (controller) {
              return PageStorage(
                  bucket: controller.bucket,
                  child: controller.pages[controller.currentIndex.value]);

              // return getBody(controller);
              // SingleChildScrollView(
              //   child: Center(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SizedBox(height: 20),
              //         Text(
              //           "Home",
              //           style: AppTextStyles.primarySlab36,
              //         ),
              //         SizedBox(height: 100),
              //         CustomButton(
              //           text: "Profile",
              //           onTap: () => Get.toNamed(Routes.profile),
              //         ),
              //         SizedBox(height: 20),
              //         CustomButton(
              //           text: "Sign In",
              //           onTap: () => Get.toNamed(Routes.signin),
              //         ),
              //         SizedBox(height: 20),
              //         CustomButton(
              //           text: "Roles",
              //           onTap: () => Get.toNamed(Routes.roles),
              //         ),
              //         SizedBox(height: 20),
              //         CustomButton(
              //           text: "Activation",
              //           onTap: () => Get.toNamed(Routes.activate),
              //         ),
              //       ],
              //     ),
              //   ),

              // );
            }),
      ),
    );
  }
}

Widget _buildBottomBar() {
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
        // BottomNavyBarItem(
        //   icon: Icon(Icons.settings),
        //   title: Text('Settings'),
        //   textAlign: TextAlign.center,
        // ),
      ],
    ),
  );
}

Widget getBody(HomeController controller) {
  List<Widget> pages = [
    controller.route == Routes.homeColab
        ? HomeColabPage()
        : controller.route == Routes.homeDriver
            ? HomeDriverPage()
            : WelcomePage(),
    ProfilePage(),
    ActivationPage(),
    // WelcomePage(),
  ];
  return IndexedStack(
    index: controller.currentIndex.value,
    children: pages,
  );
}
