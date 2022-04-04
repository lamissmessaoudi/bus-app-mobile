import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class ForgetPasswordCodePage extends StatelessWidget {
  const ForgetPasswordCodePage({Key? key}) : super(key: key);

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
          key: controller.formKeyRecuperCode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Entrez le code",
                style: AppTextStyles.hintPTMono18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: controller.code1Controller,
                      focusColor: AppColors.accentColor,
                      borderColor: AppColors.borderColor,
                      errorColor: AppColors.errorColor,
                      validator: controller.validateCode,
                      minLines: 1,
                      isCode: true,
                      hint: "_",
                    ),
                  ),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: controller.code2Controller,
                      focusColor: AppColors.accentColor,
                      borderColor: AppColors.borderColor,
                      errorColor: AppColors.errorColor,
                      validator: controller.validateCode,
                      minLines: 1,
                      isCode: true,
                      hint: "_",
                    ),
                  ),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: controller.code3Controller,
                      focusColor: AppColors.accentColor,
                      borderColor: AppColors.borderColor,
                      errorColor: AppColors.errorColor,
                      validator: controller.validateCode,
                      minLines: 1,
                      isCode: true,
                      hint: "_",
                    ),
                  ),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: controller.code4Controller,
                      focusColor: AppColors.accentColor,
                      borderColor: AppColors.borderColor,
                      errorColor: AppColors.errorColor,
                      validator: controller.validateCode,
                      minLines: 1,
                      isCode: true,
                      hint: "_",
                    ),
                  )
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(
                    text: "Re-envoyer le code",
                    width: null,
                    onTap: controller.getCode,
                    btnType: BtnType.PrimaryOutline,
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CustomButton(
                  text: "Suivant",
                  onTap: controller.sendCode,
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
