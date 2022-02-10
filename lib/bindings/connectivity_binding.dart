import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_manager.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectivityManager>(() => ConnectivityManager());
  }
}
