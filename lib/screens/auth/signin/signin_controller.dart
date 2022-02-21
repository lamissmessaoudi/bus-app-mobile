import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class SigninController extends GetxController {
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  AuthService api = Get.find();
  late Token token;

  SharedPreferenceService sharedPreferenceService = Get.find();

  var loginController = TextEditingController(),
      passwordController = TextEditingController();

  var isLoadingSignIn = false.obs;

  String? validateEmpty(value) {
    if (value != null) {
      if (!value.isEmpty) {
        return null;
      }
    }
    return 'Please provide a value.';
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

      print("response.runtimeType    " + (response.runtimeType.toString()));

      print("response    " + (response.toString()));
      token = Token(
        access_token: response.data['access_token'],
        token_type: response.data['token_type'],
        refresh_token: response.data['refresh_token'],
        expires_in: response.data['expires_in'],
      );
      print("token map ----- ");
      print(token);

      await sharedPreferenceService.setString(
          "token", jsonEncode(token.toJson()));
      // await sharedPreferenceService.setString("token", token.toString());

      var s = await sharedPreferenceService.getString("token");
      print("s =   ==== $s");
      //redirect the user to the Homepage
      Get.offAllNamed(Routes.roles);
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingSignIn(false);
    }
  }
}
