import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';

class HomeColabBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeColabController>(() => HomeColabController());
  }
}
