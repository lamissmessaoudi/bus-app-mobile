import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/activation/activation_controller.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class ActiveConfiramation extends StatefulWidget {
  const ActiveConfiramation({
    Key? key,
  }) : super(key: key);

  @override
  _ActiveConfiramationState createState() => _ActiveConfiramationState();
}

class _ActiveConfiramationState extends State<ActiveConfiramation> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActivationController());

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Nom ",
              style: AppTextStyles.accentPTMono18,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: controller.nameController,
              focusColor: AppColors.accentColor,
              borderColor: AppColors.borderColor,
              errorColor: AppColors.errorColor,
              enabled: false,
              suffixIcon: Icon(
                Icons.edit,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Prénom",
              style: AppTextStyles.accentPTMono18,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: controller.lastnameController,
              focusColor: AppColors.accentColor,
              borderColor: AppColors.borderColor,
              errorColor: AppColors.errorColor,
              enabled: false,
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
              style: AppTextStyles.accentPTMono18,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: controller.emailController,
              focusColor: AppColors.accentColor,
              borderColor: AppColors.borderColor,
              errorColor: AppColors.errorColor,
              enabled: false,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Téléphone",
              style: AppTextStyles.accentPTMono18,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: controller.phoneController,
              inputType: TextInputType.number,
              focusColor: AppColors.accentColor,
              borderColor: AppColors.borderColor,
              errorColor: AppColors.errorColor,
              enabled: false,
              suffixIcon: Icon(
                Icons.edit,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Poste",
              style: AppTextStyles.accentPTMono18,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: controller.posteController,
              focusColor: AppColors.accentColor,
              borderColor: AppColors.borderColor,
              errorColor: AppColors.errorColor,
              enabled: false,
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
              style: AppTextStyles.accentPTMono18,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: controller.stationController,
              focusColor: AppColors.accentColor,
              borderColor: AppColors.borderColor,
              errorColor: AppColors.errorColor,
              enabled: false,
              suffixIcon: Icon(
                Icons.edit,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: AppColors.borderColor,
            //     ),
            //   ),
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           "${controller.activedUser.name} ${controller.activedUser.name}",
            //           // "Ahmed ahmed ",
            //           style: AppTextStyles.hintPTMono18,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           controller.activedUser.email,
            //           style: AppTextStyles.hintPTMono18,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           controller.activedUser.poste,
            //           style: AppTextStyles.hintPTMono18,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           controller.activedUser.station.name,
            //           style: AppTextStyles.hintPTMono18,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Form(
            //   key: controller.formKeyPassword,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: 20,
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Text(
            //         "Mot de passe ",
            //         style: AppTextStyles.hintPTMono18,
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       CustomTextField(
            //         controller: controller.newMDPController,
            //         focusColor: AppColors.accentColor,
            //         borderColor: AppColors.borderColor,
            //         errorColor: AppColors.errorColor,
            //         validator: controller.validateNewPassword,
            //         obscureText: controller.newMdpVis.value,
            //         suffixIcon: GestureDetector(
            //           onTap: () =>
            //               controller.toggleVisibility(controller.newMdpVis),
            //           child: Icon(
            //             controller.newMdpVis.value
            //                 ? Icons.visibility_off_outlined
            //                 : Icons.visibility_outlined,
            //             color: AppColors.inactiveText,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Text(
            //         "Confirmer le mot de passe ",
            //         style: AppTextStyles.hintPTMono18,
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       CustomTextField(
            //           controller: controller.conMDPController,
            //           focusColor: AppColors.accentColor,
            //           borderColor: AppColors.borderColor,
            //           errorColor: AppColors.errorColor,
            //           validator: controller.validateConfirmedPassword,
            //           obscureText: controller.conMdpVis.value,
            //           suffixIcon: GestureDetector(
            //             onTap: () =>
            //                 controller.toggleVisibility(controller.conMdpVis),
            //             child: Icon(
            //               controller.conMdpVis.value
            //                   ? Icons.visibility_off_outlined
            //                   : Icons.visibility_outlined,
            //               color: AppColors.inactiveText,
            //             ),
            //           )),
            //       SizedBox(
            //         height: 20,
            //       ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                    text: "Retour",
                    onTap: controller.returnPage,
                    btnType: BtnType.AccentOutlined),
                CustomButton(
                    text: "Suivant",
                    onTap: controller.activate,
                    btnType: BtnType.AccentFilled),
              ],
            ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
