import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/collab_bus_list.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/collab_bus_selected.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';
import 'package:softun_bus_mobile/widgets/custom_navigation_drawer.dart';
import 'package:softun_bus_mobile/widgets/drawer_icon.dart';

class HomeColabPage extends StatelessWidget {
  const HomeColabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldState,
      drawer: CustomDrawer(),
      body: ConnectivityContainer(
        child: GetBuilder<HomeColabController>(
            init: HomeColabController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingHome.value
                  ? CustomLoader()
                  : RefreshIndicator(
                      onRefresh: controller.pullRefresh,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Center(
                              child: Container(
                                width: 500,
                                margin: EdgeInsets.symmetric(horizontal: 35),
                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                child: controller.step == CollabStep.busSelected
                                    ? CollabBusSelected()
                                    : CollabBusList(),
                              ),
                            ),
                          ),
                          DrawerIcon(scaffoldState: scaffoldState)
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
