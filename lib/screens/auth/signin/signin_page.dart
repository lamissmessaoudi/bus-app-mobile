// ignore_for_file: prefer__ructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/auth/signin/signin_controller.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class SigninPage extends GetView<SigninController> {
  SigninPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    var test = false;

    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<SigninController>(
          init: SigninController(),
          initState: (_) {},
          builder: (controller) {
            return test
                ? Center(
                    child: InkWell(
                        onTap: () => Get.toNamed(Routes.initial),
                        child: Container(
                          child: Text(
                            "Sign in",
                            style: AppTextStyles.primarySlab24,
                          ),
                          height: 50,
                          color: AppColors.saumonColor,
                        )),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        Image.asset(
                          Assets.logoSofrecom,
                          height: 200,
                        ),
                        Form(
                            key: controller.formKey1,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.loginController,
                                  focusNode: controller.focusNode,
                                  decoration: InputDecoration(
                                    // floatingLabelBehavior:
                                    //     FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        color: controller.focusNode.hasFocus
                                            ? AppColors.accentColor
                                            : Colors.grey),
                                    labelText: "Login",

                                    // hintText: "HINT",
                                    focusColor: AppColors.accentColor,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.accentColor,
                                          width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.errorColor,
                                          width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                TextFormField(
                                  controller: controller.passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "please_enter_your_password".tr;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.accentColor,
                                        width: 2.0,
                                      ),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.errorColor,
                                          width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
