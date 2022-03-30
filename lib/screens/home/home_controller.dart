import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/activation/activation_page.dart';
import 'package:softun_bus_mobile/screens/activation/welcome_page.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_page.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_page.dart';
import 'package:softun_bus_mobile/screens/profile/profile_controller.dart';
import 'package:softun_bus_mobile/screens/profile/profile_page.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class HomeController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();

  RxInt currentIndex = 0.obs;
  // String route = Get.parameters['route'] ?? '';
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> pages = [];
  final controller = Get.put(ProfileController());
  late RoleType role;
  var isLoadingHome = false.obs;

  @override
  onInit() async {
    super.onInit();
    await getRole();
    pages = [
      role == RoleType.collaborateur
          ? HomeColabPage()
          : role == RoleType.chauffeur
              ? HomeDriverPage()
              : WelcomePage(),
      ProfilePage(),
      ActivationPage(),
      // WelcomePage(),
    ];
  }

  getRole() async {
    try {
      isLoadingHome(true);

      print("getRole");
      var r = await sharedPreferenceService.getString("role");
      print("role prefs :  $r ");
      role = EnumToString.fromString(RoleType.values, r)!;
      print("=== role = $role /// type: ${role.runtimeType} ");
    } catch (error) {
      getErrorSnackBar(title: "Oops!", message: "something wrong");
    } finally {
      isLoadingHome(false);
      update();
    }
  }

  selectPage(int i) {
    currentIndex.value = i;
    update();
  }

  naviagtePage(int i) {
    Get.toNamed(Routes.initial);
    currentIndex.value = i;
    update();
  }
}
