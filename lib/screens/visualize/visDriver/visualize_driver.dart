import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:location/location.dart';
import 'package:softun_bus_mobile/style/colors.dart';

class VisualizeDriverPage extends StatefulWidget {
  const VisualizeDriverPage({Key? key}) : super(key: key);

  @override
  State<VisualizeDriverPage> createState() => _VisualizeDriverPageState();
}

class _VisualizeDriverPageState extends State<VisualizeDriverPage> {
  MapController mapController = MapController(
    initMapWithUserPosition: true,
  );

  final databaseReference = FirebaseDatabase.instance.ref();

  LocationData currentLocation =
      LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0});
  late StreamSubscription<LocationData> locationSubcription;

  Location location = new Location();

  late String _deviceid;

  Future<void> initDeviceId() async {
    late String deviceIdentifier;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.androidId!;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor!;
    }

    setState(() {
      _deviceid = deviceIdentifier;
    });
    print("_deviceid == $_deviceid");
  }

  void UpdateDatabase() async {
    print("UpdateDatabase");
    await databaseReference.child(_deviceid).set({
      'latitude': currentLocation.latitude,
      'longitude': currentLocation.longitude,
    });
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    initDeviceId();
    // initPlatformState();
    locationSubcription = location.onLocationChanged.listen((result) {
      print("result  = $result");
      if (mounted)
        setState(() {
          currentLocation = result;
          // mapController.animateCamera(
          //   CameraUpdate.newCameraPosition(
          //     CameraPosition(
          //         target: LatLng(
          //             currentLocation.latitude, currentLocation.longitude),
          //         zoom: 17),
          //   ),
          // );
        });
      print("Database Updated11 ");

      UpdateDatabase();
      print("Database Updated");
    });
  }

  // void initPlatformState() async {
  //   LocationData my_location;
  //   try {
  //     my_location = await location.getLocation();
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED')
  //       print("PERMISSION_DENIED");
  //     else if (e.code == 'PERMISSION_DENIED_NEVER_ASK')
  //        print("'Permission denied - please ask the user to enable it from the app settings'");

  //     my_location = null;
  //   }
  //   setState(() {
  //     currentLocation = my_location;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Map"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Text("Voir circuit "),
      //   onPressed: () async {
      //     RoadInfo roadInfo = await mapController.drawRoad(
      //       GeoPoint(
      //           latitude: 36.83189972628371,
      //           longitude: 10.232979910714306), //Sofrecom
      //       GeoPoint(
      //           latitude: 36.826914001839285,
      //           longitude: 10.193816593715127), //Hay Khadhra
      //       roadOption: RoadOption(
      //         roadColor: Colors.yellow,
      //         roadWidth: 70,
      //       ),
      //     );
      //     print("${roadInfo.distance}km");
      //     print("${roadInfo.duration}sec");
      //   },
      // ),
      // body: OSMFlutter(
      //   controller: mapController,
      //   trackMyPosition: false,
      //   initZoom: 14,
      //   minZoomLevel: 8,
      //   maxZoomLevel: 16,
      //   stepZoom: 1.0,
      //   userLocationMarker: UserLocationMaker(
      //     personMarker: MarkerIcon(
      //       icon: Icon(
      //         Icons.location_history_rounded,
      //         color: Colors.pink,
      //         size: 200,
      //       ),
      //     ),
      //     directionArrowMarker: MarkerIcon(
      //       icon: Icon(
      //         Icons.double_arrow,
      //         size: 200,
      //         color: Colors.orange,
      //       ),
      //     ),
      //   ),
      //   // roadConfiguration: RoadConfiguration(
      //   //   startIcon: MarkerIcon(
      //   //     icon: Icon(
      //   //       Icons.person,
      //   //       size: 64,
      //   //       color: Colors.brown,
      //   //     ),
      //   //   ),
      //   //   roadColor: Colors.yellowAccent,
      //   // ),
      //   markerOption: MarkerOption(
      //       defaultMarker: MarkerIcon(
      //     icon: Icon(
      //       Icons.person_pin_circle,
      //       color: Colors.blue,
      //       size: 56,
      //     ),
      //   )),
      // ),
      body: Container(
        color: Colors.red,
        height: 200,
        width: 200,
      ),
    );
  }
}
