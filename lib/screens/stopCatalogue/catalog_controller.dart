import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class CircuitCatalogueController extends GetxController {
  AuthService api = Get.find();

  GlobalKey<FormState> formKeyRecuperEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyRecuperCode = GlobalKey<FormState>();
  // GlobalKey<FormState> formKeyRecuperPassword = GlobalKey<FormState>();

  var isLoadingCatalog = false.obs;
  var newMdpVis = true.obs;
  var conMdpVis = true.obs;

  toggleVisibility(RxBool vis) {
    vis.value = !vis.value;
    update();
  }

  // final step = .obs;

  @override
  onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
    //onClose

    super.dispose();
  }
}
