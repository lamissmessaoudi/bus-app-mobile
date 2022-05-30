import 'dart:convert';

import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/activation_api.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/services/api/circuit_api.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/trajet_api.dart';
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
  TrajetService trajetApi = Get.find();

  var activeBtnPerso = false.obs;
  var updatedLocation = false.obs;
  Rx<DrivingStep>? step;

  String? name;

  var isLoadingHome = false.obs;
  late User fetchedUser, updatedUser;
  late CircuitResDto? chosenCircuit;
  late List<Circuit> circuitList;

  @override
  onInit() async {
    super.onInit();
    await getReservedCircuit();
    // await getCircuits();
    await getProfileData();

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
      print("${response.data}");
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

  //Checks if driver has chosen circuit that day: changes UI
  getReservedCircuit() async {
    try {
      isLoadingHome(true);
      var t = await getAccessToken();
      var response = await trajetApi.reservedCircuit(token: t);
      print('AAAAAAAAAA getReservedCircuit');
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        var c = CircuitResDto.fromJson((response.data));
        print(c.name);
        chosenCircuit = c;
        print('chosenCircuitg  etReservedCircuit  $chosenCircuit');

        step = DrivingStep.selectedDriving.obs;
        update();
      }
      if (response.statusCode == 404) {
        await getCircuits();
        step = DrivingStep.ciruitDriving.obs;
        update();
      }
      update();
    } catch (error) {
      getErrorSnackBar(title: "Oops!", message: "something wrong");
    } finally {
      isLoadingHome(false);
      update();
    }
  }

  setCircuit(Circuit newval) async {
    chosenCircuit = CircuitResDto(
      id: newval.id,
      // description: newval.description,
      available: newval.available,
      depart: newval.depart,
      name: newval.name,
      station: newval.station
          .map((e) => StationDto(
                id: e.id,
                description: e.description,
                latitude: e.latitude,
                longitude: e.longitude,
                name: e.name,
                subscribedUsers: e.subscribedUsers,
              ))
          .toList(),
    );
    print("setCircuit    ${chosenCircuit}");

    step?.value = DrivingStep.stationsDriving;
    update();
  }

  returnPage() {
    step?.value == DrivingStep.startDriving
        ? step?.value = DrivingStep.stationsDriving
        : step?.value == DrivingStep.stationsDriving
            ? step?.value = DrivingStep.ciruitDriving
            : step?.value = DrivingStep.ciruitDriving;
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
      Get.toNamed(Routes.visualize)!.then((r) {
        step?.value = DrivingStep.selectedDriving;
        update();
      });
      getSuccessSnackBar(
          title: "Succés", message: "Ce circuit est bien reservé pour vous!");
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }
}
