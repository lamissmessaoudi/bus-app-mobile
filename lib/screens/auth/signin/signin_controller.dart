import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class SigninController extends GetxController {
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  AuthService api = Get.find();
  // SharedPreferenceService sharedPreferenceService = Get.find();

  var loginController = TextEditingController(),
      passwordController = TextEditingController();
  var isLoadingSignIn = false.obs;
  Rx<Color> field1Color = Colors.grey.obs;
  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      field1Color.value = AppColors.accentColor;
    });
    focusNode = FocusNode();
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  void signInUser() async {
    try {
      isLoadingSignIn(true);
      // to check the all the condition of the appTextField
      if (!formKey1.currentState!.validate()) return;

      var login = loginController.text;
      var password = passwordController.text;

      print("Trying to sign in ...");
      // var response = await api.signIn(login: login, password: password);

      //redirect the user to the Homepage
      Get.offAllNamed(Routes.initial);
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingSignIn(false);
    }
  }
}
