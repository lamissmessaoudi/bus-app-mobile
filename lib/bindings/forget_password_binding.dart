import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_controller.dart';

class ForgetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
  }
}
