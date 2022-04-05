import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class RolesController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();

  late List<RoleType> roleList;
  var isLoadingRoles = false.obs;

  setRole(RoleType r) async {
    await sharedPreferenceService.setString(
        "role", EnumToString.convertToString(r));
    Get.offAllNamed(Routes.initial);
  }

  @override
  onInit() async {
    super.onInit();
    await getRolesList();
  }

  getRolesList() async {
    try {
      isLoadingRoles(true);
      var c = await sharedPreferenceService.getString("user");

      var user = User.fromJson(jsonDecode(c));
      roleList = user.roles;
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingRoles(false);
      update();
    }
  }
}
