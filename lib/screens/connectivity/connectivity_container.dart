import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_manager.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import '';

class ConnectivityContainer extends GetWidget<ConnectivityManager> {
  ConnectivityContainer({Key? key, required this.child}) : super(key: key);
  Widget child;
  @override
  Widget build(BuildContext context) {
    Get.put(ConnectivityManager());
    return GetBuilder<ConnectivityManager>(builder: (builder) {
      if (controller.connectionType != 0) {
        return child;
      }

      return Material(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Container(
                child: Image.asset(
                  Assets.internetOff,
                  width: Get.width,
                  height: Get.height,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
