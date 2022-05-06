import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  late GeoPoint selectedStation;
  late PickerMapController mapController = PickerMapController(
    initMapWithUserPosition: true,
  );
  selectLocation() async {
    selectedStation = await mapController.selectAdvancedPositionPicker();
  }
}
