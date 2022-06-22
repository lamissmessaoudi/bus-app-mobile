import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/trajet_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
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

    try {
      print("eeeeeeeeeeeeee $deviceid");
      subscription = visService.databaseReference
          .child(deviceid!.value)
          .onValue
          .listen((event) {
        print("new pos");
        removeOldMarker();

        var eventArgs = event.snapshot.value as Map;
        print("sss ${event.snapshot.value}");
        // var x = event.snapshot.value!['latitude'];
        currentLatitude.value = eventArgs['latitude'];
        currentLongitude.value = eventArgs['longitude'];
        print("new pos ${currentLatitude.value} , ${currentLongitude.value}");
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
        print("old : ${oldLatitude.value},   ${oldLongitude.value}");
        print(
            "current : ${currentLatitude.value},   ${currentLongitude.value}");

        oldLongitude.value = currentLongitude.value;
        oldLatitude.value = currentLatitude.value;
        update();
      });
    } catch (e) {
      print(e);
      Get.toNamed(Routes.homeColab);
    }
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
    removeOldMarker();
    GeoPoint busLoc = GeoPoint(
        longitude: currentLongitude.value, latitude: currentLatitude.value);
    print("drawDriverMarker");
    print("pb ${currentLatitude.value} , ${currentLongitude.value}");
    await mapController.addMarker(
      busLoc,
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.directions_bus_sharp,
          size: 80,
          color: Colors.amber,
        ),
      ),
    );
  }

  removeOldMarker() async {
    print("removeOldMarker");
    await mapController.removeMarker(
      GeoPoint(latitude: oldLatitude.value, longitude: oldLongitude.value),
    );
  }

  drawRoad() async {
    RoadInfo roadInfo = await mapController.drawRoad(
      GeoPoint(
        latitude: chosenTrajet!.circuit.depart.latitude,
        longitude: chosenTrajet!.circuit.depart.longitude,
      ),
      GeoPoint(
        latitude: 36.83188020162938,
        longitude: 10.232988952190393,
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
