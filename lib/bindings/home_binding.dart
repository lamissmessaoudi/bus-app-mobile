import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
