import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';

class ForgetPasswordSuccessPage extends StatelessWidget {
  const ForgetPasswordSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Récupération finie",
            style: AppTextStyles.primarySlab36,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 40),
          child: Image.asset(
            Assets.shield,
            height: 200,
          ),
        ),
        Text(
          "Mot de passe changé avec succés ",
          style: AppTextStyles.primarySlab24,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        CustomButton(
          text: "Se connecter",
          width: null,
          onTap: () {
            Get.toNamed(Routes.signin);
          },
          btnType: BtnType.AccentFilled,
        ),
      ],
    );
  }
}
