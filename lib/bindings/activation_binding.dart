import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/activation/activation_controller.dart';

class ActivationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivationController>(() => ActivationController());
  }
}
