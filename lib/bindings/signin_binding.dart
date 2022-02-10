import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/auth/signin/signin_controller.dart';

class SigninBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninController>(() => SigninController());
  }
}
