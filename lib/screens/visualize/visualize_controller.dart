import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
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

  var c = false.obs;
  late User fetchedUser;
  late RoleType role;
  var isLoadingVis = false.obs;

  MapController mapController = MapController(
    initMapWithUserPosition: true,
  );

  // final databaseReference = FirebaseDatabase.instance.ref();

  Rx<LocationData?> currentLocation =
      LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}).obs;
  late StreamSubscription<LocationData> locationSubcription;

  Location location = new Location();

  Rx<String>? deviceid;

  @override
  onInit() async {
    super.onInit();
    await getRole();
    print("onInit");
    await getDeviceId();
    initPlatformState();

    locationSubcription = location.onLocationChanged.listen((result) {
      print("result  = $result");
      print("deviceid  = $deviceid");
      // if (mounted) {
      currentLocation.value = result;
      update();

      // mapController.animateCamera(
      //   CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //         target: LatLng(
      //             currentLocation.latitude, currentLocation.longitude),
      //         zoom: 17),
      //   ),
      // );
      print("object   UpdateDatabase();");
      // UpdateDatabase();
      visService.sendCurrentLocation(
        deviceid: deviceid!.value,
        currentLocation: currentLocation.value,
      );
    });
  }

  // devId() async {
  //   try {
  //     isLoadingVis(true);
  //     String x = await visService.initDeviceId();
  //     print("visService.initDeviceId()  ${x}");
  //     deviceid = x.obs;
  //   } catch (error) {
  //     getErrorSnackBar(title: "Oops!", message: "initDeviceId something wrong");
  //     print(error);
  //   } finally {
  //     isLoadingVis(false);
  //     update();
  //   }
  // }
  // Future<void> initDeviceId() async {
  //   late String deviceIdentifier;
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   try {
  //     isLoadingVis(true);
  //     print("    initDeviceId();");
  //     if (Platform.isAndroid) {
  //       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //       deviceIdentifier = androidInfo.androidId!;
  //     } else if (Platform.isIOS) {
  //       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //       deviceIdentifier = iosInfo.identifierForVendor!;
  //     }
  //     print("deviceIdentifier == ${deviceIdentifier}");
  //     deviceid = deviceIdentifier.obs;
  //     update();
  //   } catch (error) {
  //     getErrorSnackBar(title: "Oops!", message: "initDeviceId something wrong");
  //     print(error);
  //   } finally {
  //     isLoadingVis(false);
  //     update();
  //   }
  // }

  // void UpdateDatabase() async {
  //   print("UpdateDatabase");
  //   try {
  //     await databaseReference.child(deviceid!.value).set({
  //       'latitude': currentLocation.value?.latitude,
  //       'longitude': currentLocation.value?.longitude,
  //     });

  //     print("currentLocation == ${currentLocation}");
  //   } catch (error) {
  //     getErrorSnackBar(
  //         title: "Oops!", message: " UpdateDatabase something wrong");
  //     print(error);
  //   }
  // }

  void initPlatformState() async {
    try {
      isLoadingVis(true);

      LocationData? my_location;
      try {
        my_location = await location.getLocation();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED')
          print("PERMISSION_DENIED");
        else if (e.code == 'PERMISSION_DENIED_NEVER_ASK')
          print(
              "'Permission denied - please ask the user to enable it from the app settings'");

        my_location = null;
      }
      currentLocation.value = my_location;
      update();
    } catch (error) {
      getErrorSnackBar(
          title: "Oops!", message: "initPlatformState something wrong");
      print(error);
    } finally {
      isLoadingVis(false);
      update();
    }
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

  getDeviceId() async {
    try {
      isLoadingVis(true);
      String d = await sharedPreferenceService.getString("deviceId");
      print("getDeviceId vis prefs prefs :  $d ");
      deviceid = d.obs;
      print("###deviceid :  $deviceid ");
    } catch (error) {
      getErrorSnackBar(
          title: "Oops!", message: "getDeviceId sharedPreferenceService ");
    } finally {
      isLoadingVis(false);
      update();
    }
  }
}
