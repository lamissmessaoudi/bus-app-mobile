import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/models/transport_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/services/api/transport_api.dart';
import 'package:softun_bus_mobile/services/api/visualization_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class VisualizeDriverController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  TransportService transportApi = Get.find();
  VisualisationService visService = Get.find();
  final homeController = Get.put(HomeDriverController());

  late User fetchedUser;
  late CircuitResDto? chosenCircuit;
  var isLoadingVis = false.obs;
  var isLoadingTransort = false.obs;
  List<TransportDto> transportsList = [];

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

  void dispose() {
    print("dispose");
    locationSubcription.cancel();
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

  getLocations() async {
    try {
      print("getLocations...");

      var s = await sharedPreferenceService.getString("token");
      var t = Token.fromJson(json.decode(s)).access_token;

      var response =
          await transportApi.getLocations(token: t, circuit: chosenCircuit);

      transportsList = List<TransportDto>.from(
          response.data.map((x) => TransportDto.fromJson(x)));
      print("transportsList ${transportsList}");
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
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

  drawStationsMarkers(List<StationDto> stations) async {
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

  drawLocationsMarkers() async {
    getLocations();
    transportsList.forEach(
      (element) async => await mapController.addMarker(
        GeoPoint(longitude: element.longitude, latitude: element.latitude),
        markerIcon: MarkerIcon(
            icon: Icon(
          Icons.person_pin,
          size: 80,
          color: AppColors.green,
        )),
      ),
    );
  }

  drawRoad() async {
    RoadInfo roadInfo = await mapController.drawRoad(
      GeoPoint(
        latitude: 36.83188020162938,
        longitude: 10.232988952190393,
      ),
      GeoPoint(
        latitude: chosenCircuit!.depart.latitude,
        longitude: chosenCircuit!.depart.longitude,
      ),
      roadOption: RoadOption(
        roadColor: AppColors.blue,
        roadWidth: 20,
      ),
      // intersectPoint: chosenCircuit!.station
      //     .map((e) => GeoPoint(latitude: e.latitude, longitude: e.longitude))
      //     .toList(),
    );
    print("${roadInfo.distance}km");
    print("${roadInfo.duration}sec");
  }
}
