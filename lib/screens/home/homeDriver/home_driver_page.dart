import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/driving_circuits.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/driving_stations.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/driving_start.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class HomeDriverPage extends StatelessWidget {
  const HomeDriverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeDriverController());

    return Scaffold(
      floatingActionButton: Obx(
        () => Container(
          margin: EdgeInsets.only(left: 35),
          child: c.step == DrivingStep.stationsDriving
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        Assets.backFloating,
                        width: 50,
                      ),
                      onTap: c.returnPage,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        child: Image.asset(
                          Assets.nextFloating,
                          width: 50,
                        ),
                        onTap: () {
                          c.step.value = DrivingStep.startDriving;
                          c.update();
                        },
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
      body: ConnectivityContainer(
        child: GetBuilder<HomeDriverController>(
            init: HomeDriverController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingHome.value
                  ? CustomLoader()
                  : SingleChildScrollView(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // BODY OF THE PAGE
                            Center(
                              child: Container(
                                width: 500,
                                margin: EdgeInsets.symmetric(horizontal: 35),
                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                child:
                                    controller.step == DrivingStep.ciruitDriving
                                        ? DrivingCircuits()
                                        : controller.step ==
                                                DrivingStep.stationsDriving
                                            ? DrivingStations()
                                            : StartDriving(),
                              ),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
