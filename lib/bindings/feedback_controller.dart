import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/feedBack/feedback_controller.dart';

class FeedBackBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedBackController>(() => FeedBackController());
  }
}
