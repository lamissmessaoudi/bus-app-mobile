import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/services/api/activation_api.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/user_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class HomeColabController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();
  AuthService authApi = Get.find();
  ActivationService api = Get.find();
  UserService userApi = Get.find();
  var activeBtnPerso = false.obs;
  var updatedLocation = false.obs;

  GlobalKey<FormState> formKeyStation = GlobalKey<FormState>();

  String? name;

  var isLoadingHome = false.obs;
  late User fetchedUser, updatedUser;
  late Station? chosenStation;
  late List<Station> stationsList;

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
    print("selectStation    ${chosenStation}");
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
      await sharedPreferenceService.setString("user", jsonEncode(u.toJson()));
      await getProfileData();
      autoFillFields();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }
}
