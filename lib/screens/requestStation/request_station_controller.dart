import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/demande_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class RequestStationController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();

  GlobalKey<FormState> formKeyDemande = GlobalKey<FormState>();

  var descriptionController = TextEditingController(),
      zoneController = TextEditingController();

  late List<Demande> demandeList;
  var isLoadingRequest = false.obs;
  final step = RequestStep.requestList.obs;

  String? validateEmpty(value) {
    if (value != null) {
      if (!value.isEmpty) {
        return null;
      }
    }
    return 'Veuillez remplir ce champs.';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Demande d = Demande(
    //     name: "Demande",
    //     zone: "Ariana",
    //     description: "Rond point petite Arianna prés de magasin général",
    //     date: "20/05/2O22",
    //     state: RequestState.Accepted);
    demandeList = [];
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
          name: "Demande",
          zone: zoneController.text,
          description: descriptionController.text,
          date: "20/05/2O22",
          state: RequestState.Accepted);

      ///// FORE UI TESTS
      demandeList.add(d);
      step.value = RequestStep.requestSucces;
      update();

      var t = await getAccessToken();
      // var response = await stationApi.addStation(
      //   token: t,
      //   demande: d,
      // );

      // if (response.status == "200") {
      //   Get.toNamed(Routes.requestSuccess);
      // } else {
      //   getErrorSnackBar(title: "Oops!", message: response.message);
      // }
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }
}
