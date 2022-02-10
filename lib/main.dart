import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/bindings/connectivity_binding.dart';
import 'package:softun_bus_mobile/routes/app_pages.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();
  runApp(GetApp());
}

initServices() async {
  await Get.putAsync(() => AuthService().init());
}

class GetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.signin,
        initialBinding: NetworkBinding(),
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
        enableLog: true,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        // transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
