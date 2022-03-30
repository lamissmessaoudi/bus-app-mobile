import 'package:enum_to_string/enum_to_string.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';

class RolesController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  setRole(RoleType r) async {
    await sharedPreferenceService.setString(
        "role", EnumToString.convertToString(r));
    Get.offAllNamed(Routes.initial);
  }
}
