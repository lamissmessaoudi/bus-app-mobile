import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/demande_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/screens/requestStation/location_controller.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class RequestStationController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();

  final locationController = Get.put(LocationController());

  GlobalKey<FormState> formKeyDemande = GlobalKey<FormState>();

  var descriptionController = TextEditingController(),
      zoneController = TextEditingController();

  late List<Demande> demandeList;
  var isLoadingRequest = false.obs;
  final step = RequestStep.requestList.obs;
  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);

  String? validateEmpty(value) {
    if (value != null) {
      if (!value.isEmpty) {
        return null;
      }
    }
    return 'Veuillez remplir ce champs.';
  }

  @override
  onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getRequests();
  }

  getRequests() async {
    try {
      isLoadingRequest(true);
      print("getRequests...");

      var t = await getAccessToken();
      var response = await stationApi.getUserRequests(token: t);
      print(response.data);

      demandeList =
          List<Demande>.from(response.data.map((x) => Demande.fromJson(x)));
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingRequest(false);
      update();
    }
  }

  getAccessToken() async {
    var s = await sharedPreferenceService.getString("token");
    var token = Token.fromJson(json.decode(s)).access_token;

    return token;
  }

  sendRequest() async {
    try {
      // to check the all the condition of the appTextField
      if (!formKeyDemande.currentState!.validate()) {
        print("form Add station not valideee");
        return;
      }
      Demande d = Demande(
        date: "",
        titre: zoneController.text,
        description: descriptionController.text,
        longitude: locationController.selectedStation.longitude,
        latitude: locationController.selectedStation.latitude,
      );

      var t = await getAccessToken();
      var response = await stationApi.addStation(
        token: t,
        demande: d,
      );

      step.value = RequestStep.requestSucces;
      await getRequests();
      update();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }
}
