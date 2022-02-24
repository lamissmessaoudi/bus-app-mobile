import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/auth/roles/roles_controller.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';

class RolesPage extends StatelessWidget {
  const RolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<RolesController>(
          init: RolesController(),
          initState: (_) {},
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset(
                      Assets.logoSofrecom,
                      height: 200,
                    ),
                    SizedBox(height: 70),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(Assets.collaborateur),
                            ),
                            CustomButton(
                              text: "Collaborateur",
                              onTap: () => Get.toNamed(Routes.initial),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(Assets.driver),
                            ),
                            CustomButton(
                              text: "Chauffeur",
                              onTap: () => Get.toNamed(Routes.initial),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
