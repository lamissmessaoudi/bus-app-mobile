// ignore_for_file: prefer__ructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/auth/signin/signin_controller.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class SigninPage extends GetView<SigninController> {
  SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<SigninController>(
          init: SigninController(),
          initState: (_) {},
          builder: (controller) {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 500,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Image.asset(
                        Assets.logoSofrecom,
                        height: 200,
                      ),
                      Form(
                        key: controller.formKey1,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "E-mail",
                                style: AppTextStyles.primarySlab17,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: controller.loginController,
                              focusColor: AppColors.accentColor,
                              borderColor: AppColors.primaryColor,
                              errorColor: AppColors.errorColor,
                              validator: controller.validateEmail,
                              inputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Mot de passe",
                                  style: AppTextStyles.primarySlab17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: controller.passwordController,
                              focusColor: AppColors.accentColor,
                              borderColor: AppColors.primaryColor,
                              errorColor: AppColors.errorColor,
                              validator: controller.validateMDP,
                              obscureText: controller.mdpVis.value,
                              minLines: 1,
                              suffixIcon: GestureDetector(
                                onTap: controller.toggleVisibility,
                                child: Icon(
                                  controller.mdpVis.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.inactiveText,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                              text: "Connexion",
                              onTap: () {
                                // Get.toNamed(Routes.roles);
                                print("BTN IS PRESSESD !!");

                                controller.signInUser();
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Vous n’avez pas un compte? ",
                                    style: AppTextStyles.primarySlab17),
                                InkWell(
                                  child: Text(
                                    "Activer",
                                    style: AppTextStyles.primarySlab17.copyWith(
                                        decoration: TextDecoration.underline),
                                  ),
                                  onTap: () => Get.toNamed(Routes.activate),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              child: Text(
                                "Mot de passe oublié?",
                                style: AppTextStyles.primarySlab14.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                Get.toNamed(Routes.roles);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
