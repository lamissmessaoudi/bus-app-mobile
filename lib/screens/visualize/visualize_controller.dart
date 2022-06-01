import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/visualization_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class VisualizeController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();
  VisualisationService visService = Get.find();

  late RoleType role;
  var isLoadingVis = false.obs;

  @override
  onInit() async {
    super.onInit();
    await getRole();
    print("onInit");
  }

  getRole() async {
    try {
      isLoadingVis(true);

      print("getRole");
      var r = await sharedPreferenceService.getString("role");
      print("role prefs :  $r ");
      role = EnumToString.fromString(RoleType.values, r)!;
    } catch (error) {
      getErrorSnackBar(title: "Oops!", message: "something wrong");
    } finally {
      isLoadingVis(false);
      update();
    }
  }
}
