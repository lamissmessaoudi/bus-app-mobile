import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/activation_api.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/user_api.dart';
import 'package:softun_bus_mobile/services/api/visualization_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class ActivationController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();
  AuthService authApi = Get.find();
  ActivationService api = Get.find();
  UserService userApi = Get.find();
  VisualisationService visService = Get.find();
  GlobalKey<FormState> formKeyDropDown = GlobalKey<FormState>();

  final step = ActivationStep.Personal.obs;

  var nameController = TextEditingController(),
      lastnameController = TextEditingController(),
      phoneController = TextEditingController(),
      emailController = TextEditingController(),
      posteController = TextEditingController(),
      stationController = TextEditingController();

  var isLoadingActivation = false.obs;
  var locationBTN = false.obs;
  var newMdpVis = true.obs;
  var conMdpVis = true.obs;
  var mdp;

  dynamic activedUser;
  List<StationDto> stationsList = [];
  StationDto? chosenStation = null;

  GlobalKey<FormState> formKeyPersonel = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyLocation = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();

  toggleVisibility(RxBool vis) {
    vis.value = !vis.value;
    update();
  }

  String? validateEmpty(value) {
    if (value != null) {
      if (!value.isEmpty) {
        return null;
      }
    }
    return 'Veuillez remplir ce champs.';
  }

  String? validateEmail(value) {
    if (value.toString().isEmpty) {
      return "Entrez votre e-mail";
    } else if (!RegExp(r"^[a-zA-Z_\-.]+@[a-zA-Z_\-.]+$")
        .hasMatch(value.toString())) {
      return "Veuillez vérifier la validité de votre e-mail";
    }
  }

  String? validatePhone(value) {
    if (value.toString().isEmpty) {
      return "Entrez votre numéro de téléphone";
    } else if ((!RegExp(r'^-?[0-9]+$').hasMatch(value.toString())) ||
        (!(value.length == 8))) {
      return "Veuillez vérifier votre numéro de téléphone";
    }
  }

  String? validateNewPassword(value) {
    if (value.toString().isEmpty) {
      return "Entrez votre mot de passe";
    } else if (!(value.length >= 8)) {
      return "Le mot de passe doit avoir au moins 8 caractères";
    }
  }

  @override
  onInit() async {
    super.onInit();
    print("ON INIIIIIT ");
    emailController.text = Get.parameters['email'] ?? '';
    mdp = Get.parameters['password'] ?? '';
    await getStations();
  }

  @override
  void dispose() {
    //onClose
    nameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    stationController.dispose();
    posteController.dispose();

    super.dispose();
  }

  getStations() async {
    try {
      isLoadingActivation(true);
      print("getStations...");

      var response = await stationApi.getAllStations();

      stationsList = List<StationDto>.from(
          response.data.map((x) => StationDto.fromJson(x)));
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingActivation(false);
      update();
    }
  }

  void selectStation(StationDto? newval) {
    chosenStation = newval;
    print("selectStation    ${chosenStation}");
    update();
  }

  void setPerso() async {
    print("setPerso()");

    // to check the all the condition of the appTextField
    if (!formKeyPersonel.currentState!.validate()) {
      print("form Perso not valideee");
      return;
    }

    //Get deviceId from device
    String x = await visService.initDeviceId();
    print("visService.initDeviceId()  ${x}");
    if (x != null) {
      activedUser = InactiveUser(
          name: nameController.text,
          lastname: lastnameController.text,
          email: emailController.text,
          phone: phoneController.text,
          poste: posteController.text,
          active: true,
          deviceId: x);
      //save deviceId to the local storage
      await sharedPreferenceService.setString("deviceId", x);

      // Navigate to the next page
      step.value = ActivationStep.Location;
      update();
    } else
      print("deviceId === NULL");
  }

  void setLocation() async {
    //GET THE STATION FROM THE FORM
    print("iiiiiiii , ${activedUser.runtimeType}");
    if (chosenStation != null) {
      activedUser.station = chosenStation;
      stationController.text = chosenStation!.name;
    } else
      print("STAAAAATION === NULL");

    print("updated user station,     ${activedUser.station}");

    step.value = ActivationStep.Confirmation;

    update();
  }

  getUser(String t) async {
    print("Trying to getUser in sign in ...");
    try {
      // get user from api
      var response = await userApi.getUserFromApi(token: t);
      User u = User.fromJson(response.data);

      // Store user in local storage
      await sharedPreferenceService.setString(
          "user", jsonEncode(u.toSharedJson()));

      return u;
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }

  void activate() async {
    try {
      print("Trying to activate account...");
      if (activedUser == null) {
        getErrorSnackBar(title: "Oops!", message: "an error has occcured");
        return;
      }
      await api.activateUser(user: activedUser);

      print("Trying to sign in controller...");
      var resAuth =
          await authApi.signIn(username: emailController.text, password: mdp);
      print(" Sign In resAuth.statusCode  === ${resAuth.statusCode}");

      if (resAuth.statusCode == 200) {
        // get token and save it in local storage
        var token = Token.fromJson(resAuth.data);
        await sharedPreferenceService.setString(
            "token", jsonEncode(token.toJson()));

        // get token and save it in local storage
        var response = await userApi.getUserFromApi(token: token.access_token);
        User u = User.fromJson(response.data);
        // userConnected.user?.value = u;
        update();

        // save the newly created user in the local storage
        await sharedPreferenceService.setString(
            "user", jsonEncode(u.toSharedJson()));
        Get.toNamed(Routes.welcome);
      } else {
        Get.toNamed(Routes.signin);
      }
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }

  returnPage() {
    step.value == ActivationStep.Confirmation
        ? step.value = ActivationStep.Location
        : step.value == ActivationStep.Location
            ? step.value = ActivationStep.Personal
            : step.value = ActivationStep.Personal;
    update();
  }
}
