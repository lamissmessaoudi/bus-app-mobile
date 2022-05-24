import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/models/trajet_model.dart';
import 'package:softun_bus_mobile/models/transport_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/activation_api.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/services/api/circuit_api.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/trajet_api.dart';
import 'package:softun_bus_mobile/services/api/transport_api.dart';
import 'package:softun_bus_mobile/services/api/user_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class HomeColabController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();
  AuthService authApi = Get.find();
  ActivationService api = Get.find();
  UserService userApi = Get.find();
  TrajetService trajetApi = Get.find();
  CircuitService circuitApi = Get.find();
  TransportService transpotApi = Get.find();
  var activeBtnPerso = false.obs;
  var updatedLocation = false.obs;

  GlobalKey<FormState> formKeyStation = GlobalKey<FormState>();
  String? name;

  var isLoadingHome = false.obs;
  late User fetchedUser, updatedUser;
  late Station? chosenStation;
  late CircuitDto? chosenCircuit;
  late Trajet? chosenTrajet;
  late String driverDeviceId;
  late List<Station> stationsList;
  late List<Station> trajetStops;
  late GeoPoint reservationPosition;

  @override
  onInit() async {
    super.onInit();
    await getProfileData();
    await getStations();
    autoFillFields();
  }

  getStations() async {
    try {
      isLoadingHome(true);
      print("getStations...");

      var response = await stationApi.getAllStations();

      stationsList =
          List<Station>.from(response.data.map((x) => Station.fromJson(x)));
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingHome(false);
      update();
    }
  }

  getProfileData() async {
    try {
      isLoadingHome(true);
      print('getProfileData');
      //Get User From the shared preferences.
      var c = await sharedPreferenceService.getString("user");

      var u = User.fromJson(jsonDecode(c));
      fetchedUser = u;
    } catch (error) {
      getErrorSnackBar(title: "Oops!", message: "something wrong");
    } finally {
      isLoadingHome(false);
      update();
    }
  }

  setBtnState() {
    // activate/desactivate the submit btn of popup
    activeBtnPerso.value = (chosenStation != fetchedUser.station);
    update();
  }

  autoFillFields() {
    // chosenStation = userConnected.user!.value.station; //= null;
    chosenStation = fetchedUser.station;
    name = fetchedUser.name;
    setBtnState();
  }

  void selectStation(Station? newval) {
    chosenStation = newval;
    update();
    setBtnState();
  }

  changeLocation() async {
    try {
      User updatedUser = fetchedUser;
      updatedUser.station = chosenStation ?? fetchedUser.station;

      print("Trying to update STATION controller...");

      var s = await sharedPreferenceService.getString("token");
      var t = Token.fromJson(json.decode(s)).access_token;

      var response = await userApi.updateUserPerso(token: t, user: updatedUser);
      getSuccessSnackBar(
          title: "Succés", message: "Station changée avec succés");

      updatedLocation.value = true;
      User u = User.fromJson(response.data);

      // save the updated user in the local storage
      await sharedPreferenceService.setString(
          "user", jsonEncode(u.toSharedJson()));
      await getProfileData();
      autoFillFields();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }

  reserverBus(
      {required double latitude,
      required double longitude,
      required CircuitDto circuit}) async {
    // Set the location of user
    reservationPosition = GeoPoint(latitude: latitude, longitude: longitude);
    print("setPosition    ${reservationPosition}");

    //Set the chosen circuit
    chosenCircuit = circuit;

    try {
      print("Trying to get Trajet...");

      // get token
      var s = await sharedPreferenceService.getString("token");
      var t = Token.fromJson(json.decode(s)).access_token;

      // get trajet of chosen circuit to get the Driver&Stations
      var response1 =
          await trajetApi.getTrajet(token: t, circuit: chosenCircuit!);
      // getSuccessSnackBar(title: "Succés", message: "Trajet obtenu avec succés");
      chosenTrajet = Trajet.fromJson(response1.data);
      print("chosenTrajet    ${chosenTrajet}");

      // Add User to Transport table
      Transport transport = Transport(
          circuit: chosenCircuit!, latitude: latitude, longitude: longitude);
      var response3 =
          await transpotApi.addUserToTransport(token: t, transport: transport);
      print("response3.  ${response3}");
      getSuccessSnackBar(title: "Réservation avec Succés", message: "");

      update();

      Get.toNamed(Routes.visualize);
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }
}
