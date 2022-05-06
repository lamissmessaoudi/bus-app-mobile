import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/auth/roles/roles_controller.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

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
              child: controller.isLoadingRoles.value
                  ? CustomLoader()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          Image.asset(
                            Assets.logoSofrecom,
                            height: 200,
                          ),
                          SizedBox(height: 70),
                          Center(
                            child: Container(
                              width: 500,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child:
                                            Image.asset(Assets.collaborateur),
                                      ),
                                      CustomButton(
                                        text: "Collaborateur",
                                        onTap: () => controller
                                            .setRole(RoleType.collaborateur),
                                        btnType: controller.roleList.contains(
                                                RoleType.collaborateur)
                                            ? BtnType.AccentFilled
                                            : BtnType.Inactive,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.asset(Assets.driver),
                                      ),
                                      CustomButton(
                                        text: "Chauffeur",
                                        onTap: () => controller
                                            .setRole(RoleType.chauffeur),
                                        btnType: controller.roleList
                                                .contains(RoleType.chauffeur)
                                            ? BtnType.AccentFilled
                                            : BtnType.Inactive,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
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
