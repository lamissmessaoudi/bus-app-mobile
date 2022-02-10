import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/auth/roles/roles_controller.dart';

class RolesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RolesController>(() => RolesController());
  }
}
