import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/text.dart';

class StartDriving extends StatelessWidget {
  const StartDriving({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeDriverController());

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Bonjour ${controller.name}",
              textAlign: TextAlign.center,
              style: AppTextStyles.primarySlab36,
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            child: Container(
                height: 200,
                child: Image.asset(
                  Assets.start,
                  fit: BoxFit.contain,
                )),
            onTap: controller.selectCircuit,
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Commençons le circuit ?",
              style: AppTextStyles.primarySlab24,
            ),
          ),
        ],
      ),
    );
  }
}
