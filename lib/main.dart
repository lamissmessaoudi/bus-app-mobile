import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/bindings/connectivity_binding.dart';
import 'package:softun_bus_mobile/routes/app_pages.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/activation_api.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/services/api/circuit_api.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/trajet_api.dart';
import 'package:softun_bus_mobile/services/api/transport_api.dart';
import 'package:softun_bus_mobile/services/api/user_api.dart';
import 'package:softun_bus_mobile/services/api/visualization_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(GetApp());
}

initServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase database = FirebaseDatabase.instance;
  await Get.putAsync(() => SharedPreferenceService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => UserService().init());
  await Get.putAsync(() => StationService().init());
  await Get.putAsync(() => CircuitService().init());
  await Get.putAsync(() => TransportService().init());
  await Get.putAsync(() => TrajetService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => ActivationService().init());
  await Get.putAsync(() => VisualisationService().init());
}

class GetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:
            // Routes.homeexpl,
            // Routes.maptest,
            Routes.signin,
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
