import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/req_res_model.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/user_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class ProfileController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();

  var nameController = TextEditingController(),
      lastnameController = TextEditingController(),
      phoneController = TextEditingController(),
      emailController = TextEditingController(),
      stationController = TextEditingController(),
      oldMDPController = TextEditingController(),
      newMDPController = TextEditingController(),
      conMDPController = TextEditingController();

  var isLoadingProfile = false.obs;
  var oldMdpVis = true.obs;
  var newMdpVis = true.obs;
  var conMdpVis = true.obs;
  var activeBtnPerso = false.obs;
  var updatedPassword = false.obs;

  UserService api = Get.find();

  String? name, lastname;
  late User fetchetedUser, updatedUser;
  late Station? chosenStation;
  late List<Station> stationsList;

  GlobalKey<FormState> formKeyPerso = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyMDP = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyMDPwelcome = GlobalKey<FormState>();

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
    } else if (!RegExp(r"^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$")
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

  String? validatePassword(value) {
    if (value.toString().isEmpty) {
      return "Entrez votre mot de passe";
    }
  }

  String? validateNewPassword(value) {
    if (value.toString().isEmpty) {
      return "Entrez votre mot de passe";
    } else if (!(value.length >= 8)) {
      return "Le mot de passe doit avoir au moins 8 caractères";
    } else if (value == oldMDPController.text) {
      return "Le nouveau et ancien mots de passe doivent être différents";
    }
  }

  String? validateConfirmedPassword(value) {
    if (value.toString().isEmpty) {
      return "Veuillez re-taper votre mot de passe";
    } else if (value != newMDPController.text) {
      return "Les deux mots de passe ne se coresspondent pas";
    }
  }

  @override
  onInit() async {
    super.onInit();
    await getProfileData();
    await getStations();
    autoFillFields();
  }

  getStations() async {
    try {
      isLoadingProfile(true);
      print("getStations...");

      var response = await stationApi.getAllStations();

      stationsList =
          List<Station>.from(response.data.map((x) => Station.fromJson(x)));
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingProfile(false);
      update();
    }
  }

  autoFillFields() {
    nameController.text = fetchetedUser.name;
    lastnameController.text = fetchetedUser.lastname;
    phoneController.text = fetchetedUser.phone;
    emailController.text = fetchetedUser.email;
    // stationController.text = fetchetedUser.station.name;
    chosenStation = fetchetedUser.station; //= null;

    name = fetchetedUser.name;
    lastname = fetchetedUser.lastname;

    emptyPasswordFields();
    oldMdpVis.value = true;
    newMdpVis.value = true;
    conMdpVis.value = true;

    setBtnState();
  }

  emptyPasswordFields() {
    oldMDPController.text = '';
    newMDPController.text = '';
    conMDPController.text = '';
  }

  void selectStation(Station? newval) {
    chosenStation = newval;
    print("selectStation    ${chosenStation}");
    update();
    setBtnState();
  }

  @override
  void dispose() {
    //onClose
    nameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    stationController.dispose();
    oldMDPController.dispose();
    newMDPController.dispose();
    conMDPController.dispose();
    super.dispose();
  }

  getAccessToken() async {
    var s = await sharedPreferenceService.getString("token");
    var token = Token.fromJson(json.decode(s)).access_token;

    return token;
  }

  getProfileData() async {
    try {
      isLoadingProfile(true);
      print('getProfileData');
      //Get User From the shared preferences.
      var c = await sharedPreferenceService.getString("user");

      fetchetedUser = User.fromJson(jsonDecode(c));
    } catch (error) {
      getErrorSnackBar(title: "Oops!", message: "something wrong");
    } finally {
      isLoadingProfile(false);
      update();
    }
  }

  setBtnState() {
    // activate/desactivate the submit btn of Perso Form
    bool v = (nameController.text != fetchetedUser.name ||
        lastnameController.text != fetchetedUser.lastname ||
        phoneController.text != fetchetedUser.phone ||
        chosenStation != fetchetedUser.station);
    activeBtnPerso.value = v;
    update();
  }

  void updatePerso() async {
    try {
      // to check the all the condition of the appTextField
      if (!formKeyPerso.currentState!.validate()) {
        print("form Perso not valideee");
        return;
      }
      User updatedUser = fetchetedUser;
      updatedUser.name = nameController.text;
      updatedUser.lastname = lastnameController.text;
      updatedUser.email = emailController.text;
      updatedUser.phone = phoneController.text;
      updatedUser.station = chosenStation ?? fetchetedUser.station;

      print("Trying to update perso controller...");

      var t = await getAccessToken();
      var response = await api.updateUserPerso(token: t, user: updatedUser);
      User u = User.fromJson(response.data);

      // save the updated user in the local storage
      await sharedPreferenceService.setString(
          "user", jsonEncode(u.toSharedJson()));
      getSuccessSnackBar(
          title: "Succés", message: "Coordonnées changées avec succés");

      // get the newly updated user from the local storage to reFill the form and deativate the submit btn
      await getProfileData();
      autoFillFields();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }

  updatePassword(GlobalKey<FormState> f) async {
    print("Trying to update Password ...");

    try {
      // to check the all the condition of the appTextField
      if (!f.currentState!.validate()) {
        print("form MDP not valideee");
        return;
      }

      var oldMdp = oldMDPController.text;
      var newMpd = newMDPController.text;

      var t = await getAccessToken();
      var response = await api.updatePassword(
          token: t, newPassword: newMpd, oldPassword: oldMdp);

      ChangePasswordResponse res =
          ChangePasswordResponse.fromJson(response.data);

      if (res.status == "200") {
        getSuccessSnackBar(title: "Succés", message: res.message);
        updatedPassword.value = true;
        update();
        autoFillFields();
      } else {
        getErrorSnackBar(title: "Oops!", message: res.message);
      }
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }
}
