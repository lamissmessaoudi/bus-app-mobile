import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/user_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class ProfileController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  var nameController = TextEditingController(),
      telController = TextEditingController(),
      emailController = TextEditingController(),
      stationController = TextEditingController(),
      oldMDPController = TextEditingController(),
      newMDPController = TextEditingController(),
      conMDPController = TextEditingController();

  var isLoadingProfile = false.obs;
  var isLoadingPersoUpdate = false.obs;
  var isLoadingMDPUpdate = false.obs;

  UserService api = Get.find();

//  late String name,  tel , email ,  station ;
  // late User fetchetedUser;

  GlobalKey<FormState> formKeyPerso = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyMDP = GlobalKey<FormState>();

  //ProfileService api = Get.find();
  //late User user;

  String? validateEmpty(value) {
    if (value != null) {
      if (!value.isEmpty) {
        return null;
      }
    }
    return 'Please provide a value.';
  }

  String? validateEmail(value) {
    if (value.toString().isEmpty) {
      return "entrez votre e-mail";
    } else if (!RegExp(r"^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$")
        .hasMatch(value.toString())) {
      return "veuillez vérifier la validité de votre e-mail";
    }
  }

  String? validatePassword(value) {
    if (value.toString().isEmpty) {
      return "entrez votre mot de passe";
    } else if (!(value.length >= 8)) {
      return "le mot de passe doit être supérieure à 8 caractères minimum";
    }
  }

  String? validateConfirmedPassword(value) {
    if (value.toString().isEmpty) {
      return "veuillez re-taper votre mot de passe";
    } else if (value != newMDPController.text) {
      return "Les mots de passe ne coresspondent pas";
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('on init ');
    getProfileData();
    nameController.text = //fetchetedUser.name ;
        "Ahmed Ahmed";
    telController.text = //fetchetedUser.phoneNumber;
        "55 333 444";
    emailController.text = //fetchetedUser.email;
        "ahmed@gmail.com";
    stationController.text = //fetchetedUser.station.name;
        "Menzah 2 , Arianna";
  }

//Get Usqer From the shared preferences.
  void getProfileData() async {
    try {
      isLoadingProfile(true);

      print(isLoadingProfile.value);
      print("-------SUUCCESS-------");
      // var response = await api.getUser();

      print("#########################################");
      // fetchetedUser =
      // print(fetchetedUser);
    } catch (error) {
      print("---- error in cont : $error");
      getErrorSnackBar(title: "Oops!", message: "something wrong");
    } finally {
      isLoadingProfile(false);
    }
  }

  @override
  void dispose() {
    //onClose
    nameController.dispose();
    telController.dispose();
    emailController.dispose();
    stationController.dispose();
    oldMDPController.dispose();
    newMDPController.dispose();
    conMDPController.dispose();
    super.dispose();
  }

  void updatePerso() async {
    print("Trying to sign in ...");

    try {
      isLoadingPersoUpdate(true);
      // to check the all the condition of the appTextField
      if (!formKeyPerso.currentState!.validate()) {
        print("form Perso not valideee");
        return;
      }

      var name = nameController.text;
      var email = emailController.text;
      var station = stationController.text;
      var telephone = telController.text;

      print("Trying to update perso controller...");

      // print("response.runtimeType    " + (response.runtimeType.toString()));

      // print("response    " + (response.toString()));
      // token = Token(
      //   access_token: response.data['access_token'],
      //   token_type: response.data['token_type'],
      //   refresh_token: response.data['refresh_token'],
      //   expires_in: response.data['expires_in'],
      // );
      // print("token map ----- ");
      // print(token);

      // await sharedPreferenceService.setString(
      //     "token", jsonEncode(token.toJson()));
      // await sharedPreferenceService.setString("token", token.toString());

      // var s = await sharedPreferenceService.getString("token");
      // print("s =   ==== $s");
      //redirect the user to the Homepage
      Get.offAllNamed(Routes.initial);
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingPersoUpdate(false);
    }
  }

  void updatePassword() async {
    print("Trying to update Password ...");

    try {
      isLoadingMDPUpdate(true);
      // to check the all the condition of the appTextField
      if (!formKeyMDP.currentState!.validate()) {
        print("form MDP not valideee");
        return;
      }

      var oldMdp = nameController.text;
      var newMpd = emailController.text;
      var conMdp = stationController.text;

      print("Trying to update mdp controller...");

      Get.offAllNamed(Routes.initial);
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingMDPUpdate(false);
    }
  }
}
