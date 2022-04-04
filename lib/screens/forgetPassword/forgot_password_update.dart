import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class ForgetPasswordUpdatePage extends StatelessWidget {
  const ForgetPasswordUpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
          ),
          child: Image.asset(
            Assets.locked,
            height: 180,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            controller.emailController.text,
            style: AppTextStyles.primarySlab24,
            textAlign: TextAlign.center,
          ),
        ),
        Form(
          // key: controller.formKeyRecuperPassword,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                "Nouveau mot de passe ",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: controller.newMDPController,
                  focusColor: AppColors.accentColor,
                  borderColor: AppColors.borderColor,
                  errorColor: AppColors.errorColor,
                  validator: controller.validateNewPassword,
                  obscureText: controller.newMdpVis.value,
                  minLines: 1,
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        controller.toggleVisibility(controller.newMdpVis),
                    child: Icon(
                      controller.newMdpVis.value
                          ? Icons.visibility_off_outlined
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
                  controller: controller.conMDPController,
                  focusColor: AppColors.accentColor,
                  borderColor: AppColors.borderColor,
                  errorColor: AppColors.errorColor,
                  validator: controller.validateConfirmedPassword,
                  obscureText: controller.conMdpVis.value,
                  minLines: 1,
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        controller.toggleVisibility(controller.conMdpVis),
                    child: Icon(
                      controller.conMdpVis.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.inactiveText,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CustomButton(
                  text: "Suivant",
                  onTap: () {
                    controller.updatePassword();
                  },
                  btnType: BtnType.AccentFilled,
                  width: null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
