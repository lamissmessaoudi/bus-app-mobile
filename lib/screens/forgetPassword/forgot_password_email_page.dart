import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class ForgetPasswordEmailPage extends StatelessWidget {
  const ForgetPasswordEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: Image.asset(
            Assets.locked,
            height: 180,
          ),
        ),
        Text(
          "Un code secret seait envoyé à votre email",
          style: AppTextStyles.primarySlab24,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Votre email:",
            style: AppTextStyles.primarySlab17,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Form(
          // key: controller.formKeyRecuperEmail,
          child: Column(
            children: [
              CustomTextField(
                controller: controller.emailController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.primaryColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmail,
                inputType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        CustomButton(
          text: "Envoyer le Code",
          width: null,
          onTap: controller.getCode,
          btnType: BtnType.AccentFilled,
        ),
      ],
    );
  }
}
