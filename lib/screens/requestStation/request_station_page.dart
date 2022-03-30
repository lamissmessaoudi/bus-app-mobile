import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_form_page.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_list_page.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_station_controller.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_success_page.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/widgets/bottombar_builder.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';
import 'package:softun_bus_mobile/widgets/custom_navigation_drawer.dart';
import 'package:softun_bus_mobile/widgets/drawer_icon.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    final c = Get.put(RequestStationController());

    return Scaffold(
      key: scaffoldState,
      drawer: CustomDrawer(),
      floatingActionButton: Obx(
        () => Container(
          child: c.step == RequestStep.requestList
              ? GestureDetector(
                  child: Image.asset(
                    Assets.add,
                    width: 50,
                  ),
                  onTap: () {
                    c.step.value = RequestStep.requestForm;
                    c.update();
                  },
                )
              : null,
        ),
      ),
      bottomNavigationBar: buildNavBar(),
      body: ConnectivityContainer(
        child: GetBuilder<RequestStationController>(
            init: RequestStationController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingRequest.value
                  ? CustomLoader()
                  : Stack(children: [
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
                                  margin: EdgeInsets.symmetric(horizontal: 35),
                                  padding: EdgeInsets.only(top: 30, bottom: 10),
                                  child: controller.step ==
                                          RequestStep.requestSucces
                                      ? RequestSuccessPage()
                                      : controller.step ==
                                              RequestStep.requestForm
                                          ? RequestFormPage()
                                          : RequestListPage(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DrawerIcon(scaffoldState: scaffoldState)
                    ]);
            }),
      ),
    );
  }
}
