import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_station_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';

class RequestSuccessPage extends StatelessWidget {
  const RequestSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestStationController());
    return Column(
      children: [
        Center(
          child: Text(
            "Vos Demandes",
            style: AppTextStyles.primarySlab36,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 40),
          child: Image.asset(
            Assets.sent,
            height: 200,
          ),
        ),
        Text(
          "Demande envoyée avec succés ",
          style: AppTextStyles.primarySlab24,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        CustomButton(
          text: "Retourner",
          width: null,
          onTap: () {
            controller.step.value = RequestStep.requestList;
            controller.update();
          },
          btnType: BtnType.AccentFilled,
        ),
      ],
    );
  }
}
