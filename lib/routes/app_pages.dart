import 'package:get/get.dart';
import 'package:softun_bus_mobile/bindings/home_binding.dart';
import 'package:softun_bus_mobile/bindings/roles_binding.dart';
import 'package:softun_bus_mobile/bindings/signin_binding.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/auth/roles/roles_page.dart';
import 'package:softun_bus_mobile/screens/auth/signin/signin_page.dart';
import 'package:softun_bus_mobile/screens/home/home_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.signin,
      page: () => SigninPage(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: Routes.roles,
      page: () => RolesPage(),
      binding: RolesBinding(),
    ),
  ];
}
