import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/demande_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_station_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/card_request.dart';

class RequestListPage extends StatelessWidget {
  const RequestListPage({Key? key}) : super(key: key);

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
        SizedBox(height: 30),
        controller.demandeList.isEmpty
            ? Column(
                children: [
                  Text(
                    "Vous n'avez pas encore envoyé des demandes",
                    style: AppTextStyles.primarySlab20,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Image.asset(
                      Assets.emptyBox,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    "Si vous voulez ajouter une station, \n créez une demande ",
                    style: AppTextStyles.primarySlab17,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  CustomButton(
                    text: "Créer la demande",
                    width: null,
                    onTap: () {
                      controller.step.value = RequestStep.requestForm;
                      controller.update();
                    },
                    btnType: BtnType.AccentFilled,
                  )
                ],
              )
            : Column(
                children: [
                  getRequestCards(controller.demandeList),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      text: "Créer une demande",
                      width: null,
                      btnType: BtnType.AccentOutlined,
                      onTap: () {
                        controller.step.value = RequestStep.requestForm;
                        controller.update();
                      },
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

getRequestCards(List<Demande>? list) {
  return Column(children: [
    SizedBox(),
    ...?list?.map(
      (item) => RequestCard(demande: item),
    )
  ]);
}
