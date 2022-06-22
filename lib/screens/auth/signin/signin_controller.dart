import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/models/req_res_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/services/api/user_api.dart';
import 'package:softun_bus_mobile/services/api/visualization_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class SigninController extends GetxController {
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  AuthService api = Get.find();
  UserService userApi = Get.find();
  VisualisationService visService = Get.find();
  SharedPreferenceService sharedPreferenceService = Get.find();
  late Token token;
  late User user;

  var loginController = TextEditingController(),
      passwordController = TextEditingController();

  var isLoadingSignIn = false.obs;

  var mdpVis = true.obs;

  toggleVisibility() {
    mdpVis.value = !mdpVis.value;
    update();
  }

  String? validateMDP(value) {
    if (value != null) {
      if (!value.isEmpty) {
        return null;
      }
    }
    return 'Entrez votre mot de passe.';
  }

  String? validateEmail(value) {
    if (value.toString().isEmpty) {
      return "Entrez votre e-mail";
    } else if (!RegExp(r"^[a-zA-Z_\-.]+@[a-zA-Z_\-.]+$")
        .hasMatch(value.toString())) {
      return "Veuillez vérifier la validité de votre e-mail";
    }
  }

  @override
  void dispose() {
    //onClose
    passwordController.dispose();
    loginController.dispose();
    super.dispose();
  }

  void signInUser() async {
    print("Trying to sign in ...");

    try {
      isLoadingSignIn(true);
      // to check the all the condition of the appTextField
      if (!formKey1.currentState!.validate()) {
        print("form not valideee");
        return;
      }
      var username = loginController.text;
      var password = passwordController.text;

      print("Trying to sign in controller...");
      var response = await api.signIn(username: username, password: password);

      if (response.statusCode == 200) {
        // get token and save it in local storage
        token = Token.fromJson(response.data);
        await sharedPreferenceService.setString(
            "token", jsonEncode(token.toJson()));

        //set the current device id to the connected user
        await setDeviceId(response.data['access_token']);

        //Get User Infos From Api
        user = await getUser(response.data['access_token']);

        //redirect the user to the Homepage
        Get.offAllNamed(Routes.roles);
      }

      // user inactive
      if (response.statusCode == 400) {
        var login = LoginRequest(password: password, username: username);
        //redirect the user to the Activate his account
        Get.offAllNamed(Routes.activate, parameters: {
          'login': jsonEncode(login.toJson()),
          'email': username,
          'password': password
        });
      }

      // wrong password
      if (response.statusCode == 401) {
        //Show snack bar error msg
        getErrorSnackBar(title: "Oops!", message: "Mot de passe incorrect");
      }
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingSignIn(false);
    }
  }

  getUser(String t) async {
    print("Trying to getUser in sign in ...");

    try {
      isLoadingSignIn(true);
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
    } finally {
      isLoadingSignIn(false);
    }
  }

  setDeviceId(String t) async {
    try {
      isLoadingSignIn(true);

      //Get deviceId from device
      String x = await visService.initDeviceId();
      print("visService.initDeviceId()  ${x}");

      //set deviceId to user
      var response = await userApi.setDeviceId(token: t, deviceId: x);

      //save deviceId to the local storage
      await sharedPreferenceService.setString("deviceId", x);
    } catch (error) {
      getErrorSnackBar(
          title: "Oops!", message: "setDeviceId ${error.toString()}");
      print(error);
    } finally {
      isLoadingSignIn(false);
      update();
    }
  }
}
