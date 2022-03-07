import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/activation/activation_controller.dart';
import 'package:softun_bus_mobile/screens/activation/activation_header.dart';
import 'package:softun_bus_mobile/screens/activation/active_confirmation.dart';
import 'package:softun_bus_mobile/screens/activation/active_location.dart';
import 'package:softun_bus_mobile/screens/activation/active_perso.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';

class ActivationPage extends StatelessWidget {
  const ActivationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<ActivationController>(
            init: ActivationController(),
            initState: (_) {},
            builder: (controller) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // HEADER
                      ActivationHeader(step: controller.step.value),

                      // BODY OF THE PAGE
                      Center(
                        child: Container(
                          width: 500,
                          child: controller.step == ActivationStep.Personal
                              ? ActivePerso(
                                  // nextPage: controller.nextPage
                                  )
                              : controller.step == ActivationStep.Location
                                  ? ActiveLocation(
                                      // nextPage: controller.nextPage
                                      )
                                  : ActiveConfiramation(
                                      // nextPage: controller.nextPage
                                      ),
                        ),
                      ),

                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
