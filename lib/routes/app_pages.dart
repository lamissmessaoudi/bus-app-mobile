import 'package:get/get.dart';
import 'package:softun_bus_mobile/bindings/activation_binding.dart';
import 'package:softun_bus_mobile/bindings/forget_password_binding.dart';
import 'package:softun_bus_mobile/bindings/home_binding.dart';
import 'package:softun_bus_mobile/bindings/profile_binding.dart';
import 'package:softun_bus_mobile/bindings/request_station_controller.dart';
import 'package:softun_bus_mobile/bindings/roles_binding.dart';
import 'package:softun_bus_mobile/bindings/signin_binding.dart';
import 'package:softun_bus_mobile/bindings/visualize_binding.dart';
import 'package:softun_bus_mobile/bindings/welcome_binding.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/activation/activation_page.dart';
import 'package:softun_bus_mobile/screens/activation/welcome_page.dart';
import 'package:softun_bus_mobile/screens/auth/roles/roles_page.dart';
import 'package:softun_bus_mobile/screens/auth/signin/signin_page.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_page.dart';
import 'package:softun_bus_mobile/screens/home/home_page.dart';
import 'package:softun_bus_mobile/screens/profile/profile_page.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_station_page.dart';
import 'package:softun_bus_mobile/screens/visualize/visualize_page.dart';

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
    GetPage(
      name: Routes.profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.activate,
      page: () => ActivationPage(),
      binding: ActivationBinding(),
    ),
    GetPage(
      name: Routes.welcome,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    // GetPage(
    //   name: Routes.homeColab,
    //   page: () => HomeColabPage(),
    //   binding: HomeColabBinding(),
    // ),
    // GetPage(
    //   name: Routes.homeDriver,
    //   page: () => HomeDriverPage(),
    //   binding: HomeDriverBinding(),
    // ),
    GetPage(
      name: Routes.request,
      page: () => RequestPage(),
      binding: RequestStationBinding(),
    ),
    GetPage(
      name: Routes.forgetPassword,
      page: () => ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: Routes.visualize,
      page: () => VisualizePage(),
      binding: VisualizeBinding(),
    ),
  ];
}
