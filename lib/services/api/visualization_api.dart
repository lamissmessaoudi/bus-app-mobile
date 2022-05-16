import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class VisualisationService extends GetxService {
  Future<VisualisationService> init() async {
    // dio = createDio();
    return this;
  }

  final databaseReference = FirebaseDatabase.instance.ref();
  initDeviceId() async {
    late String deviceIdentifier;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceIdentifier = androidInfo.androidId!;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceIdentifier = iosInfo.identifierForVendor!;
      }
      print("deviceIdentifier == ${deviceIdentifier}");
      return deviceIdentifier;
    } catch (error) {
      getErrorSnackBar(title: "Oops!", message: "initDeviceId something wrong");
      print(error);
    }
  }

  void sendCurrentLocation(
      {required String deviceid,
      required LocationData? currentLocation}) async {
    // send current location to the Firebase database
    try {
      print("deviceid $deviceid");

      print("sendCurrentLocation");
      await databaseReference.child(deviceid).set({
        'latitude': currentLocation?.latitude,
        'longitude': currentLocation?.longitude,
      });
      print(" ${currentLocation}");
    } catch (error) {
      getErrorSnackBar(
          title: "Oops!", message: " sendCurrentLocation something wrong");
      print(error);
    }
  }
}
