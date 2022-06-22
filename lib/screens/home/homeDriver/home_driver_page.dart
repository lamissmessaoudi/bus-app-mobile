import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/driving_circuits.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/driving_selected.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/driving_stations.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/driving_start.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';
import 'package:softun_bus_mobile/widgets/custom_navigation_drawer.dart';
import 'package:softun_bus_mobile/widgets/drawer_icon.dart';

class HomeDriverPage extends StatelessWidget {
  const HomeDriverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeDriverController());
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldState,
      drawer: CustomDrawer(),
      body: ConnectivityContainer(
        child: GetBuilder<HomeDriverController>(
            init: HomeDriverController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingHome.value
                  ? CustomLoader()
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // BODY OF THE PAGE
                                Center(
                                  child: Container(
                                    width: 500,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 35),
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 10),
                                    child: controller.step ==
                                            DrivingStep.ciruitDriving
                                        ? DrivingCircuits()
                                        : controller.step ==
                                                DrivingStep.stationsDriving
                                            ? DrivingStations()
                                            : controller.step ==
                                                    DrivingStep.startDriving
                                                ? StartDriving()
                                                : DrivingSelected(),
                                  ),
                                ),
                                SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                        DrawerIcon(scaffoldState: scaffoldState)
                      ],
                    );
            }),
      ),
    );
  }
}
