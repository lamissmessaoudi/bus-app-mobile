import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/home/home_controller.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<HomeController>(
            init: HomeController(),
            initState: (_) {},
            builder: (controller) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Home",
                        style: AppTextStyles.primarySlab36,
                      ),
                      SizedBox(height: 100),
                      CustomButton(
                        text: "Profile",
                        onTap: () => Get.toNamed(Routes.profile),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: "Sign In",
                        onTap: () => Get.toNamed(Routes.signin),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: "Roles",
                        onTap: () => Get.toNamed(Routes.roles),
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
