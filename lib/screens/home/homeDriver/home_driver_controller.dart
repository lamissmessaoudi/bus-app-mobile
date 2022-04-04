import 'dart:convert';

import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/services/api/activation_api.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/services/api/circuit_api.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/user_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class HomeDriverController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();
  CircuitService circuitApi = Get.find();
  AuthService authApi = Get.find();
  ActivationService api = Get.find();
  UserService userApi = Get.find();
  var activeBtnPerso = false.obs;
  var updatedLocation = false.obs;
  final step = DrivingStep.ciruitDriving.obs;

  String? name;

  var isLoadingHome = false.obs;
  late User fetchedUser, updatedUser;
  late Circuit? chosenCircuit;
  late List<Circuit> circuitList;

  @override
  onInit() async {
    super.onInit();
    await getProfileData();
    await getCircuits();
    name = fetchedUser.name;
  }

  getAccessToken() async {
    var s = await sharedPreferenceService.getString("token");
    var token = Token.fromJson(json.decode(s)).access_token;

    return token;
  }

  getCircuits() async {
    try {
      isLoadingHome(true);
      print("getCircuits ...");
      var t = await getAccessToken();

      var response = await circuitApi.getAvailableCircuits(token: t);

      circuitList =
          List<Circuit>.from(response.data.map((x) => Circuit.fromJson(x)));
      print("circuitList   :  $circuitList");
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

  setCircuit(Circuit? newval) async {
    chosenCircuit = newval;
    print("setCircuit    ${chosenCircuit}");

    step.value = DrivingStep.stationsDriving;
    update();
  }

  returnPage() {
    step.value == DrivingStep.startDriving
        ? step.value = DrivingStep.stationsDriving
        : step.value == DrivingStep.stationsDriving
            ? step.value = DrivingStep.ciruitDriving
            : step.value = DrivingStep.ciruitDriving;
    update();
  }

  selectCircuit() async {
    print("selectCircuit");

    try {
      if (chosenCircuit == null) {
        print("chosenCircuit is null");
        return;
      }
      var t = await getAccessToken();
      var response =
          await circuitApi.reserveCircuit(token: t, circuit: chosenCircuit!);

      getSuccessSnackBar(
          title: "Succés", message: "Ce circuit est bien reservé pour vous!");
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }
}
