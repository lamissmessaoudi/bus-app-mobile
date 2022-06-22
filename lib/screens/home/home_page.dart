import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/home/home_controller.dart';
import 'package:softun_bus_mobile/widgets/bottombar_builder.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomBar(),
      body: ConnectivityContainer(
        child: GetBuilder<HomeController>(
            init: HomeController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingHome.value
                  ? CustomLoader()
                  : Stack(children: [
                      PageStorage(
                        bucket: controller.bucket,
                        child: controller.pages[controller.currentIndex.value],
                      ),
                      // return getBody(controller);
                    ]);
            }),
      ),
    );
  }
}

//THIS CODE BUILDS All the pages at once and in the same time at first
// problem: updating the profile doesn't update the info in the home
// we needed the pages to rebuild each time we navigate to them
/*

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
*/