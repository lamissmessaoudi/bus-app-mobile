import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
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
  TransportService transportApi = Get.find();
  var activeBtnPerso = false.obs;
  var updatedLocation = false.obs;

  GlobalKey<FormState> formKeyStation = GlobalKey<FormState>();
  String? name;
  Rx<CollabStep>? step;

  var isLoadingHome = false.obs;
  late User fetchedUser, updatedUser;
  late Station? chosenStation;
  late CircuitDto? chosenCircuit;
  late Trajet? chosenTrajet;
  late Transport? chosenTransport;
  late String driverDeviceId;
  late List<Station> stationsList;
  late List<Station> trajetStops;
  late GeoPoint reservationPosition;
  late List<CircuitDto>? circuitList;

  @override
  onInit() async {
    super.onInit();
    await getProfileData();
    await checkReserverBus();
    await getStations();
    autoFillFields();
    print("steeeeep ==== $step");
  }

  Future<void> pullRefresh() async {
    try {
      print("pullRefresh... ");
      var response =
          await stationApi.getStationById(id: fetchedUser.station.id);
      Station s = Station.fromJson(response.data);

      circuitList = s.circuit;
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }

    await Future.delayed(Duration(seconds: 2));
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
    update();
  }

  getStations() async {
    try {
      isLoadingHome(true);
      print("getStations...");

      var response = await stationApi.getAllStations();
      // print(response);

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
      circuitList = fetchedUser.station.circuit;
      update();
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
    try {
      isLoadingHome(true);
      print("Trying to get Trajet...");

      // get token
      var s = await sharedPreferenceService.getString("token");
      var t = Token.fromJson(json.decode(s)).access_token;

      // Set the location of user

      reservationPosition = GeoPoint(latitude: latitude, longitude: longitude);
      print("setPosition    ${reservationPosition}");

      //Set the chosen circuit
      chosenCircuit = circuit;

      // Add User to Transport table
      Transport transport = Transport(
          circuit: chosenCircuit!, latitude: latitude, longitude: longitude);
      var responseTransport =
          await transportApi.addUserToTransport(token: t, transport: transport);
      chosenTransport = transport;
      update();

      print("responseTransport.  ${responseTransport}");

      print(responseTransport.statusCode);
      print(responseTransport.data);

      // get trajet of chosen circuit to get the Driver&Stations
      var responseTrajet =
          await trajetApi.getTrajet(token: t, circuit: chosenCircuit!);
      // getSuccessSnackBar(title: "Succés", message: "Trajet obtenu avec succés");
      chosenTrajet = Trajet.fromJson(responseTrajet.data);
      print("chosenTrajet    ${chosenTrajet}");

      update();
      getSuccessSnackBar(title: "Réservation avec Succés", message: "");

      Get.toNamed(Routes.visualize)!.then((r) {
        step?.value = CollabStep.busSelected;
        update();
      });

      update();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingHome(false);
      update();
    }
  }

  checkReserverBus() async {
    print("checkReserverBus");
    try {
      isLoadingHome(true);
      // get token
      var s = await sharedPreferenceService.getString("token");
      var t = Token.fromJson(json.decode(s)).access_token;

      // Checks if the collab has already picked a circuit
      var responseCheckReserved = await transportApi.reservedBus(token: t);
      print(' checkReserverBus code');
      print(responseCheckReserved.statusCode);
      print("alreadyChosenTransport    ${responseCheckReserved.data}");

      if (responseCheckReserved.statusCode == 200) {
        Transport transport = Transport.fromJson(responseCheckReserved.data);
        chosenTransport = transport;
        chosenCircuit = transport.circuit;
        reservationPosition = GeoPoint(
            latitude: transport.latitude, longitude: transport.longitude);
        print("alreadyChosenTransport /n   ${chosenCircuit}");
        update();

        // get trajet of chosen circuit to get the Driver&Stations
        var responseTrajet =
            await trajetApi.getTrajet(token: t, circuit: chosenCircuit!);
        // getSuccessSnackBar(title: "Succés", message: "Trajet obtenu avec succés");
        chosenTrajet = Trajet.fromJson(responseTrajet.data);
        print("chosenTrajet    ${chosenTrajet}");

        step = CollabStep.busSelected.obs;
        update();
      }

      if (responseCheckReserved.statusCode == 404) {
        step = CollabStep.busList.obs;
        update();
      }
      update();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingHome(false);
      update();
    }
  }
}
