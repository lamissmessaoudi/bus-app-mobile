import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/stopCatalogue/catalog_controller.dart';

class CatalogBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CircuitCatalogueController>(() => CircuitCatalogueController());
  }
}
