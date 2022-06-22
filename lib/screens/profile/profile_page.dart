import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/profile/profile_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';
import 'package:softun_bus_mobile/widgets/custom_navigation_drawer.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';
import 'package:softun_bus_mobile/widgets/drawer_icon.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldState,
      drawer: CustomDrawer(),
      body: ConnectivityContainer(
        child: GetBuilder<ProfileController>(
            init: ProfileController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingProfile.value
                  ? CustomLoader()
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          child: Center(
                            child: Container(
                              width: 500,
                              margin: EdgeInsets.symmetric(horizontal: 35),
                              padding: EdgeInsets.only(top: 20, bottom: 10),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 35),
                                      child: Text(
                                        "${controller.name} ${controller.lastname}",
                                        style: AppTextStyles.primarySlab36,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Form(
                                      onChanged: controller.setBtnState,
                                      key: controller.formKeyPerso,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nom ",
                                            style: AppTextStyles.hintPTMono18,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomTextField(
                                            controller:
                                                controller.nameController,
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
                                            "Prenom",
                                            style: AppTextStyles.hintPTMono18,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomTextField(
                                            controller:
                                                controller.lastnameController,
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
                                            style: AppTextStyles.hintPTMono18,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomTextField(
                                            controller:
                                                controller.emailController,
                                            focusColor: AppColors.accentColor,
                                            borderColor: AppColors.borderColor,
                                            errorColor: AppColors.errorColor,
                                            enabled: false,
                                            validator: controller.validateEmail,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Téléphone",
                                            style: AppTextStyles.hintPTMono18,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomTextField(
                                            controller:
                                                controller.phoneController,
                                            inputType: TextInputType.number,
                                            focusColor: AppColors.accentColor,
                                            borderColor: AppColors.borderColor,
                                            errorColor: AppColors.errorColor,
                                            validator: controller.validatePhone,
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
                                            style: AppTextStyles.hintPTMono18,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          DropdownButtonFormField(
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              focusColor: AppColors.accentColor,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.borderColor,
                                                  width: 2.0,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.accentColor,
                                                  width: 2.0,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.errorColor,
                                                  width: 2.0,
                                                ),
                                              ),
                                              filled: true,
                                            ),
                                            value: controller.chosenStation,
                                            onChanged: controller.selectStation,
                                            selectedItemBuilder:
                                                (BuildContext context) {
                                              return controller.stationsList
                                                  .map<Widget>((Station item) {
                                                return Text(item.name);
                                              }).toList();
                                            },
                                            items: controller.stationsList
                                                .map<DropdownMenuItem<Station>>(
                                                    (Station valueItem) {
                                              return DropdownMenuItem(
                                                  value: valueItem,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 3),
                                                        child: Text(
                                                          valueItem.name,
                                                          style: AppTextStyles
                                                              .primarySlab17,
                                                        ),
                                                      ),
                                                      Text(
                                                        valueItem.description,
                                                        style: AppTextStyles
                                                            .primarySlab14,
                                                      )
                                                    ],
                                                  ));
                                            }).toList(),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: CustomButton(
                                              text: "Confirmer",
                                              onTap: controller.updatePerso,
                                              btnType: controller
                                                      .activeBtnPerso.value
                                                  ? BtnType.AccentOutlined
                                                  : BtnType.Inactive,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ancien mot de passe ",
                                          style: AppTextStyles.hintPTMono18,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextField(
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
                                              onTap: () =>
                                                  controller.toggleVisibility(
                                                      controller.oldMdpVis),
                                              child: Icon(
                                                controller.oldMdpVis.value
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                                color: AppColors.inactiveText,
                                              ),
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Nouveau mot de passe ",
                                          style: AppTextStyles.hintPTMono18,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextField(
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
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Confirmer le mot de passe ",
                                          style: AppTextStyles.hintPTMono18,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextField(
                                            controller:
                                                controller.conMDPController,
                                            focusColor: AppColors.accentColor,
                                            borderColor: AppColors.borderColor,
                                            errorColor: AppColors.errorColor,
                                            validator: controller
                                                .validateConfirmedPassword,
                                            obscureText:
                                                controller.conMdpVis.value,
                                            minLines: 1,
                                            suffixIcon: GestureDetector(
                                              onTap: () =>
                                                  controller.toggleVisibility(
                                                      controller.conMdpVis),
                                              child: Icon(
                                                controller.conMdpVis.value
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                                color: AppColors.inactiveText,
                                              ),
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: CustomButton(
                                            text: "Changer le mot de passe ",
                                            onTap: () {
                                              controller.updatePassword(
                                                  controller.formKeyMDP);
                                            },
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
                          ),
                        ),
                        DrawerIcon(scaffoldState: scaffoldState)
                      ],
                    );
            }),
      ),
    );
  }
}
