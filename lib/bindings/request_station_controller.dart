import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_station_controller.dart';

class RequestStationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestStationController>(() => RequestStationController());
  }
}
