import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/visualize/visColab/visualize_colab.dart';
import 'package:softun_bus_mobile/screens/visualize/visualize_controller.dart';
import 'package:softun_bus_mobile/screens/visualize/visDriver/visualize_driver.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class VisualizePage extends StatelessWidget {
  const VisualizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<VisualizeController>(
            init: VisualizeController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingVis.value
                  ? CustomLoader()
                  : controller.role == RoleType.chauffeur
                      ? VisualizeDriverPage()
                      : VisualizeColabPage();

              // DrawerIcon(scaffoldState: scaffoldState)
              // Container(
              //   child: GestureDetector(
              //     child: Icon(
              //       Icons.arrow_back,
              //       color: AppColors.primaryColor,
              //       size: 50,
              //     ),
              //     onTap: () {
              //       Get.back();
              //     },
            }),
      ),
    );
  }
}
