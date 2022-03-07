import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/activation/activation_controller.dart';
import 'package:softun_bus_mobile/screens/profile/profile_controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
