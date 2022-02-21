import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/profile/profile_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/btn_grey.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<ProfileController>(
            init: ProfileController(),
            initState: (_) {},
            builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          child: Image.asset(
                            Assets.user,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Ahmed Ahmed",
                            style: AppTextStyles.primarySlab36,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                          key: controller.formKeyPerso,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nom & Prenom",
                                style: AppTextStyles.hintPTMono1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: controller.nameController,
                                focusColor: AppColors.accentColor,
                                borderColor: AppColors.borderColor,
                                errorColor: AppColors.errorColor,
                                validator: controller.validateEmpty,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "E-mail",
                                style: AppTextStyles.hintPTMono1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: controller.emailController,
                                focusColor: AppColors.accentColor,
                                borderColor: AppColors.borderColor,
                                errorColor: AppColors.errorColor,
                                validator: controller.validateEmail,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Telephone",
                                style: AppTextStyles.hintPTMono1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: controller.telController,
                                focusColor: AppColors.accentColor,
                                borderColor: AppColors.borderColor,
                                errorColor: AppColors.errorColor,
                                validator: controller.validateEmpty,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Station",
                                style: AppTextStyles.hintPTMono1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: controller.stationController,
                                focusColor: AppColors.accentColor,
                                borderColor: AppColors.borderColor,
                                errorColor: AppColors.errorColor,
                                validator: controller.validateEmpty,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: CustomButton(
                                  text: "Confirmer",
                                  onTap: controller.updatePerso,
                                  btnType: BtnType.AccentOutlined,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: controller.formKeyMDP,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ancien mot de passe ",
                              style: AppTextStyles.hintPTMono1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: controller.oldMDPController,
                              focusColor: AppColors.accentColor,
                              borderColor: AppColors.borderColor,
                              errorColor: AppColors.errorColor,
                              validator: controller.validatePassword,
                              obscureText: true,
                              suffixIcon: Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Nouveau mot de passe ",
                              style: AppTextStyles.hintPTMono1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: controller.newMDPController,
                              focusColor: AppColors.accentColor,
                              borderColor: AppColors.borderColor,
                              errorColor: AppColors.errorColor,
                              validator: controller.validatePassword,
                              obscureText: true,
                              suffixIcon: Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Confirmer le mot de passe ",
                              style: AppTextStyles.hintPTMono1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: controller.conMDPController,
                              focusColor: AppColors.accentColor,
                              borderColor: AppColors.borderColor,
                              errorColor: AppColors.errorColor,
                              validator: controller.validateConfirmedPassword,
                              obscureText: true,
                              suffixIcon: Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: CustomButton(
                                text: "Changer le mot de passe ",
                                onTap: controller.updatePassword,
                                btnType: BtnType.AccentOutlined,
                                width: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
