import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/services/api/auth_api.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class ForgetPasswordController extends GetxController {
  AuthService api = Get.find();

  GlobalKey<FormState> formKeyRecuperEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyRecuperCode = GlobalKey<FormState>();
  // GlobalKey<FormState> formKeyRecuperPassword = GlobalKey<FormState>();

  var emailController = TextEditingController(),
      newMDPController = TextEditingController(),
      conMDPController = TextEditingController(),
      code1Controller = TextEditingController(),
      code2Controller = TextEditingController(),
      code3Controller = TextEditingController(),
      code4Controller = TextEditingController();

  var isLoadingRecuper = false.obs;
  var newMdpVis = true.obs;
  var conMdpVis = true.obs;

  toggleVisibility(RxBool vis) {
    vis.value = !vis.value;
    update();
  }

  final step = ForgetPasswordStep.recuperationEmail.obs;

  String? validateCode(value) {
    // if ((value.toString().isEmpty) ||
    //     (!RegExp(r"^[0-9]").hasMatch(value.toString()))) {
    //   return "Veuillez saisir le code correctement";
    // }
  }

  String? validateEmail(value) {
    if (value.toString().isEmpty) {
      return "Entrez votre e-mail";
    } else if (!RegExp(r"^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$")
        .hasMatch(value.toString())) {
      return "Veuillez vérifier la validité de votre e-mail";
    }
  }

  String? validateNewPassword(value) {
    if (value.toString().isEmpty) {
      return "Entrez votre mot de passe";
    } else if (!(value.length >= 8)) {
      return "Le mot de passe doit avoir au moins 8 caractères";
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
  }

  @override
  void dispose() {
    //onClose
    emailController.dispose();
    newMDPController.dispose();
    conMDPController.dispose();
    code1Controller.dispose();
    code2Controller.dispose();
    code3Controller.dispose();
    code4Controller.dispose();
    super.dispose();
  }

  getCode() async {
    // try {
    isLoadingRecuper(true);
    // to check the condition on email
    // if (!formKeyRecuperEmail.currentState!.validate()) {
    //   print("email not valideee");
    //   return;
    // }
    var email = emailController.text;
    code1Controller.text = '';
    code2Controller.text = '';
    code3Controller.text = '';
    code4Controller.text = '';

    step.value = ForgetPasswordStep.recuperationCode;
    update();
    // } catch (error) {
    //   print(error.toString());
    //   getErrorSnackBar(title: "Oops!", message: error.toString());
    // } finally {
    isLoadingRecuper(false);
    // }
  }

  sendCode() {
    try {
      isLoadingRecuper(true);
      // to check the condition on email
      // if (!formKeyRecuperCode.currentState!.validate()) {
      //   print("code or password  not valide");
      //   return;
      // }
      var code = code1Controller.text +
          code2Controller.text +
          code3Controller.text +
          code4Controller.text;

      step.value = ForgetPasswordStep.recuperationPassword;
      update();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingRecuper(false);
    }
  }

  updatePassword() {
    try {
      isLoadingRecuper(true);
      // to check the condition on email
      // if (!formKeyRecuperPassword.currentState!.validate()) {
      //   print("code or password  not valide");
      //   return;
      // }
      var password = newMDPController.text;

      step.value = ForgetPasswordStep.recuperationSucces;
      update();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingRecuper(false);
    }
  }
}
