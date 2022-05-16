import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';

class BusCard extends StatelessWidget {
  final String bus, arrivee, stationActuelle;
  final CircuitDto circuit;
  BusCard({
    Key? key,
    required this.bus,
    required this.circuit,
    required this.arrivee,
    required this.stationActuelle,
  }) : super(key: key);

  final controller = Get.put(HomeColabController());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  Assets.bus,
                  width: 60,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(bus, style: AppTextStyles.primarySlab24),
                    Text(
                      circuit.name,
                      style: AppTextStyles.primarySlab17,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: circuit.available
                        ? AppColors.green
                        : AppColors.errorColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: circuit.available
                      ? Text(
                          "Disponible",
                          style: AppTextStyles.primarySlab17
                              .copyWith(color: AppColors.white),
                        )
                      : Text(
                          "Complet",
                          style: AppTextStyles.primarySlab17
                              .copyWith(color: AppColors.white),
                        ),
                ),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Text(
              "Arrivée dans $arrivee",
              style: AppTextStyles.primarySlab17,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Station actuelle $stationActuelle",
                style: AppTextStyles.primarySlab17,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomButton(
                isSmall: true,
                width: null,
                text: "Visualiser",
                btnType: BtnType.AccentOutlined,
                onTap: () async {
                  controller.selectCircuit(circuit);
                  Get.toNamed(Routes.visualize);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
