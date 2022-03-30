import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/profile/profile_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_dialog.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<ProfileController>(
            init: ProfileController(),
            initState: (_) {},
            builder: (controller) {
              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          "Bonjour ${controller.name} ",
                          style: AppTextStyles.primarySlab36,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Image.asset(Assets.done),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          widthFactor: 50,
                          child: Text(
                            "Votre compte est bien activé ! ",
                            style: AppTextStyles.primarySlab24,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Voulez vous changer le mot de passe ? ",
                              style: AppTextStyles.primarySlab17,
                            ),
                          ),
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialog(
                              child: Form(
                                key: controller.formKeyMDPwelcome,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Changer le mot de passe',
                                        style: AppTextStyles.primarySlab24,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      "Ancien mot de passe ",
                                      style: AppTextStyles.hintPTMono18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                          controller:
                                              controller.oldMDPController,
                                          focusColor: AppColors.accentColor,
                                          borderColor: AppColors.borderColor,
                                          errorColor: AppColors.errorColor,
                                          validator:
                                              controller.validatePassword,
                                          obscureText:
                                              controller.oldMdpVis.value,
                                          minLines: 1,
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              controller.toggleVisibility(
                                                  controller.oldMdpVis);
                                              controller.update();
                                            },
                                            child: Icon(
                                              controller.oldMdpVis.value
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: AppColors.inactiveText,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Nouveau mot de passe ",
                                      style: AppTextStyles.hintPTMono18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                          controller:
                                              controller.newMDPController,
                                          focusColor: AppColors.accentColor,
                                          borderColor: AppColors.borderColor,
                                          errorColor: AppColors.errorColor,
                                          validator:
                                              controller.validateNewPassword,
                                          obscureText:
                                              controller.newMdpVis.value,
                                          minLines: 1,
                                          suffixIcon: GestureDetector(
                                            onTap: () =>
                                                controller.toggleVisibility(
                                                    controller.newMdpVis),
                                            child: Icon(
                                              controller.newMdpVis.value
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: AppColors.inactiveText,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Confirmer le mot de passe ",
                                      style: AppTextStyles.hintPTMono18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        controller: controller.conMDPController,
                                        focusColor: AppColors.accentColor,
                                        borderColor: AppColors.borderColor,
                                        errorColor: AppColors.errorColor,
                                        validator: controller
                                            .validateConfirmedPassword,
                                        obscureText: controller.conMdpVis.value,
                                        minLines: 1,
                                        suffixIcon: GestureDetector(
                                          onTap: () =>
                                              controller.toggleVisibility(
                                                  controller.conMdpVis),
                                          child: Icon(
                                            controller.conMdpVis.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: AppColors.inactiveText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.accentColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: InkWell(
                                              splashColor:
                                                  AppColors.accentColor,
                                              onTap: () async {
                                                await controller.updatePassword(
                                                    controller
                                                        .formKeyMDPwelcome);
                                                if (controller.updatedPassword
                                                        .value ==
                                                    true) {
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                  controller
                                                      .emptyPasswordFields();
                                                  controller.updatedPassword
                                                      .value = false;
                                                  controller.update();
                                                }
                                              },
                                              child: Ink(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.accentColor,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30,
                                                      vertical: 10.0),
                                                  child: Text(
                                                    "Confirmer",
                                                    style: AppTextStyles
                                                        .primarySlab20
                                                        .copyWith(
                                                            color: AppColors
                                                                .white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          CustomButton(
                                            text: "Annuler ",
                                            onTap: () {
                                              Navigator.pop(context, 'Cancel');
                                              controller.emptyPasswordFields();
                                            },
                                            btnType: BtnType.AccentOutlined,
                                            width: null,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          text: "Continuer",
                          onTap: () => Get.toNamed(Routes.initial),
                          btnType: BtnType.AccentOutlined,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
