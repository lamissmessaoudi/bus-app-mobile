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
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/widgets/custom_animated_bottom_bar.dart';
import 'package:softun_bus_mobile/widgets/custom_navigation_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(HomeController());
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldState,
      drawer: CustomDrawer(),
      bottomNavigationBar: _buildBottomBar(),
      body: ConnectivityContainer(
        child: GetBuilder<HomeController>(
            init: HomeController(),
            initState: (_) {},
            builder: (controller) {
              return Stack(children: [
                PageStorage(
                  bucket: controller.bucket,
                  child: controller.pages[controller.currentIndex.value],
                ),
                // return getBody(controller);
                Positioned(
                  left: 10,
                  top: 20,
                  child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () =>
                          scaffoldState.currentState?.openDrawer()),
                )
              ]);
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

//THIS CODE BUILDS All the pages at once and in the same time at first
// problem: updating the profile doesn't update the info in the home
// we needed the pages to rebuild each time we navigate to them
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
