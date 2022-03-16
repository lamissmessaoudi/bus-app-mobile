import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';

class HomeDriverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeDriverController>(() => HomeDriverController());
  }
}
