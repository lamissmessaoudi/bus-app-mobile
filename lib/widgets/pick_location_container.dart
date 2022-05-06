// This widget will be used in the activation and demande loction picker and
// The selected location lat and lon will be saved in LocationController

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/requestStation/location_controller.dart';

class LocationPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final c = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return CustomPickerLocation(
      controller: c.mapController,
      bottomWidgetPicker: Positioned(
        bottom: 12,
        right: 8,
        child: FloatingActionButton(
          onPressed: c.selectLocation,
          child: Icon(Icons.arrow_forward),
        ),
      ),
      pickerConfig: CustomPickerLocationConfig(
        initZoom: 8,
      ),
    );
  }
}
