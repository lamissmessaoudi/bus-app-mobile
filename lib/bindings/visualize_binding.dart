import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/visualize/visualize_controller.dart';

class VisualizeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisualizeController>(() => VisualizeController());
  }
}
