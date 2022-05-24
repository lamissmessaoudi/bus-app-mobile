import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/visualization_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class VisualizeDriverController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();
  VisualisationService visService = Get.find();
  final homeController = Get.put(HomeDriverController());

  // var c = false.obs;
  late User fetchedUser;
  late Circuit? chosenCircuit;
  // late RoleType role;
  var isLoadingVis = false.obs;

  MapController mapController = MapController(
    initMapWithUserPosition: true,
  );

  Rx<LocationData?> currentLocation =
      LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}).obs;
  late StreamSubscription<LocationData> locationSubcription;

  Location location = new Location();

  Rx<String>? deviceid;

  @override
  onInit() async {
    super.onInit();
    chosenCircuit = homeController.chosenCircuit;
    await getDeviceId();
    initPlatformState();

    locationSubcription = location.onLocationChanged.listen((result) {
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
      // UpdateDatabase();
      visService.sendCurrentLocation(
        deviceid: deviceid!.value,
        currentLocation: currentLocation.value,
      );
    });
  }

  getDeviceId() async {
    try {
      isLoadingVis(true);
      String d = await sharedPreferenceService.getString("deviceId");
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

  drawStationsMarkers(List<Station> stations) async {
    stations.forEach(
      (element) async => await mapController.addMarker(
        GeoPoint(longitude: element.longitude, latitude: element.latitude),
        markerIcon: MarkerIcon(
            icon: Icon(
          Icons.pin_drop,
          size: 80,
          color: AppColors.errorColor,
        )),
      ),
    );
  }
}
