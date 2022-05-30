import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/trajet_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/visualization_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class VisualizeColabController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();
  VisualisationService visService = Get.find();

  final homeController = Get.put(HomeColabController());

  var c = false.obs;
  late User user;
  late Trajet? chosenTrajet;
  Rx<String>? deviceid;

  var isLoadingVis = false.obs;

  MapController mapController = MapController(
    initMapWithUserPosition: true,
  );

  static var currentLatitude = 0.0.obs;
  static var currentLongitude = 0.0.obs;
  static var oldLatitude = 0.0.obs;
  static var oldLongitude = 0.0.obs;

  late StreamSubscription subscription;

  @override
  onInit() async {
    super.onInit();
    chosenTrajet = homeController.chosenTrajet;
    await getDriverDeviceId();

    subscription = visService.databaseReference
        .child(deviceid!.value)
        .onValue
        .listen((event) {
      var eventArgs = event.snapshot.value as Map;
      // var x = event.snapshot.value!['latitude'];
      currentLatitude.value = eventArgs['latitude'];
      currentLongitude.value = eventArgs['longitude'];
      update();
      removeOldMarker();
      drawDriverMarker();

      // mapController.animateCamera(
      //   CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //         target: LatLng(event.snapshot.value['latitude'],
      //             event.snapshot.value['longitude']),
      //         zoom: 17),
      //   ),
      // );
      oldLongitude.value = currentLongitude.value;
      oldLatitude.value = currentLatitude.value;
      update();
    });
  }

  getDriverDeviceId() async {
    try {
      isLoadingVis(true);
      String d = chosenTrajet!.user.deviceId;
      deviceid = d.obs;
      print("#Driver #deviceid :  $deviceid ");
    } catch (error) {
      getErrorSnackBar(
          title: "Oops!",
          message: "getDriverDeviceId sharedPreferenceService ");
    } finally {
      isLoadingVis(false);
      update();
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  drawDriverMarker() async {
    GeoPoint busLoc = GeoPoint(
        longitude: currentLongitude.value, latitude: currentLatitude.value);
    await mapController.addMarker(
      busLoc,
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.directions_bus_sharp,
          size: 80,
          color: AppColors.green,
        ),
      ),
    );
  }

  removeOldMarker() async {
    await mapController.removeMarker(
      GeoPoint(latitude: oldLatitude.value, longitude: oldLongitude.value),
    );
  }

  drawRoad() async {
    RoadInfo roadInfo = await mapController.drawRoad(
      GeoPoint(
        latitude: 36.83188020162938,
        longitude: 10.232988952190393,
      ),
      GeoPoint(
        latitude: chosenTrajet!.circuit.depart.latitude,
        longitude: chosenTrajet!.circuit.depart.longitude,
      ),
      roadOption: RoadOption(
        roadColor: AppColors.blue,
        roadWidth: 20,
      ),
      // intersectPoint: chosenTrajet!.circuit.station
      //     .map((e) => GeoPoint(latitude: e.latitude, longitude: e.longitude))
      //     .toList(),
    );
    print("${roadInfo.distance}km");
    print("${roadInfo.duration}sec");
  }
}
